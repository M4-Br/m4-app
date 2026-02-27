#!/bin/bash

echo "🚀 Iniciando o setup do Flutter na Vercel..."

# 1. Baixa o Flutter na versão stable
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# 2. Habilita o web, remove o lock corrompido e baixa dependências
flutter config --enable-web
rm pubspec.lock # <-- Adicionamos isso para forçar uma instalação limpa!
flutter pub get

echo "🔐 Gerando arquivo .env..."

# 3. Cria o arquivo .env
echo "BASE_URL=$URL_HOMOL" > .env
# Se tiver mais variáveis, adicione com >> aqui

echo "🏗️ Fazendo o build do projeto..."

# 4. Compila o projeto
flutter build web --release

echo "✅ Build concluído com sucesso!"