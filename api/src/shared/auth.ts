import { randomUUID } from "crypto";
import * as jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET ?? "dev-secret-change-me";
const ACCESS_TOKEN_EXPIRES_IN = "1d";
const EXPIRES_IN_SECONDS = 60 * 60 * 24;

export type AuthResponseDTO = {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  userId: string;
  localUserId: number;
  name: string;
  email: string;
};

type AuthUser = {
  id: number;
  username: string;
  name: string | null;
  email: string | null;
};

export function buildAuthResponse(user: AuthUser): AuthResponseDTO {
  const accessToken = jwt.sign(
    {
      username: user.username,
      name: user.name ?? user.username,
      email: user.email ?? "",
    },
    JWT_SECRET,
    {
      subject: String(user.id),
      expiresIn: ACCESS_TOKEN_EXPIRES_IN,
    },
  );

  return {
    accessToken,
    refreshToken: randomUUID(),
    expiresIn: EXPIRES_IN_SECONDS,
    userId: String(user.id),
    localUserId: user.id,
    name: user.name ?? user.username,
    email: user.email ?? "",
  };
}
