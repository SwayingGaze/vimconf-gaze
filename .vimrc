" 设置<leader>
let mapleader = ","
" 重设保存键
noremap <C-z> :update<Enter>
inoremap <C-z> <C-c>:update<CR>i
vnoremap <C-z> <C-c>:update<CR>v
nmap <Leader>e :q<CR>
let b:vimpipe_command="python"
" 显示行数，设置软回车和缩进还有语法
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" 不加这个在OS X下面delete键用不了
set backspace=2

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 编码设置
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set termencoding=utf-8

" 基于缩进或语法进行代码折叠
set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" 总是显示状态栏
set laststatus=2

" 显示光标当前位置
set ruler
" 高亮显示当前行/列
set cursorline
" set cursorcolumn

" 高亮显示搜索结果
set hlsearch

" vim 主题
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" colorscheme monokai

" vundle 插件管理
filetype on
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" 插件
Bundle "scrooloose/nerdtree"
Bundle "bling/vim-airline"
Bundle "Valloric/YouCompleteMe"
Bundle "Raimondi/delimitMate"
Bundle "kien/ctrlp.vim"
Bundle "klen/python-mode"
Bundle "mattn/emmet-vim"
Bundle "hail2u/vim-css3-syntax"
Bundle "pangloss/vim-javascript"
Bundle "ap/vim-css-color"
Bundle "mileszs/ack.vim"
Bundle "davidhalter/jedi-vim"
Plugin 'othree/html5.vim'

" airline 特殊符号
let g:airline_powerline_fonts = 1


" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=30
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1


" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=White ctermbg=Black
" 选中项
 highlight PmenuSel ctermfg=Blue ctermbg=White
" 补全功能在注释中同样有效
 let g:ycm_complete_in_comments=1
" " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
 let g:ycm_confirm_extra_conf=0
" " 开启 YCM 标签补全引擎
 let g:ycm_collect_identifiers_from_tags_files=1
 let g:ycm_filepath_completion_use_working_dir=1
" " 引入 C++ 标准库tags
 set tags+=/data/misc/software/misc./vim/stdcpp.tags
" " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
" " inoremap <leader>; <C-x><C-o>
" " 补全内容不以分割子窗口形式出现，只显示补全列表
" set completeopt-=preview
" " 从第一个键入字符就开始罗列匹配项
 let g:ycm_min_num_of_chars_for_completion=1
" " 禁止缓存匹配项，每次都重新生成匹配项
 let g:ycm_cache_omnifunc=0
" " 语法关键字补全         
 let g:ycm_seed_identifiers_with_syntax=1
 let g:ycm_error_symbol = '>>'
 let g:ycm_warning_symbol = '>*'


autocmd BufNewFile *.py,*.sh exec ":call SetTitle()"
autocmd BufNewFile,BufRead * exec "call OpenNerd()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python") 
        call setline(2, "\# -*- encoding:utf-8 -*-") 
    endif
    if &filetype == 'sh'
        call setline(1, "\#!/usr/bin/sh") 
    endif
endfunc

func OpenNerd()
    exec "NERDTreeToggle"
endfunc
func RunPython()
    exec "w"
    exec "!python %"
endfunc

func CompileCpp()
    exec "w"
    exec "!g++ %"
    exec "!a.out"
endfunc

func! RunHtml()
    exec "w"
    exec "!python %"n 'othree/html5.vim'

    exec "!firefox %"
endfunc


func CompileOrBuild()
    exec "w"
    if &filetype == "cpp"
        exec "call CompileCpp()"
    elseif &filetype == "python"
        exec "call RunPython()"
    elseif &filetype == "html"
        exec "call RunHtml()"
    endif
endfunc

map <F5> :call CompileOrBuild()<CR>
