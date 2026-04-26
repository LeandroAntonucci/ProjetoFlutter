-- CreateTable
CREATE TABLE "users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "role" TEXT NOT NULL DEFAULT 'USER',
    "age" INTEGER,
    "height" INTEGER,
    "weight" INTEGER,
    "caregiverId" INTEGER,
    "attemptsLogin" INTEGER NOT NULL DEFAULT 0,
    "blockedUntil" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "users_caregiverId_fkey" FOREIGN KEY ("caregiverId") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "addresses" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "uf" TEXT,
    "number" INTEGER,
    "street" TEXT,
    "addressType" TEXT,
    "cep" TEXT,
    "complement" TEXT,
    "city" TEXT,
    "ownerId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "addresses_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "tasks" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "frequencyType" TEXT NOT NULL,
    "intervalValue" INTEGER,
    "intervalUnit" TEXT,
    "completionDate" DATETIME,
    "authorId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "tasks_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "password_resets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "tokenHash" TEXT NOT NULL,
    "expiresAt" DATETIME NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "ownerId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "password_resets_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_caregiverId_idx" ON "users"("caregiverId");

-- CreateIndex
CREATE UNIQUE INDEX "addresses_ownerId_key" ON "addresses"("ownerId");

-- CreateIndex
CREATE INDEX "tasks_authorId_idx" ON "tasks"("authorId");

-- CreateIndex
CREATE INDEX "tasks_authorId_status_idx" ON "tasks"("authorId", "status");

-- CreateIndex
CREATE INDEX "tasks_frequencyType_idx" ON "tasks"("frequencyType");

-- CreateIndex
CREATE INDEX "tasks_category_idx" ON "tasks"("category");

-- CreateIndex
CREATE INDEX "password_resets_ownerId_idx" ON "password_resets"("ownerId");

-- CreateIndex
CREATE INDEX "password_resets_ownerId_used_expiresAt_idx" ON "password_resets"("ownerId", "used", "expiresAt");
