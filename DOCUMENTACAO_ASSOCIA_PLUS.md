# Documentação Técnica - Associa+

Este documento descreve a arquitetura técnica e as especificações do projeto **Associa+**, desenvolvido com o framework Flutter.

## 1. Dispositivos Destinados

O aplicativo foi projetado para ser multiplataforma, atendendo aos seguintes sistemas:

*   **iOS**: Suporte nativo para iPhones e iPads.
*   **Android**: Suporte nativo para smartphones e tablets.
*   **Web (Futuro)**: Planejado para suporte futuro, aproveitando a capacidade de renderização web do Flutter.

---

## 2. Arquitetura do Projeto

O projeto utiliza uma arquitetura **Modular baseada em Features**, combinada com o padrão **GetX** para gerenciamento de estado e injeção de dependências. Esta abordagem permite alta escalabilidade, facilidade de manutenção e separação de responsabilidades.

### 2.1. Estrutura de Pastas (`/lib`)

Abaixo está o detalhamento técnico da pasta raiz do código-fonte:

*   **`core/`**: Contém as fundações do sistema. É dividido em duas grandes áreas:
    *   **`config/`**: Centraliza as definições globais do aplicativo.
        *   `app/`: Configurações de cores (`app_colors.dart`), ciclo de vida (`app_lifecycle_controller.dart`) e inicialização.
        *   `auth/`: Lógica central de autenticação global.
        *   `consts/`: Constantes globais, caminhos de arquivos e cabeçalhos.
        *   `language/`: Configurações de idioma e localização.
        *   `log/`: Implementação de logs customizados para depuração.
        *   `routes/`: Sistema de roteamento centralizado, organizado por módulos para facilitar a navegação GetX.
    *   **`helpers/`**: Utilitários e funções de suporte.
        *   `extensions/`: Extensões de classes do Dart/Flutter.
        *   `formatters/`: Formatadores de texto (moeda, data, máscaras).
        *   `validators.dart`: Validadores de formulários (E-mail, CPF, CNPJ, etc.).
        *   `sentry_helper.dart`: Integração com monitoramento de erros Sentry.
        *   `connection/`: Verificação de estado de conectividade.

### 2.2. Detalhamento dos Arquivos: `/lib/core/config/app`

Esta pasta contém os arquivos fundamentais que regem o comportamento global da aplicação:

1.  **`app.dart`**: Define a classe principal `MiBan4`.
    *   Gerencia o estado inicial de localização (Locale).
    *   Configura o `GetMaterialApp` com rotas, traduções e observadores do Sentry.
    *   Implementa o `GestureDetector` global para fechar o teclado ao tocar fora de campos de texto.
    *   Envolve a aplicação em um `Stack` que permite exibir a "cortina de privacidade" (`PrivacyCurtain`).

2.  **`app_colors.dart`**: Centraliza o guia de estilos de cores.
    *   Define as cores primárias, secundárias e neutras.
    *   Contém cores específicas para estados de botões, calendários, extratos e operadoras.
    *   Facilita a manutenção visual e garante consistência em todo o projeto.

3.  **`app_init.dart`**: Contém a classe `AppSetup`.
    *   Orquestra a sequência de inicialização: carregamento de variáveis de ambiente (`.env`), inicialização do `GetStorage` e dos serviços de autenticação e customização.
    *   Configura controladores permanentes como `UserRx`, `BalanceRx` e `TrackerController`.
    *   Decide entre rodar o app direto (Debug) ou via `SentryFlutter.init` (Release).

4.  **`app_lifecycle_controller.dart`**: Gerencia o ciclo de vida do aplicativo.
    *   Detecta quando o app entra em segundo plano ou retorna para o primeiro plano.
    *   **Segurança**: Ativa a cortina de privacidade e solicita biometria ao retomar o app após um período de inatividade (30 segundos de carência).
    *   Realiza a renovação silenciosa do token de acesso via biometria para garantir que o usuário não seja deslogado abruptamente.

### 2.3. Detalhamento do Módulo: `/lib/core/config/auth`

Este módulo centraliza toda a inteligência de autenticação e gestão de perfil de usuário do sistema. Ele segue o padrão de camadas para garantir segurança e reuso:

1.  **`bindings/`**: Responsável pela injeção de dependências global de autenticação.
2.  **`controller/`**: Camada de lógica de negócio da autenticação (inclui `UserRx` e `AuthRedirectController`).
3.  **`model/`**: Estruturas de dados como o modelo `User`.
4.  **`repositories/`**: Chamadas HTTP para os endpoints de autenticação.
5.  **`service/`**: `AuthService` e `AuthGuard` para proteção de rotas.

---

*   **`data/`**: Camada de dados responsável pela comunicação externa.
    *   `api/`: Implementação de clientes HTTP, interceptores e definições de endpoints.
*   **`features/`**: Pasta que contém os módulos de negócio do aplicativo (Pix, Saldo, IA, etc.).
*   **`l18n/`**: Centraliza toda a internacionalização (Português, Inglês, Espanhol).
*   **`main.dart`**: O ponto de entrada técnico, delegando a inicialização para o `AppSetup`.

---

## 3. Stack Tecnológica

*   **Linguagem**: Dart
*   **Framework**: Flutter
*   **Gerenciamento de Estado**: GetX
*   **Monitoramento**: Sentry
*   **IA**: Google Gemini
