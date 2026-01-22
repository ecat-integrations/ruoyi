@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: PostgreSQL Database Backup and Restore Script
:: Supports PostgreSQL 12.10 version
:: Version: 1.0.1 (Fixed Version)

:: Default configuration
set "DEFAULT_HOST=localhost"
set "DEFAULT_PORT=5432"
set "DEFAULT_USER=postgres"
set "DEFAULT_DB=postgres"
set "DEFAULT_BACKUP_DIR=backups"
set "DEFAULT_MODE=full"
set "DEFAULT_FORMAT=custom"
set "PGPASSWORD="

:: Check if parameters are provided
if "%1"=="" goto show_help

:: Parse command line arguments
call :parse_args %*

:: Check PostgreSQL tools
call :check_tools

:: Execute operation
if "%OPERATION%"=="backup" goto do_backup
if "%OPERATION%"=="restore" goto do_restore
echo Error: Unknown operation '%OPERATION%'
goto show_help

:: Show help information
:show_help
echo.
echo PostgreSQL Database Backup and Restore Script
echo =============================================
echo.
echo Usage:
echo   postgres_backup_restore.bat [operation] [options]
echo.
echo Operations:
echo   backup     - Backup database
echo   restore    - Restore database
echo   help       - Show this help information
echo.
echo Backup Options:
echo   -h, --host HOST         Database host (default: %DEFAULT_HOST%)
echo   -p, --port PORT         Database port (default: %DEFAULT_PORT%)
echo   -U, --user USER         Database user (default: %DEFAULT_USER%)
echo   -d, --dbname DBNAME     Database name (default: %DEFAULT_DB%)
echo   -W, --password          Prompt for password
echo   -P, --password-env      Get password from PGPASSWORD environment variable
echo   -o, --output DIR        Backup directory (default: %DEFAULT_BACKUP_DIR%)
echo   -m, --mode MODE         Backup mode (default: %DEFAULT_MODE%)
echo                         schema_only - Schema only
echo                         data_only   - Data only
echo                         full        - Schema and data
echo   -f, --format FORMAT     Backup format (default: %DEFAULT_FORMAT%)
echo                         custom     - Custom format (recommended)
echo                         plain      - Plain text format
echo                         directory  - Directory format
echo   -t, --tables TABLES     Specify tables to backup, comma separated
echo   -e, --exclude TABLES    Exclude tables, comma separated
echo   -v, --verbose           Verbose output
echo   -c, --compress          Compress backup file
echo.
echo Restore Options:
echo   -h, --host HOST         Database host (default: %DEFAULT_HOST%)
echo   -p, --port PORT         Database port (default: %DEFAULT_PORT%)
echo   -U, --user USER         Database user (default: %DEFAULT_USER%)
echo   -d, --dbname DBNAME     Database name (default: %DEFAULT_DB%)
echo   -W, --password          Prompt for password
echo   -P, --password-env      Get password from PGPASSWORD environment variable
echo   -i, --input FILE        Backup file path
echo   -t, --tables TABLES     Specify tables to restore, comma separated
echo   -v, --verbose           Verbose output
echo   -c, --clean             Clean database before restore
echo   -s, --schema-only       Restore schema only
echo.
echo Examples:
echo   Backup database:
echo     postgres_backup_restore.bat backup -d mydb -o my_backups
echo.
echo   Backup database (prompt for password):
echo     postgres_backup_restore.bat backup -d mydb -W
echo.
echo   Backup schema only:
echo     postgres_backup_restore.bat backup -d mydb -m schema_only
echo.
echo   Backup specific tables:
echo     postgres_backup_restore.bat backup -d mydb -t "users,orders,products"
echo.
echo   Restore database:
echo     postgres_backup_restore.bat restore -d mydb -i backup_file.dump
echo.
echo   Restore database (prompt for password):
echo     postgres_backup_restore.bat restore -d mydb -i backup_file.dump -W
echo.
echo   Restore specific tables:
echo     postgres_backup_restore.bat restore -d mydb -i backup_file.dump -t "users,orders"
echo.
goto :eof

:: Parse command line arguments
:parse_args
set "OPERATION=%1"
if "%OPERATION%"=="" goto show_help

shift
set "HOST=%DEFAULT_HOST%"
set "PORT=%DEFAULT_PORT%"
set "USER=%DEFAULT_USER%"
set "DBNAME=%DEFAULT_DB%"
set "BACKUP_DIR=%DEFAULT_BACKUP_DIR%"
set "MODE=%DEFAULT_MODE%"
set "FORMAT=%DEFAULT_FORMAT%"
set "TABLES="
set "EXCLUDE_TABLES="
set "BACKUP_FILE="
set "VERBOSE="
set "COMPRESS="
set "CLEAN="
set "SCHEMA_ONLY="
set "PASSWORD_PROMPT="
set "PASSWORD_ENV="

:parse_loop
if "%1"=="" goto parse_done
if "%1"=="-h" (
    set "HOST=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--host" (
    set "HOST=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-p" (
    set "PORT=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--port" (
    set "PORT=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-U" (
    set "USER=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--user" (
    set "USER=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-W" (
    set "PASSWORD_PROMPT=1"
    shift
    goto parse_loop
)
if "%1"=="--password" (
    set "PASSWORD_PROMPT=1"
    shift
    goto parse_loop
)
if "%1"=="-P" (
    set "PASSWORD_ENV=1"
    shift
    goto parse_loop
)
if "%1"=="--password-env" (
    set "PASSWORD_ENV=1"
    shift
    goto parse_loop
)
if "%1"=="-d" (
    set "DBNAME=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--dbname" (
    set "DBNAME=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-o" (
    set "BACKUP_DIR=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--output" (
    set "BACKUP_DIR=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-m" (
    set "MODE=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--mode" (
    set "MODE=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-f" (
    set "FORMAT=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--format" (
    set "FORMAT=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-t" (
    set "TABLES=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--tables" (
    set "TABLES=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-e" (
    set "EXCLUDE_TABLES=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--exclude" (
    set "EXCLUDE_TABLES=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-i" (
    set "BACKUP_FILE=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="--input" (
    set "BACKUP_FILE=%2"
    shift
    shift
    goto parse_loop
)
if "%1"=="-v" (
    set "VERBOSE=1"
    shift
    goto parse_loop
)
if "%1"=="--verbose" (
    set "VERBOSE=1"
    shift
    goto parse_loop
)
if "%1"=="-c" (
    set "COMPRESS=1"
    shift
    goto parse_loop
)
if "%1"=="--compress" (
    set "COMPRESS=1"
    shift
    goto parse_loop
)
if "%1"=="--clean" (
    set "CLEAN=1"
    shift
    goto parse_loop
)
if "%1"=="-s" (
    set "SCHEMA_ONLY=1"
    shift
    goto parse_loop
)
if "%1"=="--schema-only" (
    set "SCHEMA_ONLY=1"
    shift
    goto parse_loop
)
shift
goto parse_loop

:parse_done

:: Handle password
if "%PASSWORD_PROMPT%"=="1" (
    set /p "PGPASSWORD=Enter database password: "
) else if "%PASSWORD_ENV%"=="1" (
    if "%VERBOSE%"=="1" echo Getting password from PGPASSWORD environment variable
) else (
    :: If no password option specified, try to get from environment variable
    if not "%PGPASSWORD%"=="" (
        if "%VERBOSE%"=="1" echo Using password from environment variable
    ) else (
        if "%VERBOSE%"=="1" echo No password set, will use PostgreSQL default authentication
    )
)

if "%VERBOSE%"=="1" (
    echo Parsed parameters:
    echo   Operation: %OPERATION%
    echo   Host: %HOST%
    echo   Port: %PORT%
    echo   User: %USER%
    echo   Database: %DBNAME%
    if "%OPERATION%"=="backup" (
        echo   Backup directory: %BACKUP_DIR%
        echo   Mode: %MODE%
        echo   Format: %FORMAT%
        if not "%TABLES%"=="" echo   Tables: %TABLES%
        if not "%EXCLUDE_TABLES%"=="" echo   Exclude tables: %EXCLUDE_TABLES%
        if "%COMPRESS%"=="1" echo   Compress: Yes
    )
    if "%OPERATION%"=="restore" (
        echo   Backup file: %BACKUP_FILE%
        if not "%TABLES%"=="" echo   Tables: %TABLES%
        if "%CLEAN%"=="1" echo   Clean: Yes
        if "%SCHEMA_ONLY%"=="1" echo   Schema only: Yes
    )
    echo.
)
goto :eof

:: Check PostgreSQL tools
:check_tools
if "%VERBOSE%"=="1" echo Checking PostgreSQL tools...
where pg_dump >nul 2>&1
if errorlevel 1 (
    echo Error: pg_dump tool not found, please ensure PostgreSQL is installed and added to PATH
    goto :eof
)
where pg_restore >nul 2>&1
if errorlevel 1 (
    echo Error: pg_restore tool not found, please ensure PostgreSQL is installed and added to PATH
    goto :eof
)
where psql >nul 2>&1
if errorlevel 1 (
    echo Error: psql tool not found, please ensure PostgreSQL is installed and added to PATH
    goto :eof
)
goto :eof

:: Execute backup
:do_backup
if "%VERBOSE%"=="1" echo Starting database backup...

:: Create backup directory
if not exist "%BACKUP_DIR%" (
    if "%VERBOSE%"=="1" echo Creating backup directory: %BACKUP_DIR%
    mkdir "%BACKUP_DIR%"
)

:: Generate backup filename
for /f "tokens=1-6 delims=/ " %%a in ('date /t') do set "DATE=%%a%%b%%c"
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set "TIME=%%a%%b"
set "BACKUP_FILE=%BACKUP_DIR%\%DBNAME%_%MODE%_%DATE%_%TIME%"

:: Build pg_dump command
set "DUMP_CMD=pg_dump -h %HOST% -p %PORT% -U %USER% -d %DBNAME%"

:: Add format options
if "%FORMAT%"=="custom" (
    set "DUMP_CMD=!DUMP_CMD! -Fc"
    set "BACKUP_FILE=!BACKUP_FILE!.dump"
) else if "%FORMAT%"=="plain" (
    set "DUMP_CMD=!DUMP_CMD! -Fp"
    set "BACKUP_FILE=!BACKUP_FILE!.sql"
) else if "%FORMAT%"=="directory" (
    set "DUMP_CMD=!DUMP_CMD! -Fd"
    set "BACKUP_FILE=!BACKUP_FILE!_dir"
)

:: Add mode options
if "%MODE%"=="schema_only" (
    set "DUMP_CMD=!DUMP_CMD! --schema-only"
) else if "%MODE%"=="data_only" (
    set "DUMP_CMD=!DUMP_CMD! --data-only"
)

:: Add table options
if not "%TABLES%"=="" (
    for %%t in (%TABLES%) do (
        set "DUMP_CMD=!DUMP_CMD! -t %%t"
    )
)

:: Add exclude table options
if not "%EXCLUDE_TABLES%"=="" (
    for %%t in (%EXCLUDE_TABLES%) do (
        set "DUMP_CMD=!DUMP_CMD! -T %%t"
    )
)

:: Add verbose output
if "%VERBOSE%"=="1" (
    set "DUMP_CMD=!DUMP_CMD! -v"
)

:: Add output file
if "%FORMAT%"=="directory" (
    set "DUMP_CMD=!DUMP_CMD! -f !BACKUP_FILE!"
) else (
    set "DUMP_CMD=!DUMP_CMD! -f !BACKUP_FILE!"
)

:: Execute backup
if "%VERBOSE%"=="1" echo Executing command: !DUMP_CMD!
!DUMP_CMD!
if errorlevel 1 (
    echo Error: Backup failed
    goto :eof
)

:: Compress backup file (if needed)
if "%COMPRESS%"=="1" (
    if not "%FORMAT%"=="directory" (
        if "%VERBOSE%"=="1" echo Compressing backup file...
        powershell -Command "Compress-Archive -Path '!BACKUP_FILE!' -DestinationPath '!BACKUP_FILE!.zip' -Force"
        if exist "!BACKUP_FILE!.zip" (
            del "!BACKUP_FILE!"
            set "BACKUP_FILE=!BACKUP_FILE!.zip"
        )
    )
)

echo Backup completed: !BACKUP_FILE!
goto :eof

:: Execute restore
:do_restore
if "%VERBOSE%"=="1" echo Starting database restore...

:: Check backup file
if "%BACKUP_FILE%"=="" (
    echo Error: No backup file path specified (-i or --input)
    goto :eof
)
if not exist "%BACKUP_FILE%" (
    echo Error: Backup file not found: %BACKUP_FILE%
    goto :eof
)

:: Extract backup file (if compressed)
set "RESTORE_FILE=%BACKUP_FILE%"
if "%BACKUP_FILE:~-4%"==".zip" (
    if "%VERBOSE%"=="1" echo Extracting backup file...
    set "RESTORE_FILE=%BACKUP_FILE:~0,-4%"
    powershell -Command "Expand-Archive -Path '%BACKUP_FILE%' -DestinationPath '%TEMP%' -Force"
    if exist "%TEMP%\*.dump" (
        for %%f in ("%TEMP%\*.dump") do set "RESTORE_FILE=%%f"
    ) else if exist "%TEMP%\*.sql" (
        for %%f in ("%TEMP%\*.sql") do set "RESTORE_FILE=%%f"
    )
)

:: Build pg_restore command
set "RESTORE_CMD="
if "%RESTORE_FILE:~-4%"==".dump" (
    set "RESTORE_CMD=pg_restore -h %HOST% -p %PORT% -U %USER% -d %DBNAME%"
    
    :: Add clean option
    if "%CLEAN%"=="1" (
        set "RESTORE_CMD=!RESTORE_CMD! --clean"
    )
    
    :: Add schema only option
    if "%SCHEMA_ONLY%"=="1" (
        set "RESTORE_CMD=!RESTORE_CMD! --schema-only"
    )
    
    :: Add table options
    if not "%TABLES%"=="" (
        for %%t in (%TABLES%) do (
            set "RESTORE_CMD=!RESTORE_CMD! -t %%t"
        )
    )
    
    :: Add verbose output
    if "%VERBOSE%"=="1" (
        set "RESTORE_CMD=!RESTORE_CMD! -v"
    )
    
    :: Add backup file
    set "RESTORE_CMD=!RESTORE_CMD! !RESTORE_FILE!"
    
) else (
    :: Use psql to restore SQL file
    set "RESTORE_CMD=psql -h %HOST% -p %PORT% -U %USER% -d %DBNAME% -f !RESTORE_FILE!"
    
    :: Add verbose output
    if "%VERBOSE%"=="1" (
        set "RESTORE_CMD=!RESTORE_CMD! -v"
    )
)

:: Execute restore
if "%VERBOSE%"=="1" echo Executing command: !RESTORE_CMD!
!RESTORE_CMD!
if errorlevel 1 (
    echo Error: Restore failed
    goto :eof
)

:: Clean up temporary files
if "%BACKUP_FILE:~-4%"==".zip" (
    if exist "%TEMP%\*.dump" del "%TEMP%\*.dump"
    if exist "%TEMP%\*.sql" del "%TEMP%\*.sql"
)

echo Restore completed
goto :eof 