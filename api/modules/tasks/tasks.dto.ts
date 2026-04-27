import type {
    Frequency,
    IntervalUnit,
    TaskCategory,
    TaskStatus,
  } from "../../generated/prisma/client";
  
  export type TaskAuthorDTO = {
    id: number;
    email: string;
    name: string | null;
  };
  
  export type TaskDTO = {
    id: number;
    title: string;
    category: TaskCategory;
    status: TaskStatus;
    frequencyType: Frequency;
    intervalValue: number | null;
    intervalUnit: IntervalUnit | null;
    completionDate: string | null;
    authorId: number;
    author?: TaskAuthorDTO;
    createdAt: string;
    updatedAt: string;
  };
  
  export type CreateTaskDTO = {
    title: string;
    category: TaskCategory;
    frequencyType: Frequency;
    status?: TaskStatus;
    intervalValue?: number | null;
    intervalUnit?: IntervalUnit | null;
    completionDate?: string | null;
    authorId: number;
  };
  
  export type UpdateTaskDTO = {
    title?: string;
    category?: TaskCategory;
    status?: TaskStatus;
    frequencyType?: Frequency;
    intervalValue?: number | null;
    intervalUnit?: IntervalUnit | null;
    completionDate?: string | null;
  };