import type { Request, Response } from "express";
import { getAllUsers } from "./users.service";

export async function handleListUsers(req: Request, res: Response) {
  try {
    const users = await getAllUsers();
    return res.json(users);
  } catch (error) {
    return res.status(500).json({
      message: "Erro ao listar usuários",
    });
  }
}