import { prisma } from "../../src/shared/prisma";

export async function upsertUser(data: {
  id: number;
  email: string;
  name?: string | null;
}) {
  return prisma.user.upsert({
    where: { id: data.id },
    update: {
      email: data.email,
      name: data.name,
    },
    create: {
      email: data.email,
      name: data.name,
    },
  });
}

export async function listUsers() {
  return prisma.user.findMany({
    orderBy: { createdAt: "desc" },
  });
}