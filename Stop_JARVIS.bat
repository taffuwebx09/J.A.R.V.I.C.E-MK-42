@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -LocalPort 8501 -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1; if (!$c) { Write-Host 'J.A.R.V.I.S is not running.'; exit 0 }; $p=Get-CimInstance Win32_Process -Filter ('ProcessId = ' + $c.OwningProcess); if ($p.CommandLine -match 'streamlit.*app.py') { Stop-Process -Id $c.OwningProcess -Force; Write-Host 'J.A.R.V.I.S has been stopped.' } else { Write-Host 'Port 8501 is being used by another application. Nothing was stopped.' }"
pause
