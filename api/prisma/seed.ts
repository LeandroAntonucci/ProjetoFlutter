import { prisma } from "../src/shared/prisma";
import { UserRole, TaskCategory, TaskStatus, Frequency } from "../generated/prisma/client";


async function main() {
  console.log("🌱 Iniciando seed...");

  await prisma.user.upsert({
    where: { email: "admin@teste.com" },
    update: {},
    create: {
      email: "admin@teste.com",
      name: "Admin",
      role: UserRole.ADMIN,
      age: 30,
      height: 180,
      weight: 80,
    },
  });

  await prisma.user.upsert({
    where: { email: "user@teste.com" },
    update: {},
    create: {
      email: "user@teste.com",
      name: "Usuário",
      role: UserRole.USER,
      age: 25,
      height: 170,
      weight: 70,
    },
  });

  const admin = await prisma.user.findUnique({
    where: { email: "admin@teste.com" },
  });

  const user = await prisma.user.findUnique({
    where: { email: "user@teste.com" },
  });

  if (!admin || !user) {
    throw new Error("Usuários do seed não foram encontrados.");
  }

  await prisma.task.createMany({
    data: [
      {
        title: "Beber água",
        category: TaskCategory.WATER,
        status: TaskStatus.PENDING,
        frequencyType: Frequency.DAILY,
        authorId: user.id,
      },
      {
        title: "Tomar medicação da manhã",
        category: TaskCategory.MEDICATION,
        status: TaskStatus.PENDING,
        frequencyType: Frequency.DAILY,
        authorId: user.id,
      },
      {
        title: "Revisar cadastro de usuários",
        category: TaskCategory.OTHER,
        status: TaskStatus.PENDING,
        frequencyType: Frequency.WEEKLY,
        authorId: admin.id,
      },
    ],
  });

  console.log("✅ Seed finalizado");
}

main()
  .catch((error) => {
    console.error("❌ Erro no seed:", error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });