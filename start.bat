@echo off
REM Script melhorado para iniciar o projeto Flutter com json-server automático
REM Agora o json-server é iniciado automaticamente pelo próprio Flutter

echo 🚀 Iniciando Painel de Secretaria de Educação...
echo 📊 O JSON Server será iniciado automaticamente pelo Flutter
echo.

REM Verifica se o Flutter está instalado
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter não encontrado. Instale o Flutter primeiro.
    pause
    exit /b 1
)

REM Verifica se o json-server está instalado
json-server --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  JSON Server não encontrado. Instalando...
    npm install -g json-server
)

REM Verifica se o arquivo db.json existe
if not exist "db.json" (
    echo ❌ Arquivo db.json não encontrado!
    pause
    exit /b 1
)

echo ✅ Tudo pronto! Iniciando o Flutter...
echo 🌐 JSON Server estará disponível em: http://localhost:3000
echo 📱 App Flutter será iniciado em seguida...
echo.

REM Inicia o Flutter (que automaticamente iniciará o json-server)
flutter run

pause

