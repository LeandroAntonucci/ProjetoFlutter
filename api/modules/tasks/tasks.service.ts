import { TaskStatus } from "../../generated/prisma/client";
import type { CreateTaskDTO, TaskDTO, UpdateTaskDTO } from "./tasks.dto";
import {
  createTask,
  deleteTask,
  findTaskById,
  listTasks,
  updateTask,
} from "./tasks.repository";

type TaskRecord = Awaited<ReturnType<typeof listTasks>>[number];

function toTaskDTO(task: TaskRecord): TaskDTO {
  return {
    id: task.id,
    title: task.title,
    category: task.category,
    status: task.status,
    frequencyType: task.frequencyType,
    intervalValue: task.intervalValue,
    intervalUnit: task.intervalUnit,
    completionDate: task.completionDate ? task.completionDate.toISOString() : null,
    authorId: task.authorId,
    author: task.author
      ? {
          id: task.author.id,
          email: task.author.email,
          name: task.author.name,
        }
      : undefined,
    createdAt: task.createdAt.toISOString(),
    updatedAt: task.updatedAt.toISOString(),
  };
}

function validateCustomFrequency(
  frequencyType: CreateTaskDTO["frequencyType"] | UpdateTaskDTO["frequencyType"],
  intervalValue?: number | null,
  intervalUnit?: CreateTaskDTO["intervalUnit"] | UpdateTaskDTO["intervalUnit"],
) {
  if (frequencyType === "CUSTOM") {
    if (intervalValue == null || intervalUnit == null) {
      throw new Error(
        "Quando frequencyType for CUSTOM, intervalValue e intervalUnit são obrigatórios.",
      );
    }
  }
}

export async function getAllTasks(): Promise<TaskDTO[]> {
  const tasks = await listTasks();
  return tasks.map(toTaskDTO);
}

export async function getTaskById(id: number): Promise<TaskDTO> {
  const task = await findTaskById(id);

  if (!task) {
    throw new Error("Task não encontrada");
  }

  return toTaskDTO(task);
}

export async function createNewTask(data: CreateTaskDTO): Promise<TaskDTO> {
  validateCustomFrequency(data.frequencyType, data.intervalValue, data.intervalUnit);

  const task = await createTask(data);
  return toTaskDTO(task);
}

export async function editTask(id: number, data: UpdateTaskDTO): Promise<TaskDTO> {
  if (data.frequencyType === "CUSTOM") {
    validateCustomFrequency(data.frequencyType, data.intervalValue, data.intervalUnit);
  }

  const task = await updateTask(id, data);
  return toTaskDTO(task);
}

export async function removeTask(id: number): Promise<TaskDTO> {
  const task = await deleteTask(id);
  return toTaskDTO(task);
}