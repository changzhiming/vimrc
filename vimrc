set ts=4
set nu         
set expandtab 
set autoindent
set hls
set ai   
set smartindent
set shiftwidth=4 "自动缩进
set mouse=n

set nowrap    "不断行

syntax on
"set spell
set autowrite "自动保存

set completeopt=longest,menu
set nocompatible              " 这是必需的，去除VI一致性
filetype off                  " 这是必需的 

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()  

Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar' "Tagbar 
Plugin 'scrooloose/nerdtree' "nerdtree 
Plugin 'Raimondi/delimitMate'
Plugin 'dense-analysis/ale'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'https://gitee.com/debugging/YouCompleteMe.git'

call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本


if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set csverb
    set cspc=3
    "add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    "else search cscope.out elsewhere
    else
        let cscope_file=findfile("cscope.out",".;")
        let cscope_pre=matchstr(cscope_file,".*/")
        if !empty(cscope_file) && filereadable(cscope_file)
            exe "cs add" cscope_file cscope_pre
        endif
    endif
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-

"nmao <C- > s :cs find s <C-R>=expand()
"F4 c字符查找, F5字符串查找 F6查找函数谁调用了 F7 函数定义

nmap <silent> <F4> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F5> :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F6> :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F7> :cs find g <C-R>=expand("<cword>")<CR><CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeWinSize=25
"let NERDTreeShowLineNumbers=0
"let NERDTreeAutoCenter=1
let NERDTreeShowBookmarks=0

"NerdTree####################################################
"去除第一行的帮助提示
let NERDTreeMinimalUI=1
"不高亮显示光标所在的文件
let NERDTreeHighlightCursorline=0
"当前目录的设定
let NERDTreeChDirMode = 2
"在左边占多宽
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
"打开vim时自动打开
"autocmd vimenter * NERDTree
"<F2>作为toggle
nmap <F2> :NERDTreeToggle<CR>

"Tagbar######################################################
"在这儿设定二者的分布
let g:tagbar_vertical = 25
"去除第一行的帮助信息
let g:tagbar_compact = 1
"当编辑代码时，在Tagbar自动追踪变量
let g:tagbar_autoshowtag = 1
"个人爱好，展开关闭文件夹的图标
let g:tagbar_iconchars = ['▸', '▾']
"<F3>作为toggle
nmap <F3> :TagbarToggle<CR>
"打开vim时自动打开
"autocmd VimEnter * nested :TagbarOpen
"autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen()
wincmd l
"如果不加这句，打开vim的时候当前光标会在Nerdtree区域
autocmd VimEnter * wincmd l


"ale
"始终开启标志列
let g:ale_sign_column_always = 0
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 自动补全配置
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" 寻找全局配置文件
let g:ycm_server_python_interperter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" 禁用syntastic来对python检查
let g:syntastic_ignore_files=[".*\.py$"] 

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>    "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
inoremap <leader><leader> <C-x><C-o>

"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处

