# Painel de Secretaria de Educação

Um painel administrativo desenvolvido em Flutter para gerenciamento de dados educacionais.

## 🚀 Funcionalidades

- Interface responsiva e moderna
- Integração automática com JSON Server
- Gráficos e visualizações de dados
- Tema claro e escuro

## 📋 Pré-requisitos

- Flutter SDK (versão 2.18.6 ou superior)
- Node.js e npm
- JSON Server (instalado automaticamente pelos scripts)

## 🛠️ Instalação e Execução

### Método 1: Scripts Automáticos (Recomendado)

#### Windows:
```bash
start.bat
```

#### Linux/Mac:
```bash
chmod +x start.sh
./start.sh
```

### Método 2: Manual

1. **Instalar dependências do Flutter:**
```bash
flutter pub get
```

2. **Instalar JSON Server (se não estiver instalado):**
```bash
npm install -g json-server
```

3. **Executar o projeto:**
```bash
flutter run
```

O JSON Server será iniciado automaticamente na porta 3000 quando o Flutter for executado.

## 🔧 Como Funciona a Inicialização Automática

O projeto foi configurado para iniciar o JSON Server automaticamente:

1. **JsonServerManager**: Classe responsável por gerenciar o processo do json-server
2. **main.dart**: Modificado para iniciar o json-server antes de executar o app
3. **Scripts atualizados**: start.sh e start.bat foram melhorados para verificar dependências

### Arquivos Modificados:
- `lib/main.dart` - Adicionada inicialização automática do json-server
- `lib/json_server_manager.dart` - Nova classe para gerenciar o json-server
- `start.sh` - Script melhorado para Linux/Mac
- `start.bat` - Script melhorado para Windows

## 📊 API JSON Server

O JSON Server estará disponível em: `http://localhost:3000`

### Endpoints disponíveis:
- `GET /produtos` - Lista todos os produtos
- `POST /produtos` - Cria um novo produto
- `PUT /produtos/:id` - Atualiza um produto
- `DELETE /produtos/:id` - Remove um produto

## 🎨 Temas

O aplicativo suporta tema claro e escuro, configurado para usar o tema escuro por padrão.

## 📱 Plataformas Suportadas

- Android
- iOS
- Web
- Windows
- macOS
- Linux

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

