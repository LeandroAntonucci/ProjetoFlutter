import { Router } from "express";
import { handleListUsers, handleSyncFirebaseUser } from "./users.controller";

const router = Router();

router.get("/", handleListUsers);
router.post("/sync", handleSyncFirebaseUser);

export default router;