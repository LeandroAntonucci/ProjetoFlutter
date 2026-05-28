import { Router } from "express";
import {
  handleCreateUser,
  handleGetUserById,
  handleListUsers,
  handleLoginUser,
  handleValidateUser,
} from "./users.controller";

const router = Router();

router.post("/register", handleCreateUser);
router.post("/login", handleLoginUser);
router.post("/validate", handleValidateUser);

router.get("/", handleListUsers);
router.get("/:id", handleGetUserById);

export default router;