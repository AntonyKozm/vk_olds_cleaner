@echo off

:: Устанавливаем кодовую страницу UTF-8 для корректного отображения русских символов
chcp 65001 >nul

:: Проверяем, установлен ли Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python не найден. Убедитесь, что Python установлен и добавлен в переменную PATH.
    pause
    exit /b 1
)

:: Путь к директории виртуального окружения (можно изменить)
set VENV_DIR=.venv

:: Проверяем, существует ли уже виртуальное окружение
if exist %VENV_DIR% (
    echo Виртуальное окружение уже существует.
) else (
    echo Создаем виртуальное окружение...
    python -m venv %VENV_DIR%
    if %errorlevel% neq 0 (
        echo Не удалось создать виртуальное окружение.
        pause
        exit /b 1
    )
    echo Виртуальное окружение создано.
)

:: Активация виртуального окружения
echo Активируем виртуальное окружение...
call %VENV_DIR%\Scripts\activate

if %errorlevel% neq 0 (
    echo Не удалось активировать виртуальное окружение.
    pause
    exit /b 1
)

:: Установка зависимостей из файла req.txt
if exist req.txt (
    echo Устанавливаю зависимости из req.txt...
    pip install --upgrade pip
    pip install -r req.txt
    if %errorlevel% neq 0 (
        echo Произошла ошибка при установке зависимостей.
        pause
        exit /b 1
    )
    echo Зависимости успешно установлены.
) else (
    echo Файл req.txt не найден. Пропускаю установку зависимостей.
)

echo Виртуальное окружение успешно активировано и готово к работе.
pause