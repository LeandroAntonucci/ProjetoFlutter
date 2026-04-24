import { prisma } from "../../src/shared/prisma";

export async function upsertUser(data: {
  firebaseUid: string;
  email: string;
  name?: string | null;
  photoUrl?: string | null;
}) {
  return prisma.user.upsert({
    where: { firebaseUid: data.firebaseUid },
    update: {
      email: data.email,
      name: data.name,
      photoUrl: data.photoUrl,
    },
    create: {
      firebaseUid: data.firebaseUid,
      email: data.email,
      name: data.name,
      photoUrl: data.photoUrl,
    },
  });
}

export async function listUsers() {
  return prisma.user.findMany({
    orderBy: { createdAt: "desc" },
  });
}