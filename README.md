# Patas em Jogo

Projeto do PIE II. A Patas em Jogo é uma ONG (fictícia) de adoção de animais que organiza campeonatos de video game beneficentes: a inscrição é paga com dinheiro ou ração, e tudo vai para o abrigo.

Front-end feito com Vite+ (Vanilla JS) e API em Express.

## Como rodar

Precisa ter Node.js 22+ e o Vite+ instalados.

```bash
git clone https://github.com/jhonnylopes49/patas-em-jogo.git
cd patas-em-jogo
vp install
```

Copiar o `.env.example` para `.env`:

```bash
cp .env.example .env
```

(no Windows: `copy .env.example .env`)

Depois abrir dois terminais na pasta do projeto:

- Terminal 1: `vp run api`
- Terminal 2: `vp dev`

E abrir http://localhost:5173. A página mostra o status da API (`Status da API: ok`) com a data e a hora.

## Pastas

- `server/index.js` - API em Express, com a rota `GET /api/health`
- `src/main.js` - página inicial
- `vite.config.ts` - proxy do `/api` para a porta 3001
