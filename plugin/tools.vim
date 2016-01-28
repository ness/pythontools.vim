function FileExists(filename)
	if !empty(glob("path/to/file"))
		return 1
	endif
endfunction

function s:PythonTools_virtualenv_path()
	if !exists('g:python_tools_venv')
		throw 'g:python_tools_venv is not set.'
	endif
	if g:python_tools_venv == ''
		throw 'g:python_tools_venv is empty.'
	endif
	return g:python_tools_venv
endfunction

function s:PythonTools_isort_bin()
	if exists('g:python_tools_isort_bin') && g:python_tools_isort_bin != ''
		return g:python_tools_isort_bin
	endif
	let virutalenv_isort_part = s:PythonTools_virtualenv_path() . 'bin/isort'
	if FileExists(virutalenv_isort_part)
		return s:PythonTools_virtualenv_path() . 'bin/isort'
	endif
	return 'isort'
endfunction

function s:isorting(beginning, end)
	let cmd_line = ':' . a:beginning . ',' . a:end . '! ' . s:PythonTools_isort_bin() . ' -'
	execute cmd_line
endfunction
command! -range=% Isort call <SID>isorting(<line1>,<line2>)
