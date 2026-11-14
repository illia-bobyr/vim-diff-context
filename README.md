# vim-diff-context

Grow and shrink the number of context lines Vim shows around changes in diff
mode, with a keystroke.

Vim folds unchanged lines in diff mode, keeping a few lines of context around
each change. That amount is the `context:` item of `'diffopt'`. This plugin
adjusts it in place, leaving the rest of `'diffopt'` alone.

## Installation

With [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'illia-bobyr/vim-diff-context'
```

With Vim's native packages:

```sh
git clone https://github.com/illia-bobyr/vim-diff-context \
  ~/.vim/pack/plugins/start/vim-diff-context
vim -u NONE -c 'helptags ~/.vim/pack/plugins/start/vim-diff-context/doc' -c q
```

Works in Vim and Neovim.

## Usage

Default bindings, in Normal mode:

- `<Leader>d+` -- increase the context by one line (`[count]` multiplies).
- `<Leader>d-` -- decrease the context by one line, never below 0.
- `<Leader>d=` -- reset the context to the default (6 lines).

A binding is only created when its key is not already mapped to something else,
and when you have not mapped the plugin's `<Plug>` mapping yourself.

The `:DiffContext` command does the same from the command line:

```vim
:DiffContext       " show the current context
:DiffContext 10    " set it to 10 lines
:DiffContext +3    " increase by 3
:DiffContext -3    " decrease by 3
```

## Configuration

Set these in your `vimrc`, before the plugin loads:

```vim
" Use other keys.  An empty string skips that binding.
let g:diff_context_increase_map = '<Leader>c+'
let g:diff_context_decrease_map = '<Leader>c-'
let g:diff_context_reset_map = ''

" Or skip all default bindings and map the <Plug> mappings yourself.
let g:diff_context_no_mappings = 1
nmap ]= <Plug>(diff-context-increase)
nmap [= <Plug>(diff-context-decrease)
nmap == <Plug>(diff-context-reset)

let g:diff_context_step = 3     " lines per step (default 1)
let g:diff_context_default = 6  " context when 'diffopt' has none, and reset value
let g:diff_context_quiet = 1    " don't echo the new value
```

See `:help diff-context` for the full reference.

## License

MIT, see [LICENSE](LICENSE).
