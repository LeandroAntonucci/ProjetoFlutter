import type { UserRole } from "../../generated/prisma/client";
import { ApiError } from "../../src/shared/app_error";
import { buildAuthResponse, type AuthResponseDTO } from "../../src/shared/auth";
import { comparePassword, hashPassword } from "../../src/shared/security";
import type {
  CreateUserDTO,
  LoginUserDTO,
  UserDTO,
  ValidateUserDTO,
  ValidateUserResponseDTO,
} from "./users.dto";
import {
  createUser,
  findUserByEmail,
  findUserById,
  findUserByLoginIdentifier,
  findUserByUsername,
  listUsers,
  resetLoginSecurity,
  updateLoginSecurity,
} from "./users.repository";

type UserPublicRecord = Awaited<ReturnType<typeof listUsers>>[number];
type UserAuthRecord = NonNullable<
  Awaited<ReturnType<typeof findUserByLoginIdentifier>>
>;

function normalizeUsername(value: string): string {
  return value.trim().toLowerCase();
}

function normalizeEmail(value?: string | null): string | null {
  const email = value?.trim().toLowerCase() ?? "";
  return email.length > 0 ? email : null;
}

function toUserDTO(user: UserPublicRecord): UserDTO {
  return {
    id: user.id,
    username: user.username,
    email: user.email,
    name: user.name,
    role: user.role,
    age: user.age,
    height: user.height,
    weight: user.weight,
    caregiverId: user.caregiverId,
    createdAt: user.createdAt.toISOString(),
    updatedAt: user.updatedAt.toISOString(),
  };
}

function toUserDTOFromAuth(user: UserAuthRecord): UserDTO {
  return {
    id: user.id,
    username: user.username,
    email: user.email,
    name: user.name,
    role: user.role,
    age: user.age,
    height: user.height,
    weight: user.weight,
    caregiverId: user.caregiverId,
    createdAt: user.createdAt.toISOString(),
    updatedAt: user.updatedAt.toISOString(),
  };
}

function ensurePassword(password: string | undefined): string {
  const value = password?.trim() ?? "";

  if (!value) {
    throw new ApiError(400, "Informe uma senha.");
  }

  if (value.length < 6) {
    throw new ApiError(400, "A senha deve ter ao menos 6 caracteres.");
  }

  return value;
}

function ensureUsername(username: string | undefined): string {
  const value = username?.trim() ?? "";

  if (!value) {
    throw new ApiError(400, "Informe um nome de usuário.");
  }

  return normalizeUsername(value);
}

export async function getAllUsers(): Promise<UserDTO[]> {
  const users = await listUsers();
  return users.map(toUserDTO);
}

export async function getUserById(id: number): Promise<UserDTO> {
  const user = await findUserById(id);

  if (!user) {
    throw new ApiError(404, "Usuário não encontrado.");
  }

  return toUserDTO(user);
}

export async function validateUser(
  data: ValidateUserDTO,
): Promise<ValidateUserResponseDTO> {
  const username = ensureUsername(data.username);
  const user = await findUserByLoginIdentifier(username);

  return {
    exists: Boolean(user),
    user: user ? toUserDTOFromAuth(user) : null,
  };
}

export async function createNewUser(
  data: CreateUserDTO,
): Promise<UserDTO> {
  const username = ensureUsername(data.username);
  const password = ensurePassword(data.password);
  const email = normalizeEmail(data.email);
  const name = data.name?.trim() || username;
  const role: UserRole = data.role ?? "USER";

  const existingByUsername = await findUserByUsername(username);
  if (existingByUsername) {
    throw new ApiError(409, "Nome de usuário já cadastrado.");
  }

  if (email) {
    const existingByEmail = await findUserByEmail(email);
    if (existingByEmail) {
      throw new ApiError(409, "E-mail já cadastrado.");
    }
  }

  const passwordHash = await hashPassword(password);

  const user = await createUser({
    username,
    email,
    name,
    role,
    age: data.age ?? null,
    height: data.height ?? null,
    weight: data.weight ?? null,
    caregiverId: data.caregiverId ?? null,
    passwordHash,
  });

  return toUserDTO(user);
}

export async function loginUser(
  data: LoginUserDTO,
): Promise<AuthResponseDTO> {
  const username = ensureUsername(data.username);
  const password = ensurePassword(data.password);

  const user = await findUserByLoginIdentifier(username);

  if (!user) {
    throw new ApiError(401, "Usuário ou senha inválidos.");
  }

  if (user.blockedUntil && user.blockedUntil > new Date()) {
    throw new ApiError(423, "Usuário temporariamente bloqueado.");
  }

  const passwordMatches = await comparePassword(password, user.passwordHash);

  if (!passwordMatches) {
    const attempts = user.attemptsLogin + 1;
    const shouldBlock = attempts >= 5;
    const blockedUntil = shouldBlock
      ? new Date(Date.now() + 15 * 60 * 1000)
      : null;

    await updateLoginSecurity(user.id, {
      attemptsLogin: attempts,
      blockedUntil,
    });

    throw new ApiError(401, "Usuário ou senha inválidos.");
  }

  await resetLoginSecurity(user.id);

  const freshUser = await findUserById(user.id);

  return buildAuthResponse({
    id: user.id,
    username: user.username,
    name: freshUser?.name ?? user.name,
    email: freshUser?.email ?? user.email,
  });
}