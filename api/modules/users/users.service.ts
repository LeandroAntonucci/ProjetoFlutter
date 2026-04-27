import { listUsers } from "./users.repository";
import type { UserDTO } from "./users.dto";

export async function getAllUsers(): Promise<UserDTO[]> {
  const users = await listUsers();

  return users.map((u) => ({
    id: u.id,
    email: u.email,
    name: u.name,
    role: u.role,
  }));
}