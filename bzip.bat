::==================================::
::             bzip.zip             ::
::            srcds.com             ::
::                                  ::
::    Updated to use bzip2 1.0.5    ::
::          Edited by Mooga         ::
:: Original credit goes to sKeletor ::
::==================================::

:: This will keep the window clean and easy to read
@echo off

:: Sets the title of the window
title srcds.com's bzip

::Shows the users stuff
echo            --==srcds.com's bzip.zip==--
echo All files within /compress will be compressed as a .bz2
echo.
echo Special Thanks to sKeletor
echo.
echo For help with Source Dedicated Servers,
echo visit out forums at forums srcds.com
echo                     --==##==--
echo.
echo Compressing file(s)...

:: Compresses all files in /compress using bzip2
for /R compiled\ %%f in (*) do bzip2.exe -z --best "%%f.*"
echo.
echo Compression Completed!
pause