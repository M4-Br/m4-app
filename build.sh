#!/bin/bash

echo "🚀 Iniciando o setup do Flutter na Vercel..."

# 1. Baixa o Flutter na versão stable
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# 2. Habilita o web, remove o lock corrompido e baixa dependências
flutter config --enable-web
rm pubspec.lock 
flutter pub get

echo "🔐 Gerando arquivo .env..."

# 3. Cria o arquivo .env exatamente com as mesmas chaves do seu arquivo local
echo "SENTRY_DNS=$SENTRY_DNS" > .env
echo "SENTRY_SECURE=$SENTRY_SECURE" >> .env
echo "URL_RELEASE=$URL_RELEASE" >> .env
echo "URL_HOMOL=$URL_HOMOL" >> .env

echo "🏗️ Fazendo o build do projeto..."

# 4. Compila o projeto
flutter build web --release

echo "✅ Build concluído com sucesso!"