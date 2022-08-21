-- org.lua

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require 'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'org' }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = { 'org' }, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = { '~/notes/org/tasks/*', '~/notes/my-orgs/**/*' },
  org_default_notes_file = '~/notes/org/refile.org',


  org_todo_keywords = { 'TODO(t)', 'WAITING(w)', '|', 'DONE(d)' },
  org_todo_keyword_faces = {
        WAITING = ':background #806731 :foreground #0b1610 :weight bold',
        DONE = ':background #416644 :foreground #0b1610 :slant italic',
        TODO = ':background #326777 :foreground #0b1610 :weight bold',
  },
  org_capture_templates = {
        t = {
            description = 'Task',
            template = '* TODO %?\n  %u',
            target = '~/notes/org/tasks.org'
        },
        j = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/notes/org/journal.org'
        },
        n = {
            description = 'Notes',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** \n\n%?',
            target = '~/notes/org/notes.org'
        },
  },
    mappings = {
    global = {
      org_agenda = {'gA', '<Leader>oa'},
      org_capture = {'gC', '<Leader>oc'}
    }
  }
})

