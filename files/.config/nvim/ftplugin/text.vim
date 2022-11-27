" Disable runtime ftplugin
let b:did_ftplugin = 1

" Format options:
"   - t: Auto-wrap text using `textwidth`
"   - c: Auto-wrap comments using `textwidth`
"   - r: Continue comments using <Enter> in insert
"   - q: format comments usin gq
"   - n: auto format lists
"   - l: don't auto-wrap while the line is being written in insert mode
"   - M: don't add a space before or after multibyte characters after joining lines
"   - j: remove comment leader when joining lines
"   - p: don't auto-wrap after a period
setlocal formatoptions=tcrqnlMjp

" Undo the stuff changed.
let b:undo_ftplugin = "setl formatoptions<"
