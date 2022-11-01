-- org.lua
local status_ok, orgmode = pcall(require, "orgmode")
if not status_ok then
  return
end

-- Load custom tree-sitter grammar for org filetype
orgmode.setup_ts_grammar()

-- Tree-sitter configuration
require("nvim-treesitter.configs").setup({
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = { "org" }, -- Or run :TSUpdate org
})

orgmode.setup({

  org_agenda_files = { "~/notes/org/*", "~/notes/org/**/*" },
  org_default_notes_file = "~/notes/refile.org",

  org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "DONE(d)" },
  org_todo_keyword_faces = {
    WAITING = ":background #806731 :foreground #0b1610 :weight bold",
    DONE = ":background #416644 :foreground #0b1610 :slant italic",
    TODO = ":background #326777 :foreground #0b1610 :weight bold",
  },
  org_capture_templates = {
    t = {
      description = "Task",
      template = "* TODO %?\n  %u",
      target = "~/notes/org/tasks.org",
    },
    j = {
      description = "Journal",
      template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
      -- target = '~/notes/org/org' %(os.date('%Y-%m-%d'))
      target = "~/notes/org/" .. os.date("%Y-%m-%d") .. ".org",
    },
    -- { n = "Notes",
    --
    --   nw = {
    --   description = "work",
    --   target = "~/notes/org/work/notes.org"
    --
    --   },
    --
    --   nh = {
    --   description = "home",
    --   target = "~/notes/org/home/notes.org"
    --
    --   } },

    n = {
      description = "Notes",
      template = "\n*** %<%Y-%m-%d> %<%A>\n**** \n\n%?",
      target = "~/notes/org/notes.org",
    },
    {
      e = "Event",
      er = {
        description = "recurring",
        template = "** %?\n %T",
        target = "~/notes/org/calendar.org",
        headline = "recurring",
      },
      eo = {
        description = "one-time",
        template = "** %?\n %T",
        target = "~/notes/org/calendar.org",
        headline = "one-time",
      },
    },
  },
})

lvim.builtin.which_key.mappings["o"] = {
  name = "Org Mode",
}
