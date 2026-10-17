import { Router } from "express";
import rateLimit from "express-rate-limit";
import { protect, authorize } from "../middleware/authMiddleware.js";
import {getacceptedDoctors,getDoctorById,getDoctoravailability
} from "../controllers/doctorController.js";
import{getSpecialitiesPatients} from"../controllers/specialtyController.js";
import { getMyAppointments } from "../controllers/appointmentController.js";

const router = Router();

//for patient:

router.get("/patientviewspec",getSpecialitiesPatients)
router.get("/filterdoctor",getacceptedDoctors)//all,governorate,today?,specialty,area
router.get("/viewdoctor/:id",getDoctorById)
router.get("/viewdoctordays/:id",getDoctoravailability)
router.get("/appointments", protect, authorize("patient"), getMyAppointments)


// router.get("/reviews/:id", getDoctorReviews);


export default router;