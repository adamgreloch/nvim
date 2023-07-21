" Create command alias safely, see https://stackoverflow.com/q/3878692/6064933
" The following two functions are taken from answer below on SO:
" https://stackoverflow.com/a/10708687/6064933
function! utils#Cabbrev(key, value) abort
  execute printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
        \ a:key, 1+len(a:key), <SID>Single_quote(a:value), <SID>Single_quote(a:key))
endfunction

function! s:Single_quote(str) abort
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

" Opens a new .txt.gpg file with a date on top and appends time of every new entry
function! s:JournalOpen()
  return ':e '.$JOURNALDIR.'/'.strftime('%Y%m%d').'.txt.gpg'
endfunction

command! JournalOpen execute s:JournalOpen()

" Remove diacritical signs from characters in specified range of lines.
" Examples of characters replaced: á -> a, ç -> c, Á -> A, Ç -> C.
function! s:RemoveDiacritics(line1, line2)
  let diacs = 'áâãàąçćéêęíłńóôõśüúżź'  " lowercase diacritical signs
  let repls = 'aaaaacceeeilnooosuuzz'  " corresponding replacements
  let diacs .= toupper(diacs)
  let repls .= toupper(repls)
  let all = join(getline(a:line1, a:line2), "\n")
  call setline(a:line1, split(tr(all, diacs, repls), "\n"))
endfunction

command! -range=% RemoveDiacritics call s:RemoveDiacritics(<line1>, <line2>)
