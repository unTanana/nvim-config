local M = {}

-- in-memory cache of last fetched route names
local cache = {
  routes = nil, -- array of strings
  ts = 0,       -- monotonic timestamp of last fetch
  root = nil,   -- project root containing artisan
}

-- restrict availability to PHP/Blade and TSX (when used in Laravel frontends)
local function is_target_buf()
  local ft = vim.bo.filetype
  return ft == "php" or ft == "blade" or ft == "blade.php" or ft == "typescriptreact" or ft == "tsx"
end

-- walk up from cwd to find an artisan file, treat that dir as Laravel root
local function find_root(start)
  local dir = start or vim.fn.getcwd()
  local PathSep = package.config:sub(1,1)
  local function exists(p)
    return vim.fn.filereadable(p) == 1 or vim.fn.isdirectory(p) == 1
  end
  while dir and #dir > 0 do
    if exists(dir .. "/artisan") then return dir end
    local parent = dir:match(string.format("^(.*)%s[^%s]+$", PathSep, PathSep))
    if parent == dir then break end
    dir = parent
  end
  return nil
end

-- decode artisan --json and extract unique, sorted route names
local function parse_routes(json)
  local ok, decoded = pcall(vim.json.decode, json)
  if not ok or type(decoded) ~= "table" then return {} end
  local names = {}
  for _, r in ipairs(decoded) do
    if r and r.name and r.name ~= vim.NIL and r.name ~= '' then
      names[r.name] = true
    end
  end
  local list = {}
  for name, _ in pairs(names) do
    table.insert(list, name)
  end
  table.sort(list)
  return list
end

-- run `php artisan route:list --json` asynchronously and refresh cache
local function fetch_routes(root, cb)
  if not root then return cb({}) end
  local cmd = { "php", "artisan", "route:list", "--json" }
  local stdout = {}
  local stderr = {}
  local job_id = vim.fn.jobstart(cmd, {
    cwd = root,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then table.insert(stdout, table.concat(data, "\n")) end
    end,
    on_stderr = function(_, data)
      if data then table.insert(stderr, table.concat(data, "\n")) end
    end,
    on_exit = function()
      local out = table.concat(stdout, "\n")
      local routes = parse_routes(out)
      cache.routes = routes
      cache.ts = vim.loop.now()
      cache.root = root
      cb(routes)
    end,
  })
  if job_id <= 0 then cb({}) end
end

-- get cached routes, refresh if stale (>60s) or not yet fetched
local function get_routes(cb)
  if cache.routes and (vim.loop.now() - cache.ts) < 60000 then
    return cb(cache.routes)
  end
  local root = find_root()
  if not root then return cb({}) end
  return fetch_routes(root, cb)
end

-- detect if cursor is within a route-related function call
local function get_route_context()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local before_cursor = line:sub(1, col)
  
  -- patterns for route-related functions
  local patterns = {
    { pattern = "route%s*%(%s*['\"]([%w%._-]*)", func = 'route' },
    { pattern = "url%(%)->route%s*%(%s*['\"]([%w%._-]*)", func = 'route' },
    { pattern = "action%s*%(%s*['\"]([%w%._-]*)", func = 'action' },
  }
  
  -- check for complete function calls first
  for _, p in ipairs(patterns) do
    local func_start = line:find(p.pattern:gsub("%%s%*%%(%%%%%s%*%%[", "%%s*%%(%%s*["))
    if func_start then
      local paren_start = line:find("%(", func_start)
      local quote_start = line:find("['\"]", paren_start or func_start)
      local quote_end = line:find("['\"]", (quote_start or 0) + 1)
      local paren_end = line:find("%)", quote_end or paren_start or func_start)
      
      if paren_start and paren_end and col >= paren_start and col <= paren_end then
        local match = before_cursor:match(p.pattern)
        return {
          func = p.func,
          partial = match or "",
          in_context = true
        }
      end
    end
  end
  
  -- fallback to partial matching for typing
  for _, p in ipairs(patterns) do
    local match = before_cursor:match(p.pattern)
    if match then
      return {
        func = p.func,
        partial = match,
        in_context = true
      }
    end
  end
  
  return { in_context = false }
end

-- nvim-cmp source implementation
local source = {}

function source:is_available()
  if not is_target_buf() then return false end
  if not find_root() then return false end
  local context = get_route_context()
  return context.in_context
end

function source:get_debug_name()
  return "laravel_routes"
end

-- offer completion when in route-related function context
function source:complete(params, callback)
  local context = get_route_context()
  if not context.in_context then
    callback({ items = {}, isIncomplete = false })
    return
  end
  
  get_routes(function(routes)
    local items = {}
    for _, name in ipairs(routes or {}) do
      -- filter routes based on partial match
      if context.partial == "" or name:find(context.partial, 1, true) then
        table.insert(items, { 
          label = name, 
          insertText = name, 
          kind = require('cmp').lsp.CompletionItemKind.Value,
          detail = 'Laravel ' .. context.func .. '()'
        })
      end
    end
    callback({ items = items, isIncomplete = true })
  end)
end

-- register source and auto-refresh when route files change
M.setup = function()
  local cmp = require('cmp')
  cmp.register_source('laravel_routes', source)
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { 'routes/*.php', 'app/Providers/RouteServiceProvider.php' },
    callback = function()
      local root = find_root()
      if root then fetch_routes(root, function() end) end
    end,
  })
end

return M
