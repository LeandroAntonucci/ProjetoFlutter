import { prisma } from "../../src/shared/prisma";
import type { Prisma, UserRole } from "../../generated/prisma/client";

const userPublicSelect = {
  id: true,
  username: true,
  email: true,
  name: true,
  role: true,
  age: true,
  height: true,
  weight: true,
  caregiverId: true,
  createdAt: true,
  updatedAt: true,
} as const;

const userAuthSelect = {
  ...userPublicSelect,
  passwordHash: true,
  attemptsLogin: true,
  blockedUntil: true,
} as const;

export type UserPublicRecord = Prisma.UserGetPayload<{
  select: typeof userPublicSelect;
}>;

export type UserAuthRecord = Prisma.UserGetPayload<{
  select: typeof userAuthSelect;
}>;

export async function listUsers(): Promise<UserPublicRecord[]> {
  return prisma.user.findMany({
    select: userPublicSelect,
    orderBy: { createdAt: "desc" },
  });
}

export async function findUserById(
  id: number,
): Promise<UserPublicRecord | null> {
  return prisma.user.findUnique({
    where: { id },
    select: userPublicSelect,
  });
}

export async function findUserByUsername(
  username: string,
): Promise<UserAuthRecord | null> {
  return prisma.user.findUnique({
    where: { username },
    select: userAuthSelect,
  });
}

export async function findUserByEmail(
  email: string,
): Promise<UserAuthRecord | null> {
  return prisma.user.findUnique({
    where: { email },
    select: userAuthSelect,
  });
}

export async function findUserByLoginIdentifier(
  identifier: string,
): Promise<UserAuthRecord | null> {
  const normalized = identifier.trim().toLowerCase();

  return prisma.user.findFirst({
    where: {
      OR: [{ username: normalized }, { email: normalized }],
    },
    select: userAuthSelect,
  });
}

export async function createUser(
  data: Prisma.UserUncheckedCreateInput,
): Promise<UserPublicRecord> {
  return prisma.user.create({
    data,
    select: userPublicSelect,
  });
}

export async function updateLoginSecurity(
  userId: number,
  data: { attemptsLogin: number; blockedUntil: Date | null },
): Promise<UserAuthRecord> {
  return prisma.user.update({
    where: { id: userId },
    data,
    select: userAuthSelect,
  });
}

export async function resetLoginSecurity(
  userId: number,
): Promise<UserAuthRecord> {
  return prisma.user.update({
    where: { id: userId },
    data: {
      attemptsLogin: 0,
      blockedUntil: null,
    },
    select: userAuthSelect,
  });
}
