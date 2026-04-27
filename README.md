# 📱 App de Gestão de Hábitos para Idosos

Aplicativo mobile desenvolvido com **Flutter** e **Dart**, com backend separado em **TypeScript + Express + Prisma**, voltado para o acompanhamento de hábitos diários e suporte com chatbot/IA.

---

## 🧠 Sobre o Projeto

Este projeto consiste em um aplicativo mobile para Android e iOS com foco em auxiliar idosos na gestão de hábitos diários, como:

- 💧 Beber água
- 💊 Tomar medicamentos
- 🏃 Praticar exercícios
- 🍽 Alimentação

A aplicação também possui autenticação, cadastro e acompanhamento de hábitos, além de integração com chatbot e recursos de IA.

---

## 🎯 Objetivo

Desenvolver uma solução intuitiva, acessível e funcional para ajudar idosos a manter uma rotina saudável, usando tecnologia de forma simples e eficiente.

---

## 🚀 Funcionalidades

- 📋 Cadastro de hábitos
- 📊 Visualização de hábitos
- ✅ Marcação de hábitos como concluídos
- 🤖 Chatbot interativo
- 🧠 Integração com API de Inteligência Artificial
- 🗄️ Persistência de dados via backend + PostgreSQL

---

## 🧰 Tech Stack

### Frontend

- Flutter
- Dart
- Provider
- Firebase Auth
- Shared Preferences
- HTTP

### Backend

- Node.js
- TypeScript
- Express
- Prisma ORM
- SQlite
- dotenv

---

## 📦 Pré-requisitos

Antes de rodar o projeto, você precisa ter instalado:

- **Flutter SDK**
- **Dart** (vem com o Flutter)
- **Node.js** (recomendado LTS)
- **npm**
- **Git**

---

## 🗂️ Estrutura do Projeto

A estrutura atual do repositório está organizada assim:

```text
ProjetoFlutter/
├── api/                      # Backend em TypeScript + Express + Prisma
├── lib/                      # App Flutter
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── assets/
├── firebase.json
├── pubspec.yaml
└── README.md
```

### Estrutura do Flutter (`lib/`)

```text
lib/
├── core/
│   ├── constants/
│   └── services/
│   └── config/
│   └── network/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── presentation/
│   ├── screens/
│   └── widgets/
├── routes/
├── firebase_options.dart
└── main.dart
```

### Estrutura do Backend (`api/`)

```text
api/
├── src/
├── modules/
├── prisma/
├── generated/
├── package.json
├── tsconfig.json
├── prisma.config.ts
└── .env
```

---

## ⚙️ Como Rodar o Projeto

O projeto possui **duas partes** que precisam ser executadas separadamente:

1. **Backend** (`api/`)
2. **Flutter app** (raiz do repositório)

---

## 1) Rodar o Backend (`api/`)

Entre na pasta `api`:

```bash
cd api
```

Instale as dependências:

```bash
npm install
```

### Variáveis de ambiente

Modifique o arquivo `.env.example` dentro de `api/` com as variáveis necessárias. Exemplo:

```env
DATABASE_URL="file:./dev.db"
PORT = porta_da_minha_aplicacao
```

e corrija o nome do arquivo para .env

> Ajuste os nomes e valores conforme sua implementação.

### Prisma

Se for a primeira vez que você está configurando o banco, execute as etapas abaixo dentro de `api/`:

```bash
npx prisma migrate dev
npx prisma generate
npm run start

```

Use:

- **`npx prisma generate`** quando o schema mudar e você precisar regenerar o client.
- **`npx prisma migrate dev`** quando precisar criar/aplicar migrations no banco durante o desenvolvimento.
- **`npm run start`** para iniciar a aplicação express.

---

Se for configurar o banco com dados de teste, execute as etapas abaixo dentro de `api/`:

```bash
npx prisma migrate dev
npx prisma generate
npx prisma db seed

```

Use:

- **`npx prisma generate`** quando o schema mudar e você precisar regenerar o client.
- **`npx prisma migrate dev`** quando precisar criar/aplicar migrations no banco durante o desenvolvimento.
- **`npx prisma db seed`** para popular o banco de dados com dados nos arquivos de seed.


---


## 2) Rodar o Flutter App

Volte para a raiz do projeto:

```bash
cd ..
```

Instale as dependências do Flutter:

```bash
flutter pub get
```

Para verificar os dispositivos disponíveis:

```bash
flutter devices
```

Para rodar no dispositivo desejado:

```bash
flutter run -d <device_id>
```

Exemplo:

```bash
flutter run -d emulator-5554
```

Se preferir rodar sem especificar dispositivo, basta:

```bash
flutter run
```

## 🗄️ Banco de Dados

O banco é gerenciado com **Prisma ORM** e pode ser conectado ao **SQlite**.

Se você alterar o schema:

```bash
npx prisma migrate dev
npx prisma generate
```
Será gerado um arquivo .db, com base no:

DATABASE_URL="local_do_seu_.db"
---

## 📱 Telas do Aplicativo

- Tela de Login
- Tela Principal
- Tela de Cadastro de Hábitos
- Tela de Chatbot com IA
- Tela de Configurações
- Telas de Onboarding

---

## ✅ Checklist rápido para rodar sem problemas

1. Clonar o repositório.
2. Rodar `npm install` dentro de `api/`.
3. Configurar o `.env.example` da `api/`.
4. Rodar `npx prisma migrate dev --name {nome_da_migração}` e `npx prisma mgenerate` dentro de `api/`.
5. Na raiz do projeto, rodar `flutter pub get`.
6. Executar `npm run start` dentro de `api/` para iniciar a aplicação express.
7. Executar `flutter run -d <device_id>` para iniciar a aplicação flutter.

---

## 📄 Licença

Uso acadêmico e/ou interno do projeto.
