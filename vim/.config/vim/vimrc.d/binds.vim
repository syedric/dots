" --- Key Mappings ---
let mapleader = " "

nnoremap j gj
nnoremap k gk

" --- Can't quit vim ---
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>Q :q!<CR>

" --- One Less Key ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Better Indent --
vnoremap > >gv
vnoremap < <gv

" --- Resize windows using Alt + Arrow keys ---
nnoremap <A-Up>    :resize +2<CR>
nnoremap <A-Down>  :resize -2<CR>
nnoremap <A-Left>  :vertical resize -2<CR>
nnoremap <A-Right> :vertical resize +2<CR>

" --- Embedded Terminal ---
nnoremap <C-_> :terminal<CR>
tnoremap <ESC> <C-\><C-N>
tnoremap <C-_> <C-\><C-N>:q!<CR>

" --- Buffer Navigation ---
nnoremap <S-L> :bnext<CR>
nnoremap <S-H> :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

" --- Tab Navigation ---
nnoremap <S-J> :tabprev<CR>
nnoremap <S-K> :tabnext<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" --- Spliting ---
nnoremap <leader>hs :split<CR>
nnoremap <leader>vs :vsplit<CR>

" --- Misc ---
vnoremap <C-C> :<C-u>call system('wl-copy', join(getline("'<", "'>"), "\n"))<CR>
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>

" --- Clear HL ---
nnoremap <leader>H :nohlsearch<CR>

" --- NERDTree ---
" nnoremap <leader>nn :NERDTreeFocus<CR>
" nnoremap <leader>e :NERDTreeToggle<CR>
" nnoremap <leader>E :NERDTreeFind<CR>

" --- GitGutter ---
nnoremap <leader>ggb :GitGutterBufferToggle<CR>
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
