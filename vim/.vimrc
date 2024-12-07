
"========= Code =========

syntax on "启用语法高亮"
highlight Comment ctermfg=Green "设置注释颜色"

set autoindent "跟随上一行的缩进"
set smartindent "根据基本的语法结构缩进"
set shiftwidth=4 "设置缩进宽度"
set tabstop=4 "设置Tab宽度"

set backspace=indent,eol,start "设置更灵活的退格键"

set clipboard=unnamedplus "设置vim使用系统剪切板"




"========= Move =========

set number "设置行号"
set relativenumber "设置相对行号"
set laststatus=2 "设置常驻状态栏"

set ignorecase "默认不区分大小写搜索"
set smartcase "搜索时若出现大写则区分大小写"
set incsearch "启用增量搜索"
set hlsearch "高亮搜索匹配项"

set mouse+=a "设置鼠标操控"

"抛弃新手拐杖
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>




"========= Disable =========

set nocompatible "禁用兼容模式，启用vim现代特性"
set shortmess+=I "省略vim初始化信息"
set hidden "允许在不同缓冲区间自由切换，而不强制保存当前文件"
set noerrorbells visualbell t_vb=
nmap Q <Nop>




"========= Plugin =========

call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


"设置coc.nvim使用clangd作为C++语言服务器
let g:coc_global_extensions = ['coc-clangd']


