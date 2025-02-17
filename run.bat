@echo off

:: Устанавливаем кодовую страницу UTF-8 для корректного отображения русских символов
chcp 65001 >nul

:: Путь к директории виртуального окружения (можно изменить)
set VENV_DIR=.venv

:: Проверяем, существует ли виртуальное окружение
if not exist %VENV_DIR% (
    echo Виртуальное окружение не найдено. Убедитесь, что оно создано.
    pause
    exit /b 1
)

:: Активация виртуального окружения
echo Активируем виртуальное окружение...
call %VENV_DIR%\Scripts\activate

if %errorlevel% neq 0 (
    echo Не удалось активировать виртуальное окружение.
    pause
    exit /b 1
)

:: Проверяем, существует ли файл main.py
if not exist main.py (
    echo Файл main.py не найден.
    pause
    exit /b 1
)

:: Запускаем main.py
echo Запускаем main.py...
python main.py

if %errorlevel% neq 0 (
    echo Произошла ошибка при выполнении main.py.
    pause
    exit /b 1
)

echo Скрипт main.py успешно выполнен.
pause