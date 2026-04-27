import { Router } from "express";
import {
  handleCreateTask,
  handleDeleteTask,
  handleGetTaskById,
  handleListTasks,
  handleUpdateTask,
} from "./tasks.controller";

const router = Router();

router.get("/", handleListTasks);
router.get("/:id", handleGetTaskById);
router.post("/", handleCreateTask);
router.patch("/:id", handleUpdateTask);
router.delete("/:id", handleDeleteTask);

export default router;