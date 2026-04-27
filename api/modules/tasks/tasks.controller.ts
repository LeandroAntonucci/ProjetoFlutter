import type { Request, Response } from "express";
import {
  createNewTask,
  editTask,
  getAllTasks,
  getTaskById,
  removeTask,
} from "./tasks.service";

export async function handleListTasks(req: Request, res: Response) {
  try {
    const tasks = await getAllTasks();
    return res.json(tasks);
  } catch (error) {
    return res.status(500).json({ message: "Erro ao listar tasks" });
  }
}

export async function handleGetTaskById(req: Request, res: Response) {
  try {
    const id = Number(req.params.id);

    if (Number.isNaN(id)) {
      return res.status(400).json({ message: "ID inválido" });
    }

    const task = await getTaskById(id);
    return res.json(task);
  } catch (error) {
    if (error instanceof Error && error.message === "Task não encontrada") {
      return res.status(404).json({ message: error.message });
    }

    return res.status(500).json({ message: "Erro ao buscar task" });
  }
}

export async function handleCreateTask(req: Request, res: Response) {
  try {
    const task = await createNewTask(req.body);
    return res.status(201).json(task);
  } catch (error) {
    if (error instanceof Error) {
      return res.status(400).json({ message: error.message });
    }

    return res.status(500).json({ message: "Erro ao criar task" });
  }
}

export async function handleUpdateTask(req: Request, res: Response) {
  try {
    const id = Number(req.params.id);

    if (Number.isNaN(id)) {
      return res.status(400).json({ message: "ID inválido" });
    }

    const task = await editTask(id, req.body);
    return res.json(task);
  } catch (error) {
    if (error instanceof Error && error.message === "Task não encontrada") {
      return res.status(404).json({ message: error.message });
    }

    if (error instanceof Error) {
      return res.status(400).json({ message: error.message });
    }

    return res.status(500).json({ message: "Erro ao atualizar task" });
  }
}

export async function handleDeleteTask(req: Request, res: Response) {
  try {
    const id = Number(req.params.id);

    if (Number.isNaN(id)) {
      return res.status(400).json({ message: "ID inválido" });
    }

    const task = await removeTask(id);
    return res.json(task);
  } catch (error) {
    if (error instanceof Error && error.message === "Task não encontrada") {
      return res.status(404).json({ message: error.message });
    }

    return res.status(500).json({ message: "Erro ao remover task" });
  }
}