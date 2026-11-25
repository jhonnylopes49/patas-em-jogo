import "./style.css";

document.querySelector("#app").innerHTML = `
  <h1>Patas em Jogo</h1>
  <p id="status">Carregando...</p>
`;

// busca o status da api
fetch("/api/health")
  .then((res) => res.json())
  .then((dados) => {
    const data = new Date(dados.timestamp).toLocaleString("pt-BR");
    document.querySelector("#status").textContent = "Status da API: " + dados.status + " (" + data + ")";
  })
  .catch(() => {
    document.querySelector("#status").textContent = "Status da API: erro";
  });
