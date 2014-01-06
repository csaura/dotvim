" Vim doesn't namespace sign ids so every plugin shares the same
" namespace.  Sign ids are simply integers so to avoid clashes with other
" signs we guess at a clear run.
"
" Note also we currently never reset s:next_sign_id.
let s:first_sign_id = 3000
let s:next_sign_id  = s:first_sign_id
let s:dummy_sign_id = s:first_sign_id - 1


" Removes gitgutter's signs from the given file.
function! sign#clear_signs(file_name)
  for sign in getbufvar(a:file_name, 'gitgutter_gitgutter_signs', [])
    exe ":sign unplace" sign[1] "file=" . a:file_name
  endfor
  call setbufvar(a:file_name, 'gitgutter_gitgutter_signs', [])
endfunction


" Updates gitgutter's signs in the given file.
"
" modified_lines: list of [line_number, name]
" where name = 'added|removed|modified|modified_removed'
function! sign#update_signs(file_name, modified_lines)
  call sign#find_current_signs(a:file_name)

  let new_gitgutter_signs_line_numbers = map(copy(a:modified_lines), 'v:val[0]')
  call sign#remove_obsolete_gitgutter_signs(a:file_name, new_gitgutter_signs_line_numbers)

  call sign#upsert_new_gitgutter_signs(a:file_name, a:modified_lines)
endfunction


function! sign#add_dummy_sign()
  exe ":sign place" s:dummy_sign_id "line=" . 9999 "name=GitGutterDummy file=" . utility#file()
endfunction

function! sign#remove_dummy_sign()
  if exists('s:dummy_sign_id')
    exe ":sign unplace" s:dummy_sign_id "file=" . utility#file()
  endif
endfunction


"
" Internal functions
"


function! sign#find_current_signs(file_name)
  let gitgutter_signs = []
  let other_signs = []

  redir => signs
    silent exe ":sign place file=" . a:file_name
  redir END

  for sign_line in filter(split(signs, '\n'), 'v:val =~# "="')
    " Typical sign line:  line=88 id=1234 name=GitGutterLineAdded
    " We assume splitting is faster than a regexp.
    let components  = split(sign_line)
    let name        = split(components[2], '=')[1]
    if name !~# 'GitGutterDummy'
      let line_number = str2nr(split(components[0], '=')[1])
      if name =~# 'GitGutter'
        let id = str2nr(split(components[1], '=')[1])
        call add(gitgutter_signs, [line_number, id, name])  " TODO: use dictionary instead?
      else
        call add(other_signs, line_number)
      endif
    end
  endfor

  call setbufvar(a:file_name, 'gitgutter_gitgutter_signs', gitgutter_signs)
  call setbufvar(a:file_name, 'gitgutter_other_signs', other_signs)
endfunction


function! sign#remove_obsolete_gitgutter_signs(file_name, new_gitgutter_signs_line_numbers)
  let old_gitgutter_signs = getbufvar(a:file_name, 'gitgutter_gitgutter_signs')
  for sign in old_gitgutter_signs
    let line_number = sign[0]
    if index(a:new_gitgutter_signs_line_numbers, line_number) == -1
      let id = sign[1]
      exe ":sign unplace" id "file=" . a:file_name
    endif
  endfor
endfunction


function! sign#upsert_new_gitgutter_signs(file_name, modified_lines)
  let other_signs         = getbufvar(a:file_name, 'gitgutter_other_signs')
  let old_gitgutter_signs = getbufvar(a:file_name, 'gitgutter_gitgutter_signs')
  let old_gitgutter_signs_line_numbers = map(copy(old_gitgutter_signs), 'v:val[0]')

  for line in a:modified_lines
    let line_number = line[0]
    if index(other_signs, line_number) == -1  " don't clobber others' signs
      let name = 'GitGutterLine' . utility#snake_case_to_camel_case(line[1])
      let idx = index(old_gitgutter_signs_line_numbers, line_number)
      if idx == -1  " insert
        let id = sign#next_sign_id()
        exe ":sign place" id "line=" . line_number "name=" . name "file=" . a:file_name
      else  " update if sign has changed
        let old_name = old_gitgutter_signs[idx][2]
        if old_name !=# name
          let id = old_gitgutter_signs[idx][1]
          exe ":sign place" id "name=" . name "file=" . a:file_name
        end
      endif
    endif
  endfor
endfunction


function! sign#next_sign_id()
  let next_id = s:next_sign_id
  let s:next_sign_id += 1
  return next_id
endfunction
