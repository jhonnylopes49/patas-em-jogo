import express from "express";

const app = express();
const PORT = process.env.PORT || 3001;

// rota pra testar se a api ta no ar
app.get("/api/health", (req, res) => {
  res.json({ status: "ok", timestamp: new Date() });
});

app.listen(PORT, () => {
  console.log("API rodando na porta " + PORT);
});
