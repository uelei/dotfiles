vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.yaml'] = 'helm',
    ['.*/tasks/.*.yaml'] = 'yaml.ansible',
    ['.*/tasks/.*.yml'] = 'yaml.ansible',
  },
}
