
## Arquitetura Utilizada

O projeto segue uma abordagem baseada em Clean Architecture e Feature-based, com as camadas:

```
lib/
|-- core/ # Recursos globais (Rotas, Injeção de Dependência, Services ...) 
|-- features/
| |-- pokemon/
| |-- data/ # DataSource + Repository Implementation
| |-- domain/ # Entities + Repository Contrato + UseCases
| |-- presentation/# UI + Notifier (ValueNotifier)
```

## Gerenciamento de Estado
Foi utilizado ValueNotifier, pela simplicidade e não depender de packages externos

## Como Rodar o Projeto
- Flutter SDK instalado (versão 3.35.6)
- Dispositivo Android/iOS ou emulador configurado

## Entre na pasta 
- cd /pokeapi

## Instale as dependência
- flutter pub get

## Rodar o projeto 
- flutter run

## Funcionalidades Implementadas no level_1

- [x] Consumo da PokeAPI (`/api/v2/pokemon`,`/api/v2/pokemon/id` )
- [x] Mostrar uma listagem de Pokémons com:
  - Imagem
  - Nome
- [x] Tela de detalhes contendo:
  - Imagem
  - Nome
  - Altura
  - Peso

## Funcionalidades Implementadas no level_2

- [x] Armazenar localmente em cache as consultas feitas à API
- [x] Criar um filtro por nome para a listagem
- [x] Tela de detalhes contendo:
  - Tipos
  - Habilidades
