import { upsertUser, listUsers } from "./users.repository";

export async function syncFirebaseUser(payload: {
  id: number;
  email: string;
  name?: string | null;
  photoUrl?: string | null;
}) {
  return upsertUser(payload);
}

export async function getAllUsers() {
  return listUsers();
}