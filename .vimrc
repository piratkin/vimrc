if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'vim-scripts/FuzzyFinder'

Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'

" git
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" Syntax Check
Plug 'scrooloose/syntastic'

" Color schemes
Plug 'sickill/vim-monokai'

Plug 'arakashic/chromatica.nvim'

call plug#end()

let g:chromatica#responsive_mode = 1 "Chromatica provides a responsive mode that reparses and updates the hightlight as soon as you change the code 

set background=dark

let g:magit_enabled = 1
let g:magit_git_cmd = "git"
let g:magit_show_help = 1
let g:magit_commit_title_limit = 300
"let g:magit_default_show_all_files=[012]
"let g:magit_default_fold_level=[012]
"let g:magit_auto_foldopen=[01]
"let g:magit_default_sections = ['info', 'global_help', 'commit', 'staged', 'unstaged']
"let g:magit_warning_max_lines=val
"let g:magit_discard_untracked_do_delete=[01]
let g:magit_refresh_gitgutter = 1


map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.git$'] "скрывать некоторые файлы или каталоги в дереве
let NERDTreeQuitOnOpen = 1 "дерево папок автоматически закрываться при открытии файла
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }

"НАСТРОЙКИ ВНЕШНЕГО ВИДА И БАЗОВЫЕ НАСТРОЙКИ РЕДАКТОРА
set number " включить нумерацию строк
set relativenumber " переключить на относительную нумерацию строк
set scrolloff=3 " сколько строк внизу и вверху экрана показывать при скроллинге
set mouse=a " включает поддержку мыши при работе в терминале (без GUI)
set mousehide " скрывать мышь в режиме ввода текста
set showcmd " показывать незавершенные команды в статусбаре (автодополнение ввода)
set mps+=<:> " показывать совпадающие скобки для HTML-тегов
set showmatch " показывать первую парную скобку после ввода второй
set autoread " перечитывать изменённые файлы автоматически
set t_Co=256 " использовать больше цветов в терминале
if has("nvim")
    set termguicolors 
endif
set confirm " использовать диалоги вместо сообщений об ошибках
set visualbell " вместо писка бипером мигать курсором при ошибках ввода
set clipboard=unnamed " во избежание лишней путаницы использовать системный буфер обмена вместо буфера Vim
set title " показывать имя буфера в заголовке терминала
set history=128 " хранить больше истории команд
set undolevels=2048 " хранить историю изменений числом N

"НАСТРОЙКИ ПОИСКА ТЕКСТА В ОТКРЫТЫХ ФАЙЛАХ
set ignorecase " ics - поиск без учёта регистра символов
set smartcase " - если искомое выражения содержит символы в верхнем регистре - ищет с учётом регистра, иначе - без учёта
set hlsearch " (не)подсветка результатов поиска (после того, как поиск закончен и закрыт)
set incsearch " поиск фрагмента по мере его набора

"НАСТРОЙКИ РАБОТЫ С ФАЙЛАМИ
"Кодировка редактора (терминала) по умолчанию (при создании все файлы приводятся к этой кодировке)
set encoding=utf-8
set termencoding=utf-8
" формат файла по умолчанию (влияет на окончания строк) - будет перебираться в указанном порядке
set fileformat=unix
" варианты кодировки файла по умолчанию (все файлы по умолчанию сохраняются в этой кодировке)
set fencs=utf-8,cp1251,koi8-r,cp866
syntax on " включить подсветку синтаксиса

"НАСТРОЙКИ ОТСТУПА
set shiftwidth=4 " размер отступов (нажатие на << или >>)
set tabstop=4 " ширина табуляции
set softtabstop=4 " ширина 'мягкого' таба
set autoindent " ai - включить автоотступы (копируется отступ предыдущей строки)
set cindent " ci - отступы в стиле С
set expandtab " преобразовать табуляцию в пробелы
set smartindent " Умные отступы (например, автоотступ после {)
" Для указанных типов файлов отключает замену табов пробелами и меняет ширину отступа
au FileType crontab,fstab,make set noexpandtab tabstop=8 shiftwidth=8

"НАСТРОЙКИ ПЕРЕКЛЮЧЕНИЯ РАСКЛАДОК КЛАВИАТУРЫ
set iminsert=0 " раскладка по умолчанию - английская
set imsearch=0 " аналогично для строки поиска и ввода команд


" Returns the list of available color schemes
function! GetColorSchemes()
   return uniq(sort(map(
   \  globpath(&runtimepath, "colors/*.vim", 0, 1),  
   \  'fnamemodify(v:val, ":t:r")'
   \)))
endfunction
let s:schemes = GetColorSchemes()
if index(s:schemes, 'monokai') >= 0
   colorscheme monokai
elseif index(s:schemes, 'desert') >= 0
   colorscheme desert
endif

" настройки Syntastic 
let g:syntastic_check_on_wq = 1
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_error_symbol = "▶▶"
let g:syntastic_warning_symbol = "⚠"

" настройки Vim-Airline
set laststatus=2
set noshowmode  
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 0
let g:airline_enable_fugitive = 1 " проверка синтаксиса
let g:airline_enable_syntastic = 1 " взаимодействие с git-ом
let g:airline#extensions#hunks#enabled = 1
let g:airline_enable_bufferline = 1 "
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail' " вид отображения расположения файла в tabline

" для перемещения между окнами
"map <silent> <C-h> :call WinMove('h')<CR>
"map <silent> <C-j> :call WinMove('j')<CR>
"map <silent> <C-k> :call WinMove('k')<CR>
"map <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

