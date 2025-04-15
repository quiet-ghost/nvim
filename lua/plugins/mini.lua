return {
  "echasnovski/mini.nvim",
  version = false, -- Use the latest version
  config = function()
    -- Setup mini.ai
    require("mini.ai").setup({
      n_lines = 500, -- Number of lines to scan for text objects
      custom_textobjects = {
        -- Add custom text objects (optional)
        o = vim.tbl_map(
          function(key)
            return { key .. "[%(%[{<% \"%'%`].*[%)%]}>%\"%'%`]" .. key, "^" .. key .. ".+" .. key .. "$" }
          end,
          { "{", "[", "(", "<", ">", ")", "]", "}", '"', "'", "`" }
        ), -- Brackets/quotes with padding
        f = { -- Function (works with tree-sitter)
          function()
            return require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
          end,
        },
        c = { -- Class (works with tree-sitter)
          function()
            return require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
          end,
        },
        a = { -- Argument/parameter
          function()
            return require("mini.ai").gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" })
          end,
        },
      },
      mappings = {
        -- Use defaults: `a` for around, `i` for inside
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        goto_left = "g[",
        goto_right = "g]",
      },
      silent = true, -- Silent operation
    })

    -- Setup mini.pairs
    require("mini.pairs").setup({
      mappings = {
        -- Default pairs
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ['"'] = { action = "close", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "close", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "close", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
      -- Skip autopair when in certain contexts
      skip = {
        -- Skip when in a comment or string
        comment = true,
        string = true,
      },
    })
  end,
}
