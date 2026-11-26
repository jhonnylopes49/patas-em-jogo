# Patas em Jogo

Projeto do PIE II. A Patas em Jogo é uma ONG de adoção de animais que faz campeonatos de video game pra arrecadar doações pro abrigo.

Front-end com Vite+, API com Express e banco MySQL.

## Como rodar

Precisa ter o Node.js, o Vite+ e o MySQL instalados.

```
git clone https://github.com/jhonnylopes49/patas-em-jogo.git
cd patas-em-jogo
vp install
```

No MySQL, criar o banco rodando o arquivo `database/schema.sql`:

```
SOURCE database/schema.sql;
```

Copiar o arquivo `.env.example` e renomear a cópia para `.env`.

Abrir dois terminais na pasta do projeto:

- Terminal 1: `vp run api`
- Terminal 2: `vp dev`

Depois abrir http://localhost:5173. A página mostra "Status da API: ok" com a data e a hora.
