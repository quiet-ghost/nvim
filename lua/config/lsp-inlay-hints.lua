-- Fix for inlay hints errors when deleting lines or changing modes
local M = {}

function M.setup()
  -- Track if we're in a deletion operation
  local deleting = false
  
  -- Safely handle inlay hints with error protection
  local function safe_inlay_hints(bufnr, enable)
    local ok, _ = pcall(function()
      if vim.lsp.inlay_hint and vim.api.nvim_buf_is_valid(bufnr) then
        vim.lsp.inlay_hint.enable(enable, { bufnr = bufnr })
      end
    end)
  end

  -- Override the default on_attach for LSP clients
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf
      
      if client and client.server_capabilities.inlayHintProvider then
        -- Enable inlay hints initially
        safe_inlay_hints(bufnr, true)
        
        -- Only disable hints during actual deletion operations
        vim.keymap.set({'n', 'v'}, 'd', function()
          deleting = true
          safe_inlay_hints(bufnr, false)
          vim.defer_fn(function()
            deleting = false
            safe_inlay_hints(bufnr, true)
          end, 500)
          return 'd'
        end, { buffer = bufnr, expr = true })
        
        vim.keymap.set({'n', 'v'}, 'x', function()
          deleting = true
          safe_inlay_hints(bufnr, false)
          vim.defer_fn(function()
            deleting = false
            safe_inlay_hints(bufnr, true)
          end, 500)
          return 'x'
        end, { buffer = bufnr, expr = true })
        
        vim.keymap.set({'n', 'v'}, 'c', function()
          deleting = true
          safe_inlay_hints(bufnr, false)
          vim.defer_fn(function()
            deleting = false
            safe_inlay_hints(bufnr, true)
          end, 500)
          return 'c'
        end, { buffer = bufnr, expr = true })
      end
    end,
  })
  
  -- Wrap the built-in inlay hint handler for extra safety
  local original_handler = vim.lsp.handlers["textDocument/inlayHint"]
  if original_handler then
    vim.lsp.handlers["textDocument/inlayHint"] = function(err, result, ctx, config)
      local ok, _ = pcall(original_handler, err, result, ctx, config)
    end
  end
end

return M
