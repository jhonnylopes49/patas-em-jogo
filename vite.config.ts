import { defineConfig } from "vite-plus";

export default defineConfig({
  server: {
    proxy: {
      // manda o /api pro express
      "/api": "http://localhost:3001",
    },
  },
});
