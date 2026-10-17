import { Router } from "express";
import { getSchedule, getAvailability, updateSchedule } from "../controllers/scheduleController.js";
import { protect, authorize } from "../middleware/authMiddleware.js";

const router = Router();

router.get("/:id/schedule", getSchedule);
router.get("/:id/availability", getAvailability);
router.put("/:id/schedule", protect, authorize("admin"), updateSchedule);

export default router;