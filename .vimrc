"version 6.0
" pathogen - plugin loader
" @see http://mirnazim.org/writings/vim-plugins-i-use/

source ~/.vim/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR>
" specific for commandT
"  solves the problem when some key sequences aren't passed to CommandT
" @see https://wincent.com/forums/command-t/topics/447
let g:CommandTCancelMap=['<ESC>','<C-c>']

" *** Mapowanie klawiatury

" wyłączenie podświetlania
map <F2> :noh
" przełączenie podświetlania dla wyszukiwania
map <F3> :let &hlsearch=!&hlsearch

" dodanie/usunięcie komentarza HTML w linii
map <F8> I<!--A-->j
map <S-F8> :s/<!--//:s/-->//:nohj

" Tagbar: przełączenie
nmap <F9> :TagbarToggle<CR>

" komentarz: wstawienie // na początku zapisanego tekstu
nnoremap <silent> <C-D> I//<Esc>
" komentarz: wstawienie # na początku zapisanego tekstu
nnoremap <silent> <C-H> I# <Esc>
" komentarz: wstawienie // na początku linii
nnoremap <silent> <C-C> 0i//<Esc>
" komentarz: usunięcie // na początku linii
nnoremap <silent> <C-B> I<Del><Del><Esc>
" komentarz: początek/koniec komentarza wieloliniowego
" nmap <silent> <C-N> O/*<Esc>
" nmap <silent> <C-M> o*/<Esc>
" komentarz: wstawienie komentarza rozwiniętego
nnoremap <silent> <C-G> I/*<End>*/<Esc>
map <F11> :Tex <CR>
nmap <F10> :Ex <CR>

" spell php checker - synastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_jump=1
let g:syntastic_loc_list_height=7
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

"nnoremap <C-j> :m+
"nnoremap <C-k> :m-2
"vnoremap <C-j> :m'>+gv
"vnoremap <C-k> :m'<-2gv

" zapisanie pliku file - nie używać C-w bo blokuje operacje pomiędzy oknami
"nmap <C-S-w> :w
"nmap <C-q> :q

"" *** Operacje na tabach
"function TabLeft()
"   let tab_number = tabpagenr() - 1
"   if tab_number == 0
"      execute "tabm" tabpagenr('$') - 1
"   else
"      execute "tabm" tab_number - 1
"   endif
"endfunction
"
"function TabRight()
"   let tab_number = tabpagenr() - 1
"   let last_tab_number = tabpagenr('$') - 1
"   if tab_number == last_tab_number
"      execute "tabm" 0
"   else
"      execute "tabm" tab_number + 1
"   endif
"endfunction
"
"" Ctrl+Meta+right/left
"map <silent><C-A-Right> :execute TabRight()<CR>
"map <silent><C-A-Left> :execute TabLeft()<CR>



" *** Coding convention
" zawsze zamiana tabów na spacje
set expandtab
" zawsze 4 spacje na operacjach zamiast tabu
set shiftwidth=4
set tabstop=4
set backspace=indent,eol,start
" automatyczne wcinanie wierszy z obecnego zaznaczenia
set autoindent
set smartindent

" *** Analiza składni
" podświetlanie składni
syntax enable

" *** dostrojenie domyslnego wyglądu
" numery linii
set number
" numer aktualego wiersza/kolumny
set ruler

" WYSZUKIWANIE
" wielkość znaków przy wyszukiwniu: domyslnie ignorowanie, ale rozpoznawanie
" jeżeli użyto WielkichLiter
set ignorecase
set smartcase
" podświetlaj wyszukiwaną frazę
set hlsearch
" pokazywanie pasującej frazy w locie w trakcie wpisywania
set incsearch

"set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.info,.aux,.log,.dvi,.bbl,.out

" *** default encodings
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set t_Co=256
" informacja o nazwie pliku
set viminfo='20,\"500
" zawsze pokazuj linie statusu dla pliku
set laststatus=2

" *** schematy kolorystyczne
" xoria
" colorscheme xoria256

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
 "Uncomment the following to have Vim load indentation rules and plugins
 "according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

let Tlist_Use_Right_Window = 1
filetype on

" solarized
" @see https://github.com/altercation/vim-colors-solarized
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_degrade=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized


autocmd BufWritePost .vimrc source ~/.vimrc
"autocmd BufRead,BufWritePost *.php set omnifunc=phpcomplete#CompletePHP
"autocmd BufRead,BufWritePost *.tpl.html set syntax=smarty

autocmd Filetype gitcommit set spelllang=pl
autocmd FileType gitcommit set spell

" vim: set ft=vim :
"
" from Adaś
set listchars=tab:→→,trail:•,eol:↵
"set statusline=ascii\:\ %b\ lang\:\ %{v:lang}\ name\:\ %t

"function! SaveSession()
"  set sessionoptions=tabpages
"  mksession!
"  :! mv Session.vim ../
"endfunction
"
"map <F12> :call SaveSession()<CR>
"map <C-F12> :source ../Session.vim<CR>

" help from php.net
" see: http://www.quora.com/What-is-the-best-PHP-plugin-for-Vim
function! OpenPhpFunction (keyword)
  let proc_keyword = substitute(a:keyword , '_', '-', 'g')
  exe '5 split'
  exe 'enew'
  exe 'set buftype=nofile'
  exe 'silent r!links -dump http://www.php.net/manual/en/print/function.'.proc_keyword.'.php'
  exe 'norm gg'
  exe 'call search ("Description")'
  exe 'norm jdgg'
  exe 'call search("User Contributed Notes")'
  exe 'norm dGgg'
  exe 'norm V'
endfunction
au FileType php noremap K :call OpenPhpFunction(expand('<cword>'))<CR>

" ************* NIEUŻYWANE
"if &cp | set nocp | endif
"let s:cpo_save=&cpo
"set cpo&vim
"imap <F4> ZZ
"imap <F9> :w
"imap <F10> ZZ
"map Q gq
"nmap gx <Plug>NetrwBrowseX
"map <F4> ZZ

map <F6> :let &paste=!&paste<CR>
"map <F5> :e
"map <F10> :E
"nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetBrowseX(expand("<cWORD>"),0)
"map <F11> 0i# j
"map <F12> :s/^# //:nohj
"let &cpo=s:cpo_save
"unlet s:cpo_save
set history=50
"set modeline
"set nomodeline
"set novisualbell
"set scrolloff=4

  "set dictionaries and syntax
  au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
  au BufRead,BufNewFile *.css set ft=css syntax=css3
  au BufRead,BufNewFile *.php set ft=php syntax=php
  au BufRead,BufNewFile *.js set ft=javascript syntax=javascript
  au BufRead,BufNewFile *.html set ft=html syntax=html
  au FileType php setlocal dict+=~/.vim/dictionary/PHP.dict
  au FileType html setlocal dict+=~/.vim/dictionary/html.dict
  au FileType css setlocal dict+=~/.vim/dictionary/css.dict
  au FileType javascript setlocal dict+=~/.vim/dictionary/javascript.dict
  au BufRead,BufNewFile *.txt setlocal spell spelllang+=~/.vim/spell/pl.utf-8.spl
  au BufRead,BufNewFile *.twig set filetype=jinja
  au BufRead,BufNewFile *.svg set filetype=svg

