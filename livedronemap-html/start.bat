@ECHO OFF

:run
  call node %~dp0/server.js
GOTO end

:end
