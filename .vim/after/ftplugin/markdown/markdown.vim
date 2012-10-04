setlocal omnifunc=htmlcomplete#CompleteTags
" Operator-Pending Mappings
" usage: operator like 'c', 'd'. e.g. 'cih'.
onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
onoremap ah :<c-u>execute "normal! ?^==\\+\r:nohlsearch\rg_vk0"<cr>
