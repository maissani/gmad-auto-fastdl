@echo off
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
del compiled\* /F /Q
del prebuild\* /F /Q
del compiled\* /F /Q
del workshop.lua /F /Q
del fastdl.lua /F /Q
endlocal
setlocal EnableDelayedExpansion
for /L %%n in (1 1 500) do if "!__cd__:~%%n,1!" neq "" set /a "len=%%n+10"
setlocal DisableDelayedExpansion
endlocal
for /f %%i in ('dir /b "input\*.gma"') do (
	endlocal
	setlocal EnableDelayedExpansion
	set str=%%~ni
	@echo resource.AddWorkshop^("!str:ds_=!"^) >> workshop.lua
	endlocal
	setlocal DisableDelayedExpansion
	gmad.exe extract -file "input\%%~nxi" -out "prebuild\%%~ni"
	for /D %%A in ("prebuild\%%~ni\*") do (
		if "%%~nA"=="maps" XCOPY "prebuild\%%~ni\%%~nA" "compiled\maps\" /S /E /Y
		if "%%~nA"=="materials" XCOPY "prebuild\%%~ni\%%~nA" "compiled\materials\" /S /E /Y
		if "%%~nA"=="models" XCOPY "prebuild\%%~ni\%%~nA" "compiled\models\" /S /E /Y
		if "%%~nA"=="particles" XCOPY "prebuild\%%~ni\%%~nA" "compiled\particles\" /S /E /Y
		if "%%~nA"=="resource" XCOPY "prebuild\%%~ni\%%~nA" "compiled\resource\" /S /E /Y
		if "%%~nA"=="scripts" XCOPY "prebuild\%%~ni\%%~nA" "compiled\scripts\" /S /E /Y
		if "%%~nA"=="sound" XCOPY "prebuild\%%~ni\%%~nA" "compiled\sound\" /S /E /Y
	)
)
for /D %%U in ("input\*") do (
	for /D %%E in ("input\%%~nU\*") do (
		if "%%~nE"=="maps" XCOPY "input\%%~nU\%%~nE" "compiled\maps\" /S /E /Y
		if "%%~nE"=="materials" XCOPY "input\%%~nU\%%~nE" "compiled\materials\" /S /E /Y
		if "%%~nE"=="models" XCOPY "input\%%~nU\%%~nE" "compiled\models\" /S /E /Y
		if "%%~nE"=="particles" XCOPY "input\%%~nU\%%~nE" "compiled\particles\" /S /E /Y
		if "%%~nE"=="resource" XCOPY "input\%%~nU\%%~nE" "compiled\resource\" /S /E /Y
		if "%%~nE"=="scripts" XCOPY "input\%%~nU\%%~nE" "compiled\scripts\" /S /E /Y
		if "%%~nE"=="sound" XCOPY "input\%%~nU\%%~nE" "compiled\sound\" /S /E /Y
	)
)
for /r compiled\ %%B in ("*") do (
	set "absPath=%%B"
	endlocal
	setlocal EnableDelayedExpansion
	set "relPath=!absPath:~%len%!"
	echo ""
	@echo resource.AddFile^("!relPath!"^) >> fastdl.lua
	endlocal
)
IFS=$SAVEIFS