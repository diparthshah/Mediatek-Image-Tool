
@echo off
title MEDIATEK MULTI IMAGE TOOL  
:home
cls
echo.
echo *******************************************************************************
echo *                           MEDIATEK MULTI IMAGE TOOL                         *
echo *                                WINDOWS VERSION                              *
echo *                        DIPARTH SHAH  diparths@gmail.com                     *
echo *******************************************************************************
echo.
echo.
echo **************************************************************
echo *                      MENU                                  *
echo **************************************************************
echo *   1. SEE INSTRUCTIONS                                      *
echo *   2. BOOT IMAGE                                            *
echo *   3. RECOVERY IMAGE                                        * 
echo *   4. UNPACK SYSTEM.IMG                                     * 
echo *   5. UNPACK SYSTEM.NEW.DAT + SYSTEM.TRANSFER.LIST          *
echo *   6. EXIT                                                  *
echo **************************************************************
echo.
set /p menu=Choice:
if "%menu%"=="1" goto inst 
if "%menu%"=="2" goto boot 
if "%menu%"=="3" goto recovery 
if "%menu%"=="4" goto system
if "%menu%"=="5" goto system_dat 
if "%menu%"=="6" goto bye
goto home

:inst 
cls 
type tools\instructions.txt
pause 
goto home  

:system
tools\Imgextractor.exe input\system.img output\system.img -i
echo.
echo Done. Go to the folder "output"
pause
goto home

:system_dat 
echo.
echo Please wait, start conversion in "system.new.img"...
echo.
tools\sdat2img input\system.transfer.list input\system.new.dat output\system.new.img
echo.
echo Please wait, unpacks "system.new.img"...
tools\Imgextractor.exe output\system.new.img output\system.dat -i
del output\system.new.img 
echo Done. Go to the folder "output"
pause
goto home

:bye 
exit 

:boot 
cls 
echo.
echo *******************************************************************************
echo *                           MEDIATEK MULTI IMAGE TOOL                         *
echo *                                WINDOWS VERSION                              *
echo *                        DIPARTH SHAH  diparths@gmail.com                     *
echo *                              BOOT IMAGE SECTION                             *  
echo *******************************************************************************
echo.
echo **************************************************
echo *    1. UNPACK BOOT IMAGE                        *
echo *    2. REPACK BOOT IMAGE                        *
echo *    3. GO BACK                                  *
echo **************************************************
set /p up=Choice:
if "%up%"=="1" goto unpack_boot 
if "%up%"=="2" goto repack_boot  
if "%up%"=="3" goto back  

:unpack_boot 
mkdir boot 
copy "input\boot.img" "boot.img" >nul
call tools\bootimg.exe --unpack-bootimg boot.img
if exist "boot.img" del "boot.img"
if exist "boot-old.img" del "boot-old.img" 
copy "kernel" "boot\kernel" >nul
copy "bootinfo.txt" "boot\bootinfo.txt" >nul  
copy "cpiolist.txt" "boot\cpiolist.txt" >nul 
copy "ramdisk" "boot\wew" >nul 
xcopy "initrd" "boot\ramdisk" /E
if exist "kernel" del "kernel"
if exist "bootinfo.txt" del "bootinfo.txt"
if exist "cpiolist.txt" del "cpiolist.txt"
if exist "ramdisk" del "ramdisk" 
if exist "initrd" RD /S "initrd" 
pause 
goto boot 

:repack_boot
copy "boot\kernel" "kernel" >nul 
copy "boot\bootinfo.txt" "bootinfo.txt" >nul 
copy "boot\cpiolist.txt" "cpiolist.txt" >nul 
copy "boot\wew" "ramdisk" >nul 
xcopy "boot\ramdisk" "initrd" /E 
call tools\bootimg.exe --repack-bootimg 
copy "boot-new.img" "output\boot.img" >nul 
if exist "boot-new.img" del "boot-new.img"
if exist "boot-old.img" del "boot-old.img"
if exist "kernel" del "kernel"
if exist "bootinfo.txt" del "bootinfo.txt"
if exist "cpiolist.txt" del "cpiolist.txt"
if exist "ramdisk" del "ramdisk" 
if exist "initrd" RD /S "initrd"
              
pause 
goto boot  

: back 
goto home 

:recovery 
cls 
echo.
echo *******************************************************************************
echo *                           MEDIATEK MULTI IMAGE TOOL                         *
echo *                                WINDOWS VERSION                              *
echo *                        DIPARTH SHAH  diparths@gmail.com                     *
echo *                            RECOVERY IMAGE SECTION                           *  
echo *******************************************************************************
echo.
echo **************************************************
echo *    1. UNPACK RECOVERY IMAGE                    *
echo *    2. REPACK RECOVERY IMAGE                    *
echo *    3. GO BACK                                  *
echo **************************************************
set /p up=Choice:
if "%up%"=="1" goto unpack_recovery  
if "%up%"=="2" goto repack_recovery  
if "%up%"=="3" goto back  

:unpack_recovery 
mkdir recovery 
copy "input\recovery.img" "boot.img" >nul
call tools\bootimg.exe --unpack-bootimg boot.img
if exist "boot.img" del "boot.img"
if exist "boot-old.img" del "boot-old.img" 
copy "kernel" "recovery\kernel" >nul
copy "bootinfo.txt" "recovery\bootinfo.txt" >nul  
copy "cpiolist.txt" "recovery\cpiolist.txt" >nul 
copy "ramdisk" "recovery\wew" >nul 
xcopy "initrd" "recovery\ramdisk" /E 
if exist "kernel" del "kernel"
if exist "bootinfo.txt" del "bootinfo.txt"
if exist "cpiolist.txt" del "cpiolist.txt"
if exist "ramdisk" del "ramdisk" 
if exist "initrd" RD /S "initrd"
pause 
goto boot 

:repack_recovery 
copy "recovery\kernel" "kernel" >nul 
copy "recovery\bootinfo.txt" "bootinfo.txt" >nul 
copy "recovery\cpiolist.txt" "cpiolist.txt" >nul 
copy "recovery\wew" "ramdisk" >nul 
xcopy "recovery\ramdisk" "initrd" /E 
call tools\bootimg.exe --repack-bootimg 
copy "boot-new.img" "output\recovery.img" >nul 
if exist "boot-new.img" del "boot-new.img"
if exist "boot-old.img" del "boot-old.img"
if exist "kernel" del "kernel"
if exist "bootinfo.txt" del "bootinfo.txt"
if exist "cpiolist.txt" del "cpiolist.txt"
if exist "ramdisk" del "ramdisk" 
if exist "initrd" RD /S "initrd"
pause 
goto boot  