@echo off
IF EXIST eula.txt (
  goto CHECKEULA
) ELSE (
  goto ASKEULA
)
IF %errlevel% EQU 1 goto END
:CHECKEULA
>nul find "eula=false" eula.txt && (
  goto ASKEULA
) || (
  goto END
)
:ASKEULA
echo "Do you agree to the Mojang EULA available at https://account.mojang.com/documents/minecraft_eula ?"
set /p EULA=[y/n]
IF /I "%EULA%" NEQ "y" GOTO END
echo eula=true>eula.txt
:END
java.exe -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -Xmx6144M -Xms4096M -jar forge-1.12.2-14.23.5.2846-universal.jar nogui
pause