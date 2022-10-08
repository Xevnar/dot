lua require('ftplugin.java')

" Disable other ftplugins "
let b:did_ftplugin = 1

" LANGUAGE SERVER "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Launch lanquage server when starting vim
lua require'jdtls_setup'.setup()

" ABBREVIATIONS " TODO: Replace with vim-snip configeration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"" TODO: Add ability to do repeating abbreviations for switch/if-else. e.g
"" <condition1><CR><condition2><CR><condition3>.....<conditionN> <abbr>
"" <case1><CR><case2><CR><case3>.....<caseN> <abbr>
"
"" Get C-style paragrph comments by typing com
"" Usage: <abbr>
"call Iab('pub', 'public ')
"call Iab('pri', 'private ')
"call Iab('pro', 'protected ')
"call Iab('sta', 'static ')
"call Iab('cons', 'public static final ')
"call Iab('comm', '/*<CR><CR>/<Up> ')
"call Iab('sout', 'System.out.printf("");<esc>2hi')
"call Iab('serr', 'System.err.printf("");<esc>2hi')
"call Iab('psvm', 'public static void main(String [] args) {<CR>}<esc>ko')
"
"" Usage: <array> <abbr>
"call Iab('fori', '<esc>^"ad$afor (int i = 0; i < <esc>"api.length; i++) {<CR>}<esc>ko')
"
"" Usage: <varible> <array> <abbr>
"call Iab('forl', '<esc>^"adw"bd$afor (int <esc>"api = 0; <esc>"api < <esc>"bpi.length; <esc>"api++) {<CR>}<esc>ko')
"
"" Usage: <condition> <abbr>
"call Iab('ifon', '<esc>^"ad$aif (<esc>"api) {<CR>}<esc>ko')
"call Iab('ifel', '<esc>^"ad$aif (<esc>"api) {<CR>} else {<CR>}<esc>2ko')
"call Iab('whil', '<esc>^"ad$awhile (<esc>"api) {<CR>}<esc>ko')
"call Iab('dowl', '<esc>^"ad$ado {<CR>} while (<esc>"api);<esc>ko')
"
"" Usage: <exception> <abbr>
"call Iab('tryc', '<esc>^"ad$atry {<CR>} catch (<esc>"api);<esc>ko')
"
"" Usage: <condition1><CR><condition2> <abbr>
"call Iab('elif', '<esc>^"bd$k^"ad$aif (<esc>"apa) {<CR>} else if (<esc>"bpi){<CR>} else {<CR>}<esc>3ko')
