" vim-diff-context: adjust the diff context ('diffopt' "context:") with hotkeys.
" Maintainer: Illia Bobyr
" License:    MIT, see LICENSE.

let s:save_cpo = &cpo
set cpo&vim

" Returns the current diff context.  When 'diffopt' has no "context:" item,
" Vim uses 6 lines; `g:diff_context_default` overrides that assumption.
function! diff_context#get() abort
  let l:value = matchstr(&diffopt, '\%(^\|,\)context:\zs\d\+')
  return l:value ==# ''
        \ ? get(g:, 'diff_context_default', 6)
        \ : str2nr(l:value)
endfunction

" Sets the diff context to `context` lines (clamped at 0) and reports it.
function! diff_context#set(context) abort
  let l:context = max([0, a:context])
  let l:items = filter(split(&diffopt, ','), 'v:val !~# ''^context:''')
  let &diffopt = join(add(l:items, 'context:' . l:context), ',')
  if !get(g:, 'diff_context_quiet', 0)
    echo 'diff context: ' . l:context
  endif
  return l:context
endfunction

" Changes the diff context by `delta` lines.
function! diff_context#adjust(delta) abort
  return diff_context#set(diff_context#get() + a:delta)
endfunction

" Implements `:DiffContext [N | +N | -N]`.
function! diff_context#command(arg) abort
  let l:arg = trim(a:arg)
  if l:arg ==# ''
    echo 'diff context: ' . diff_context#get()
  elseif l:arg =~# '^[+-]\d\+$'
    call diff_context#adjust(str2nr(l:arg[1:]) * (l:arg[0] ==# '-' ? -1 : 1))
  elseif l:arg =~# '^\d\+$'
    call diff_context#set(str2nr(l:arg))
  else
    echohl ErrorMsg
    echomsg 'DiffContext: expected N, +N or -N, got: ' . l:arg
    echohl None
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
