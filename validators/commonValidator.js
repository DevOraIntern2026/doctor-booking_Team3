import Joi from "joi";

export const objectIdSchema = Joi.string()
  .pattern(/^[0-9a-fA-F]{24}$/)
  .message("Invalid ObjectId format");

export const optionalObjectIdSchema = objectIdSchema.optional();

export const doctorsFilterSchema = Joi.object({
  speciality_id: objectIdSchema,
  governorate: Joi.string().max(50),
  area: Joi.string().max(50),
  today: Joi.string().valid("true", "false"),
});
