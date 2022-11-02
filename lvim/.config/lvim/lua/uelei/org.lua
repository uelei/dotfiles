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

	org_agenda_files = { "~/notes/**/*",  ('%s/*.org'):format(vim.fn.getcwd())  },
	org_default_notes_file = "~/notes/refile.org",

	org_todo_keywords = { "TODO(t)", "WAITING(w)", "NEXT(n)", "|", "DONE(d)" },
	org_todo_keyword_faces = {
		WAITING = ":background #806731 :foreground #0b1610 :weight bold",
		NEXT = ":background #806731 :foreground #0b1610 :weight bold",
		DONE = ":background #416644 :foreground #0b1610 :slant italic",
		TODO = ":background #326777 :foreground #0b1610 :weight bold",
	},
	org_capture_templates = {

		n = "Notes",
		nw = {
			description = "work",
			target = "~/notes/work/w_notes.org",
			template = "\n*** %U\n\n%? \n",
		},
		nh = {
			description = "home",
			target = "~/notes/home/notes.org",
			template = "*** %U\n %? \n",
		},

		h = "Home",
		ht = {
			description = "Task",
			template = "* TODO %?\n",
			target = "~/notes/home/home.org",
		},
		hc = {
			description = "Coding",
			template = "* TODO %?\n",
			target = "~/notes/home/dev.org",
		},
		hb = {
			description = "To Buy",
			template = "* TODO %?\n",
			target = "~/notes/home/buy.org",
		},
		hw = {
			description = "Wish list",
			template = "* %?",
			target = "~/notes/home/wish.org",
		},
		hn = {
			description = "Note",
			target = "~/notes/home/notes.org",
			template = "*** %U\n %? \n",
		},

		t = "Task",
		tt = {
			description = "Task Generic",
			template = "* TODO %?\n",
			target = "~/notes/tasks.org",
		},

		tw = {
			description = "Work",
			template = "* TODO %?\n",
			target = "~/notes/work/work.org",
		},

		th = {
			description = "Home",
			template = "* TODO %?\n",
			target = "~/notes/home/home.org",
		},

		j = {
			description = "Journal",
			template = "\n*** %<%y-%m-%d> %<%a>\n**** %U\n\n%?",
			target = "~/notes/journal/" .. os.date("%Y-%m-%d") .. ".org",
		},

		w = "Work",
		wt = {
			description = "Task",
			template = "* TODO %?\n",
			target = "~/notes/work/work.org",
		},
		wn = {
			description = "Note",
			template = "\n*** %U\n\n%?",
			target = "~/notes/work/w_notes.org",
		},
	},
})

lvim.builtin.which_key.mappings["o"] = {
	name = "Org Mode",
}
