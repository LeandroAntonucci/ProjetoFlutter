import { prisma } from "../src/shared/prisma";
import { hashPassword } from "../src/shared/security";

async function main() {
  const passwordHash = await hashPassword("123456");

  await prisma.user.upsert({
    where: { username: "teco" },
    update: {},
    create: {
      username: "teco",
      email: "teco@lavie.local",
      name: "Teco",
      role: "USER",
      passwordHash,
      age: 18,
      height: 170,
      weight: 70,
    },
  });

  await prisma.user.upsert({
    where: { username: "admin" },
    update: {},
    create: {
      username: "admin",
      email: "admin@lavie.local",
      name: "Administrador",
      role: "ADMIN",
      passwordHash,
    },
  });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    process.exit(1);
  });