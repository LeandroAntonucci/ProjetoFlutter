import express from "express";
import usersRouter from "../modules/users/users.routes";
// import authRouter from "../modules/auth/auth.routes";

const app = express();

app.use(express.json());
app.use("/users", usersRouter);
// app.use("/auth", authRouter);

export default app;