import { prisma } from "../../src/shared/prisma";

export async function listUsers() {
  return prisma.user.findMany({
    select: {
      id: true,
      email: true,
      name: true,
      role: true,
    },
    orderBy: { createdAt: "desc" },
  });
}