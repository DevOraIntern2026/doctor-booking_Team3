import Joi from "joi";
import { objectIdSchema } from "./commonValidator.js";

export const doctorsFilterSchema = Joi.object({
  speciality_id: objectIdSchema,
  governorate: Joi.string().max(50),
  area: Joi.string().max(50),
  today: Joi.string().valid("true", "false"),
});

export const getDoctorByIdSchema = Joi.object({
  id: objectIdSchema.required(),
});

export const getDoctorAvailabilitySchema = Joi.object({
  id: objectIdSchema.required(),
});
