#!/bin/bash

echo "🚀 Iniciando o setup do Flutter na Vercel..."

# 1. Baixa o Flutter na versão stable
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# 2. Habilita o web e baixa as dependências
flutter config --enable-web
flutter pub get

echo "🔐 Gerando arquivo .env..."

# 3. Cria o arquivo .env usando as variáveis injetadas pela Vercel
# Substitua "BASE_URL" e "API_KEY" pelos nomes exatos que você usa no seu .env
echo "BASE_URL=$URL_HOMOL" > .env
# Use '>' para a primeira linha e '>>' para as próximas linhas!

echo "🏗️ Fazendo o build do projeto..."

# 4. Compila o projeto
flutter build web --release

echo "✅ Build concluído com sucesso!"