import "./style.css";

document.querySelector("#app").innerHTML = `
  <main>
    <h1>Patas em Jogo</h1>
    <p>Campeonatos de video game que ajudam animais a encontrar um lar.</p>
    <p id="status-api">Consultando a API...</p>
  </main>
`;

const statusEl = document.querySelector("#status-api");

async function carregarStatus() {
  try {
    const resposta = await fetch("/api/health");
    if (!resposta.ok) throw new Error(`HTTP ${resposta.status}`);
    const dados = await resposta.json();
    const dataHora = new Date(dados.timestamp).toLocaleString("pt-BR");
    statusEl.textContent = `Status da API: ${dados.status} (${dataHora})`;
  } catch (erro) {
    statusEl.textContent = `Status da API: indisponível (${erro.message})`;
  }
}

carregarStatus();
