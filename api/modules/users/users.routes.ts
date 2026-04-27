import { Router } from "express";
import { handleListUsers } from "./users.controller";

const router = Router();

router.get("/", handleListUsers);

export default router;