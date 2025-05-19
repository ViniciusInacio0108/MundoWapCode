# Mundo WAP Test

## Instalação

1. **Pré-requisitos**
   - Flutter SDK `3.5.0`
   - Dart SDK compatível
   - Android Studio ou VSCode configurado para Flutter
   - Emulador ou dispositivo físico para testes

2. **Clonando o projeto**
```bash
git clone <URL_DO_REPOSITORIO>
cd <NOME_DO_PROJETO>
```

3. **Instalando dependências**
```bash
flutter pub get
```

4. **Gerando código com build_runner**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Configuração

- Certifique-se de que o emulador ou dispositivo está rodando.

- O banco de dados local utiliza padrão Singleton e suas configuraçõpes estão localizadas dentro da pasta `data/database`.

---

## Inicialização

Execute o projeto com:

```bash
flutter run
```

ou 

```bash
flutter run --release
```

para poder utilizar a versão final do app.

O app iniciará pela tela de login.

---

## Estrutura do Projeto

```
lib/
├── data/
│   ├── database/         # Configuração do DB
│   ├── models/           # Modelos usados para API e banco de dados 
│   ├── services/         # Serviços externos 
│   └── repositories/     # Implementações dos repositórios
│
├── domain/               # Modelos utilizados na lógica de domínio
│
├── ui/                   # Parte de UI (telas, componentes e viewmodels)
│
│
├── utils/                # Utilitários e auxiliadores
│
│
└── main.dart             # Ponto de entrada da aplicação
```

---

## Funcionalidades

### 1. **Login**
- Usuário insere `username` e `senha`.
- Ao logar, é feito um request via `Dio` para obter as tarefas associadas.

### 2. **Home**
- Lista de tarefas exibida com base nos dados:
  - Do endpoint de login.
  - Do banco local (`SQFlite`), caso estejam salvos.
- Cada tarefa possui um marcador de status: **Realizada** ou **Incompleta**.

### 3. **Edição de Tarefas**
- Usuário pode editar e concluir tarefas.
- Os campos editados são salvos localmente imediatamente (autosave) para evitar perda de dados caso o app seja fechado.

---

## Dependências Utilizadas

- **provider**: Gerenciamento de estado.
- **dio**: Requisições HTTP.
- **sqflite**: Banco de dados local.
- **json_serializable + build_runner**: Serialização automatizada de modelos.
- **flutter_multi_formatter**: Máscaras e formatações de texto.
