import "dotenv/config";
import app from "./app.js";
import cors from 'cors';

const port = Number(process.env.PORT) || 3000;

app.use(cors());

app.listen(port, () => {
  console.log(`API rodando na porta ${port}`);
});