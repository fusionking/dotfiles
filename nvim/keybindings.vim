" Changing Leader Key
nnoremap <Space> <nop>
let mapleader = ","
let maplocalleader = "\,"

function! s:unite_bindings()
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-r>   <Plug>(unite_redraw)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction

function! s:python_bindings()
  nnoremap <silent> <leader>md :call jedi#goto()<cr>
  nnoremap <silent> <leader>mD :vs<cr><C-w><C-l>:call jedi#goto()<cr>
  nnoremap <silent> <leader>mg :call jedi#goto_assignments()<cr>
  nnoremap <silent> <leader>mr :call jedi#rename()<cr>
  nnoremap <silent> <leader>mn :call jedi#usages()<cr>
  nnoremap <silent> <leader>mV :VirtualEnvActivate 
endfunction

function! s:haskell_bindings()
  nnoremap <Leader>mt :GhcModType<CR>
  nnoremap <Leader>mi :GhcModInfo<CR>
  nnoremap <Leader>mI :GhcModInfoPreview<CR>
  nnoremap <Leader>mc :GhcModTypeClear<CR>
endfunction

function! s:go_bindings()
	nmap <leader>md <Plug>(go-def)
	nmap <leader>mt <Plug>(go-info)
	nmap <leader>mi <Plug>(go-info)
	nmap <leader>mr <Plug>(go-rename)
endfunction

function! s:rust_bindings()
	nmap <buffer><leader>md <Plug>RacerGoToDefinitionDrect
	nmap <buffer><leader>mD <Plug>RacerGoToDefinitionSplit
	nmap <buffer><leader>mi <Plug>RacerShowDocumentation
endfunction

function! s:js_bindings()
  nnoremap <silent> <Leader>md :TernDef<CR>
  nnoremap <leader>mr :TernRename<cr>
  nnoremap <silent> <leader>gf :call JsBeautify()<cr>
endfunction

function! s:general_bindings()
	" vim handles long lines nicely with these
	nnoremap j gj
	nnoremap k gk

	" files
	nmap <leader>ft <ESC>:TagbarToggle<cr>
	nmap <leader>fs <ESC>:w<cr>
	nnoremap <silent> <leader>ff :FFFiles<cr>
	nnoremap <silent> <leader>fg :FFGFiles?<cr>
	nnoremap <silent> <leader>fj :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
	" to remove white space from a file.
	nnoremap <leader>fW :%s/\s\+$//<cr>:let @/=''<CR>

	" buffers
	nnoremap <silent> <leader>bb :FFBuffers<cr>
	nnoremap <leader><tab> :b#<CR>

	" search
	nnoremap n nzzzv
	nnoremap N Nzzzv
	nnoremap <leader>ss :Grepper -tool ag -quickfix -open -switch -nojump -prompt<cr>
	nnoremap <leader>sS :Grepper -side -tool rg -prompt<cr>
	nnoremap <silent><BS> :noh<cr>
	nmap sg  <plug>(GrepperOperator)
	xmap sg  <plug>(GrepperOperator)
	nnoremap <leader>* :Grepper -cword -noprompt<cr>

	" for browsing the input history
	cnoremap <c-n> <down>
	cnoremap <c-p> <up>

	nmap - <Plug>VinegarVerticalSplitUp

	" misc
	nnoremap <tab> %
	vnoremap <tab> %

	" Select just pasted text.
	nnoremap <leader>V V`]

	" unite bindings
	nnoremap <silent> <leader>r :<C-u>Unite -buffer-name=registers register<cr>
	nnoremap <silent> <leader>l :FFBLines<cr>
	nnoremap <silent> <leader>L :FFLines<cr>
	nnoremap <leader>/ :FFAg<space>
	nnoremap <silent> <leader>y :FFBTags<cr>
	nnoremap <silent> <leader>Y :FFTags<cr>

	" quit
	nnoremap <silent><leader>Q :SmartClose<cr>
	vnoremap <silent><leader>Q :SmartClose<cr>
	nnoremap <silent><leader>q :bd<cr>

	" Show syntax highlighting groups for word under cursor
	nmap <C-S-P> :call <SID>SynStack()<CR>
	function! <SID>SynStack()
		if !exists("*synstack")
			return
		endif
		echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
	endfunc

	" toggle background (actually toggle color scheme)
	nnoremap  cob :<c-u>exe "colors" (g:colors_name =~# "dark"
			\ ? substitute(g:colors_name, 'dark', 'light', '')
			\ : substitute(g:colors_name, 'light', 'dark', '')
			\ )<cr>
endfunction

augroup bindings
	autocmd!
	autocmd VimEnter * call s:general_bindings()
	autocmd FileType haskell call s:haskell_bindings()
	autocmd FileType python,python.django call s:python_bindings()
	autocmd FileType unite call s:unite_bindings()
	autocmd FileType go call s:go_bindings()
	autocmd FileType rust call s:rust_bindings()
	autocmd FileType javascript call s:js_bindings()
augroup END

nnoremap <silent><bs> :nohlsearch<CR>
