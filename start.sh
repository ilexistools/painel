#!/bin/bash

# Script melhorado para iniciar o projeto Flutter com json-server automático
# Agora o json-server é iniciado automaticamente pelo próprio Flutter

echo "🚀 Iniciando Painel de Secretaria de Educação..."
echo "📊 O JSON Server será iniciado automaticamente pelo Flutter"
echo ""

# Verifica se o Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter não encontrado. Instale o Flutter primeiro."
    exit 1
fi

# Verifica se o json-server está instalado
if ! command -v json-server &> /dev/null; then
    echo "⚠️  JSON Server não encontrado. Instalando..."
    npm install -g json-server
fi

# Verifica se o arquivo db.json existe
if [ ! -f "db.json" ]; then
    echo "❌ Arquivo db.json não encontrado!"
    exit 1
fi

echo "✅ Tudo pronto! Iniciando o Flutter..."
echo "🌐 JSON Server estará disponível em: http://localhost:3000"
echo "📱 App Flutter será iniciado em seguida..."
echo ""

# Inicia o Flutter (que automaticamente iniciará o json-server)
flutter run

