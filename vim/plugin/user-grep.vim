let s:options       = ['ignorecase', 'extended'] " grep option
let s:exclude_dirs  = ['.git',  '.svn', '.hg']   " dirctories for exclude
let s:exclude_files = ['*.swp', 'tags']          " files for exclude

nnoremap <leader>g :set operatorfunc=<SID>GrepByOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepByOperator(visualmode())<cr>

function! s:GrepByOperator(type)
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    call Grep(@@, ".")
endfunction

function! Grep(pattern, path)
    " backup current grepprg val(to restore)
    let grepprg_val_escaped_bak = substitute(&grepprg, ' ', '\\ ', 'g')
    execute 'set grepprg=' . s:MakeGrepprgVal()
    silent execute "grep " . shellescape(a:pattern) . a:path
    " resttore previous grepprg val
    execute 'set grepprg=' . grepprg_val_escaped_bak
    if len(getqflist()) > 0
        copen
    endif

    redraw!

    return
endfunction

function! s:MakeGrepprgVal()
    return 'grep\ ' . s:MakeGrepprgValPartOption()
                   \. s:MakeGrepprgValPartExcludeDirs()
                   \. s:MakeGrepprgValPartExcludeFiles() . '$*'
endfunction

function! s:MakeGrepprgValPartOption()
    let l:grepprg_val_options = '-rHan\ ' " quickfix need row number and file path.
    for o in s:options
        let l:grepprg_option = s:OptionToGrepprgOption(o)
        if l:grepprg_option ==# ''
            continue
        endif

        let l:grepprg_val_options = l:grepprg_val_options . l:grepprg_option . '\ '
    endfor

    return l:grepprg_val_options
endfunction

function! s:MakeGrepprgValPartExcludeDirs()
    let l:grepprg_val_exclude_dirs = ''
    for d in s:exclude_dirs
        let l:grepprg_val_exclude_dirs = l:grepprg_val_exclude_dirs . '--exclude-dir=' . shellescape(d) . '\ '
    endfor

    return l:grepprg_val_exclude_dirs
endfunction

function! s:MakeGrepprgValPartExcludeFiles()
    let l:grepprg_val_exclude_files = ''
    for f in s:exclude_files
        let l:grepprg_val_exclude_files = l:grepprg_val_exclude_files . '--exclude=' . shellescape(f) . '\ '
    endfor

    return l:grepprg_val_exclude_files
endfunction

" convert grep option to grepprgval option
function! s:OptionToGrepprgOption(option)
    if a:option ==# 'ignorecase'
        return '-i'
    elseif a:option ==# 'extended'
        return '-E'
    endif

    return ''
endfunction

