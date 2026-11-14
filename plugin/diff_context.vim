" vim-diff-context: adjust the diff context ('diffopt' "context:") with hotkeys.
" Maintainer: Illia Bobyr
" License:    MIT, see LICENSE.

if exists('g:loaded_diff_context') || &compatible
  finish
endif
let g:loaded_diff_context = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? -bar DiffContext call diff_context#command(<q-args>)

nnoremap <silent> <Plug>(diff-context-increase)
      \ :<C-u>call diff_context#adjust(v:count1 * get(g:, 'diff_context_step', 1))<CR>
nnoremap <silent> <Plug>(diff-context-decrease)
      \ :<C-u>call diff_context#adjust(-v:count1 * get(g:, 'diff_context_step', 1))<CR>
nnoremap <silent> <Plug>(diff-context-reset)
      \ :<C-u>call diff_context#set(get(g:, 'diff_context_default', 6))<CR>

" Binds `lhs` to `plug`, unless the user already mapped `plug` somewhere, or
" `lhs` is already taken by another mapping.  An empty `lhs` disables it.
function! s:map(lhs, plug) abort
  if a:lhs ==# '' || hasmapto(a:plug, 'n') || maparg(a:lhs, 'n') !=# ''
    return
  endif
  execute 'nmap' a:lhs a:plug
endfunction

if !get(g:, 'diff_context_no_mappings', 0) && !get(g:, 'no_plugin_maps', 0)
  call s:map(get(g:, 'diff_context_increase_map', '<Leader>d+'),
        \ '<Plug>(diff-context-increase)')
  call s:map(get(g:, 'diff_context_decrease_map', '<Leader>d-'),
        \ '<Plug>(diff-context-decrease)')
  call s:map(get(g:, 'diff_context_reset_map', '<Leader>d='),
        \ '<Plug>(diff-context-reset)')
endif

let &cpo = s:save_cpo
unlet s:save_cpo
