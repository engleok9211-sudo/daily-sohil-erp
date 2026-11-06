@echo off
chcp 65001 > nul
title [데일리소힐평생교육연구회] 통합회계ERP v3.0 원클릭 실행기
echo =====================================================================
echo    [DAILY SOHIL ERP] 데일리소힐평생교육연구회 통합회계ERP v3.0
echo =====================================================================
echo.
echo [*] 시스템 환경 점검 중...

:: 현재 배치파일 디렉터리 기준으로 루트 폴더 이동
cd /d "%~dp0\.."

:: 포트 8080 실행 여부 확인
netstat -ano | findstr ":8080" | findstr "LISTENING" > nul
if %errorlevel% equ 0 (
    echo [!] 이미 ERP 서버가 8080 포트에서 실행 중입니다.
    echo [*] 브라우저를 바로 오픈합니다.
    start http://localhost:8080
    goto END
)

echo [*] ERP 서버를 기동합니다...
set PYTHON_CMD=python
where python > nul 2>&1
if %errorlevel% neq 0 (
    set PYTHON_CMD="C:\Users\LG\AppData\Local\Programs\Python\Python312\python.exe"
)

start "DAILY_SOHIL_ERP_SERVER" %PYTHON_CMD% "result\[030]_웹기반_통합회계ERP_세금계산서_체크및목록관리시스템.py"

echo [*] 서버 초기화 대기 중... (2초)
timeout /t 2 /nobreak > nul

echo [*] 웹 브라우저를 실행합니다...
start http://localhost:8080

echo.
echo =====================================================================
echo  ERP 시스템이 정상 구동되었습니다!
echo  - 로컬 주소: http://localhost:8080
echo  - 서버 창을 닫으면 ERP 서비스가 종료됩니다.
echo =====================================================================
echo.

:END
pause
