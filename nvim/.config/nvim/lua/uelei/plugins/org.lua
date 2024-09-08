-- Orgmode
return {

  { 'andreadev-it/orgmode-multi-key', opts = { key = '<leader>o<tab>' } },
  { 'akinsho/org-bullets.nvim', opts = {} },
  'danilshvalov/org-modern.nvim',
  {
    'nvim-orgmode/orgmode',
    dependecies = {},
    config = function()
      local omenu = require 'org-modern.menu'
      require('orgmode').setup {
        org_agenda_skip_scheduled_if_done = true,
        org_agenda_skip_deadline_if_done = true,

        org_agenda_files = { '~/notes/**/*', ('%s/*.org'):format(vim.fn.getcwd()) },
        org_default_notes_file = '~/notes/refile.org',

        org_todo_keywords = { 'TODO(t)', 'WAITING(w)', 'NEXT(n)', '|', 'DONE(d)', 'CANCELED(c)' },
        org_todo_keyword_faces = {
          NEXT = ':foreground yellow :weight bold',
          DONE = ':foreground green :slant italic',
          WAITING = ':foreground blue :weight bold',
          TODO = ':foreground red', -- overrides builtin color for `TODO` keyword
        },
        ui = {
          menu = {
            handler = function(data)
              omenu
                :new({
                  window = {
                    margin = { 1, 0, 1, 0 },
                    padding = { 0, 1, 0, 1 },
                    title_pos = 'center',
                    border = 'single',
                    zindex = 1000,
                  },
                  icons = {
                    separator = '➜',
                  },
                })
                :open(data)
            end,
          },
        },
        mappings = {
          org = {
            org_toggle_checkbox = '<leader>o<space>',
          },
        },
        org_capture_templates = {

          n = 'Notes',
          nw = {
            description = 'work',
            target = '~/notes/work/w_notes.org',
            template = '\n* %U\n\n%? \n',
          },
          nh = {
            description = 'home',
            target = '~/notes/home/notes.org',
            template = '* %U\n %? \n',
          },

          h = 'Home',
          ht = {
            description = 'Task',
            template = '* TODO %?\n',
            target = '~/notes/home.org',
          },
          hc = {
            description = 'Coding',
            template = '* TODO %?\n',
            target = '~/notes/home/dev.org',
          },
          hb = {
            description = 'To Buy',
            template = '* TODO %?\n',
            target = '~/notes/home/buy.org',
          },
          hw = {
            description = 'Wish list',
            template = '* %?',
            target = '~/notes/home/wish.org',
          },
          hn = {
            description = 'Note',
            target = '~/notes/home/notes.org',
            template = '* %U\n %? \n',
          },

          p = 'Project',
          pt = {
            description = 'Project Generic Task',
            template = '* TODO %?\n',
            target = ('%s/project_task.org'):format(vim.fn.getcwd()),
          },
          t = 'Task',
          tt = {
            description = 'Task Generic',
            template = '* TODO %?\n',
            target = '~/notes/tasks.org',
          },

          tw = {
            description = 'Work',
            template = '* TODO %?\n',
            target = '~/notes/work.org',
          },

          th = {
            description = 'Home',
            template = '* TODO %?\n',
            target = '~/notes/home.org',
          },

          j = {
            description = 'Journal',
            template = '\n*** %<%y-%m-%d> %<%a>\n**** %U\n\n%?',
            target = '~/notes/journal/' .. os.date '%Y-%m-%d' .. '.org',
          },

          w = 'Work',
          wt = {
            description = 'Task',
            template = '* TODO %?\n',
            target = '~/notes/work.org',
          },
          wn = {
            description = 'Note',
            template = '\n* %U\n\n%?',
            target = '~/notes/work/w_notes.org',
          },
        },
      }

      require('which-key').add {

        { '<leader>o', group = '+Org', icon = '' },
      }
    end,
  },
}
