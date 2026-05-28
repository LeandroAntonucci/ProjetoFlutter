import type { Request, Response } from "express";
import { ApiError } from "../../src/shared/app_error";
import {
  createNewUser,
  getAllUsers,
  getUserById,
  loginUser,
  validateUser,
} from "./users.service";

function handleError(res: Response, error: unknown, fallback: string) {
  if (error instanceof ApiError) {
    return res.status(error.statusCode).json({ message: error.message });
  }

  return res.status(500).json({ message: fallback });
}

export async function handleListUsers(req: Request, res: Response) {
  try {
    const users = await getAllUsers();
    return res.json(users);
  } catch (error) {
    return handleError(res, error, "Erro ao listar usuários");
  }
}

export async function handleGetUserById(req: Request, res: Response) {
  try {
    const id = Number(req.params.id);

    if (Number.isNaN(id)) {
      return res.status(400).json({ message: "ID inválido" });
    }

    const user = await getUserById(id);
    return res.json(user);
  } catch (error) {
    return handleError(res, error, "Erro ao buscar usuário");
  }
}

export async function handleCreateUser(req: Request, res: Response) {
  try {
    const user = await createNewUser(req.body);
    return res.status(201).json(user);
  } catch (error) {
    return handleError(res, error, "Erro ao criar usuário");
  }
}

export async function handleValidateUser(req: Request, res: Response) {
  try {
    const result = await validateUser(req.body);
    return res.json(result);
  } catch (error) {
    return handleError(res, error, "Erro ao validar usuário");
  }
}

export async function handleLoginUser(req: Request, res: Response) {
  try {
    const auth = await loginUser(req.body);
    return res.json(auth);
  } catch (error) {
    return handleError(res, error, "Erro ao fazer login");
  }
}