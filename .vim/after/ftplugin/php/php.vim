" syntax
" `:help ft-php-syntax`
let php_sql_query = 1 " highlight SQL syntax in strings.
let php_baselib = 1 " highlight Baselib methods.
let php_htmlInStrings = 1 " HTML syntax highlight inside strings.
let php_oldStyle = 1 " use the old colorstyle.
let php_asp_tags = 1 " enable highlight ASP-style short tags.
let php_noShortTags = 1 " disable short tags
let php_parent_error_close = 1 " highlight parent error ] or )
let php_parent_error_open = 1 " skip php end tag, if exists, open (, [
let php_folding = 1 " folding for classes and functions.
let php_sync_method = -1 " selecting syncing method. -1/0/>0

" indent

" omni
setlocal omnifunc=phpcomplete#CompletePHP
