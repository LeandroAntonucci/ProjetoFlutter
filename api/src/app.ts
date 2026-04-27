import express from "express";
import usersRouter from "../modules/users/users.routes";
import tasksRouter from "../modules/tasks/tasks.routes";

import cors from "cors";

const app = express();


app.use(cors()); 
app.use(express.json());
app.use("/users", usersRouter);
app.use("/tasks", tasksRouter);

export default app;
