" Prefer ripgrep for fuzzy finding
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files'
endif
