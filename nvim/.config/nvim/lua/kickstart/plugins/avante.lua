local tavily_api_key = os.getenv 'TAVILY_API_KEY'
local groq_api_key = os.getenv 'GROQ_API_KEY'
local prefix = '<Leader>a'
return {
  'yetone/avante.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('avante').setup {
      -- Use Claude 3.7 Sonnet as the default provider (same as Cursor)
      provider = 'claude',
      -- Use Groq with llama model for applying changes (much faster and more accurate)
      cursor_applying_provider = 'groq',
      claude = {
        model = 'claude-3-7-sonnet-20250219',
        temperature = 0,
        max_tokens = 20480,
      },
      -- Configure UI to be similar to Cursor's chat
      windows = {
        position = 'right', -- Place chat on the right side like Cursor
        width = 40, -- Slightly wider panel
        sidebar_header = {
          enabled = true,
          align = 'center',
          rounded = true,
        },
        input = {
          prefix = '> ',
          height = 10, -- Taller input area like Cursor
        },
        ask = {
          floating = false, -- Integrated window like Cursor, not floating
          border = 'rounded',
          start_insert = true,
          focus_on_apply = 'ours',
        },
      },
      -- Configure behavior
      behaviour = {
        auto_focus_sidebar = true,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        minimize_diff = true,
        enable_token_counting = true,
        enable_claude_text_editor_tool_mode = true, -- Enable Claude's text editor tool mode
        enable_cursor_planning_mode = true, -- Enable Cursor planning mode
        auto_apply_diff_after_generation = true, -- Auto-apply code changes like Cursor
      },
      -- Enable web search like Cursor has
      web_search_engine = {
        provider = 'tavily', -- Modern search engine
        providers = {
          tavily = {
            api_key_name = tavily_api_key,
          },
        },
      },
      file_selector = {
        provider = 'telescope',
        provider_opts = {},
      },
      mappings = {
        ask = prefix .. '<CR>',
        edit = prefix .. 'e',
        refresh = prefix .. 'r',
        focus = prefix .. 'f',
        toggle = {
          default = prefix .. 't',
          debug = prefix .. 'd',
          hint = prefix .. 'h',
          suggestion = prefix .. 's',
          repomap = prefix .. 'R',
        },
        diff = {
          next = ']c',
          prev = '[c',
        },
        files = {
          add_current = prefix .. '.',
        },
      },
      -- Define Groq provider for code application
      vendors = {
        groq = {
          __inherited_from = 'openai',
          api_key_name = groq_api_key,
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_completion_tokens = 32768, -- Increased token limit to avoid truncation
        },
      },
    }
  end,
}
