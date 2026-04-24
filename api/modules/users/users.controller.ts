import type { Request, Response } from "express";
import { getAllUsers, syncFirebaseUser } from "./users.service";

export async function handleListUsers(req: Request, res: Response) {
  const users = await getAllUsers();
  return res.json(users);
}

export async function handleSyncFirebaseUser(req: Request, res: Response) {
  const user = await syncFirebaseUser(req.body);
  return res.status(200).json(user);
}