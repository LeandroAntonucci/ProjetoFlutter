import { prisma } from "../../src/shared/prisma";
import type { CreateTaskDTO, UpdateTaskDTO } from "./tasks.dto";
import { TaskStatus } from "../../generated/prisma/client";

const taskSelect = {
  id: true,
  title: true,
  category: true,
  status: true,
  frequencyType: true,
  intervalValue: true,
  intervalUnit: true,
  completionDate: true,
  authorId: true,
  author: {
    select: {
      id: true,
      email: true,
      name: true,
    },
  },
  createdAt: true,
  updatedAt: true,
} as const;

export async function listTasks() {
  return prisma.task.findMany({
    orderBy: { createdAt: "desc" },
    select: taskSelect,
  });
}

export async function findTaskById(id: number) {
  return prisma.task.findUnique({
    where: { id },
    select: taskSelect,
  });
}

export async function createTask(data: CreateTaskDTO) {
  return prisma.task.create({
    data: {
      title: data.title,
      category: data.category,
      status: data.status ?? TaskStatus.PENDING,
      frequencyType: data.frequencyType,
      intervalValue: data.intervalValue ?? null,
      intervalUnit: data.intervalUnit ?? null,
      completionDate: data.completionDate ? new Date(data.completionDate) : null,
      authorId: data.authorId,
    },
    select: taskSelect,
  });
}

export async function updateTask(id: number, data: UpdateTaskDTO) {
  return prisma.task.update({
    where: { id },
    data: {
      ...(data.title !== undefined ? { title: data.title } : {}),
      ...(data.category !== undefined ? { category: data.category } : {}),
      ...(data.status !== undefined ? { status: data.status } : {}),
      ...(data.frequencyType !== undefined ? { frequencyType: data.frequencyType } : {}),
      ...(data.intervalValue !== undefined ? { intervalValue: data.intervalValue } : {}),
      ...(data.intervalUnit !== undefined ? { intervalUnit: data.intervalUnit } : {}),
      ...(data.completionDate !== undefined
        ? { completionDate: data.completionDate ? new Date(data.completionDate) : null }
        : {}),
    },
    select: taskSelect,
  });
}

export async function deleteTask(id: number) {
  return prisma.task.delete({
    where: { id },
    select: taskSelect,
  });
}