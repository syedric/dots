" --- Key Mappings ---
let mapleader = " "

nnoremap j gj
nnoremap k gk
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" --- One Less Key ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

vnoremap <C-C> :<C-u>call system('wl-copy', join(getline("'<", "'>"), "\n"))<CR>
nnoremap <leader>H :nohlsearch<CR><Esc>

" --- NerdTree ---
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>E :NERDTreeFind<CR>

" Resize windows using Alt + Arrow keys
nnoremap <A-Up>    :resize +2<CR>
nnoremap <A-Down>  :resize -2<CR>
nnoremap <A-Left>  :vertical resize -2<CR>
nnoremap <A-Right> :vertical resize +2<CR>

" GitGutter
nnoremap <leader>ggb :GitGutterBufferToggle<CR>
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
