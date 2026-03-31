# 📱 App de Gestão de Hábitos para Idosos

## 🧠 Sobre o Projeto
Este projeto consiste no desenvolvimento de um aplicativo mobile (Android e iOS) utilizando Flutter, com foco em auxiliar idosos na gestão de hábitos diários.

A aplicação permitirá o acompanhamento de atividades essenciais como:
- 💧 Beber água  
- 💊 Tomar medicamentos  
- 🏃 Praticar exercícios  
- 🍽 Alimentação  

Além disso, contará com um Chatbot com Inteligência Artificial para auxiliar o usuário de forma simples e acessível.

---

## 🎯 Objetivo
Desenvolver uma solução intuitiva, acessível e funcional que ajude idosos a manterem uma rotina saudável, utilizando tecnologia de forma simples e eficiente.

---

## 🚀 Funcionalidades

- 🔐 Autenticação de usuário (Login)
- 📋 Cadastro de hábitos
- 📊 Visualização de hábitos
- ✅ Marcação de hábitos como concluídos
- 🤖 Chatbot interativo
- 🧠 Integração com API de Inteligência Artificial

---

## 🏗️ Arquitetura do Projeto

O projeto está organizado da seguinte forma:

lib/
├── core/
│ ├── constants/
│ ├── utils/
│ ├── theme/
│ └── services/
├── data/
│ ├── datasources/
│ ├── models/
│ └── repositories/
├── domain/
│ ├── entities/
│ ├── repositories/
│ └── usecases/
├── presentation/
│ ├── controllers/
│ ├── screens/
│ └── widgets/
├── routes/
└── main.dart

## 🛠️ Tecnologias Utilizadas (A melhorar)

- Flutter
- Dart
- PostgreSQL
- API de Inteligência Artificial

---

## 📅 Cronograma (Sprints)

| Sprint | Data | Entrega |
|--------|------|--------|
| S1 | 04/04/2026 | Arquitetura + Layout |
| S2 | 11/04/2026 | Navegação |
| S3 | 18/04/2026 | Banco de dados + CRUD |
| S4 | 25/04/2026 | Login |
| S5 | 02/05/2026 | Funcionalidades de hábitos |
| S6 | 09/05/2026 | Chatbot |
| S7 | 16/05/2026 | Integração com IA |
| S8 | 23/05/2026 | Testes e entrega final |

---

## 📱 Telas do Aplicativo

- Tela de Login  
- Tela principal (visualização de hábitos)  
- Tela de cadastro de hábitos  
- Tela de Chatbot com IA  

---

## 🧪 Status do Projeto

🚧 Em desenvolvimento — seguindo metodologia baseada em sprints semanais.

---

## 👥 Equipe

Projeto desenvolvido em grupo como parte do curso de Ciência da Computação.

---

## 📌 Como Executar o Projeto

```bash
# Clone o repositório
git clone <url-do-repositorio>

# Acesse a pasta
cd nome-do-projeto

# Instale as dependências
flutter pub get

# Execute o projeto
flutter run