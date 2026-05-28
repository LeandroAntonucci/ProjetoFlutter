import type { UserRole } from "../../generated/prisma/client";

export type UserDTO = {
  id: number;
  username: string;
  email: string | null;
  name: string | null;
  role: UserRole;
  age: number | null;
  height: number | null;
  weight: number | null;
  caregiverId: number | null;
  createdAt: string;
  updatedAt: string;
};

export type CreateUserDTO = {
  username: string;
  password: string;
  email?: string | null;
  name?: string | null;
  role?: UserRole;
  age?: number | null;
  height?: number | null;
  weight?: number | null;
  caregiverId?: number | null;
};

export type LoginUserDTO = {
  username: string;
  password: string;
};

export type ValidateUserDTO = {
  username: string;
};

export type ValidateUserResponseDTO = {
  exists: boolean;
  user: UserDTO | null;
};
