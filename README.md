## Busca Por CEP

Uma aplicação web que permite a consulta de informações de CEPs brasileiros
consumindo informações da API [Awesomeapi](https://docs.awesomeapi.com.br/api-cep) e exibe estatísticas de quantidade de buscas por CEP.

### Funcionalidades

✅ Consulta por CEP e exibição das informações de endereço do CEP buscado <br>
✅ Estatística dos 3 CEPs mais buscados na aplicação <br>
✅ Estatística dos CEPs mais buscados por Estado <br>
✅ Estatística da quantidade de CEPs buscados por Estado

![peek_2](https://github.com/user-attachments/assets/436e08c5-f6de-448d-84ee-ee4ad9be6104)

### Como rodar a aplicação

No terminal, execute o comando abaixo para fazer o clone do projeto na sua máquina:
```bash
git clone git@github.com:crisaito/buscaPorCEP.git
cd buscaPorCEP
```
Inicialização via terminal
  - requer ruby versão 3.3.7

  - Instale as gems e crie+migre o banco:
    ```bash
    bundle install
    rails db:setup
    ```
  - Inicie a aplicação
    ```bash
    bin/dev
    ```

Inicialização via docker
  - requer docker

  - Monte a imagem:
    ```bash
    docker compose build
    ```
  - Rode o container:
    ```bash
    docker compose run --rm app bash
    ```

Acesse a aplicação em http://localhost:3000

Para visualizar os testes execute:
```bash
rspec
```

### Tecnologias

- Ruby 3.3.7
- Rails 8.0.1
- Tailwind
- Docker
