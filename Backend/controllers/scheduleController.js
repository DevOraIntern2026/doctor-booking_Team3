import mongoose from "mongoose";
import Doctor from "../models/doctor.js";
import Appointment from "../models/appointment.js";
import { updateScheduleSchema, availabilityQuerySchema } from "../validators/scheduleValidator.js";
import { parseDate, isFuture, generateSlots, scheduleSummary } from "../utils/slots.js";

const dateOnly = (d) => new Date(d).toISOString().slice(0, 10);

export const getSchedule = async (req, res, next) => {
  try {
    const { id } = req.params;
    if (!mongoose.isValidObjectId(id)) return next({ message: "Invalid doctor id", statusCode: 400 });

    const doctor = await Doctor.findById(id)
      .select("is_active schedule slot_duration_minutes days_off")
      .lean();
    if (!doctor || !doctor.is_active) return next({ message: "Doctor not found", statusCode: 404 });

    res.status(200).json({
      success: true,
      data: {
        schedule: scheduleSummary(doctor),
        days_off: (doctor.days_off || []).map(dateOnly),
      },
    });
  } catch (err) {
    next(err);
  }
};

export const getAvailability = async (req, res, next) => {
  try {
    const { id } = req.params;
    if (!mongoose.isValidObjectId(id)) return next({ message: "Invalid doctor id", statusCode: 400 });

    const { error, value } = availabilityQuerySchema.validate(req.query, { stripUnknown: true });
    if (error) return next({ message: error.details[0].message, statusCode: 400 });

    const first = parseDate(value.date);
    if (!first) return next({ message: "Invalid date", statusCode: 400 });

    const doctor = await Doctor.findById(id)
      .select("is_active schedule slot_duration_minutes days_off")
      .lean();
    if (!doctor || !doctor.is_active) return next({ message: "Doctor not found", statusCode: 404 });

    const dates = Array.from({ length: value.days }, (_, i) => {
      const d = new Date(first);
      d.setUTCDate(d.getUTCDate() + i);
      return d;
    });

    const booked = await Appointment.find({
      doctor_id: doctor._id,
      status: "upcoming",
      appointment_date: { $gte: dates[0], $lte: dates[dates.length - 1] },
    })
      .select("appointment_date appointment_time")
      .lean();
    const bookedSet = new Set(booked.map((a) => `${dateOnly(a.appointment_date)}|${a.appointment_time}`));

    const data = dates.map((d) => {
      const dateStr = dateOnly(d);
      const slots = generateSlots(doctor, dateStr).map((time) => ({
        time,
        available: isFuture(dateStr, time) && !bookedSet.has(`${dateStr}|${time}`),
      }));
      return { date: dateStr, is_working_day: slots.length > 0, slots };
    });

    res.status(200).json({ success: true, data, schedule: scheduleSummary(doctor) });
  } catch (err) {
    next(err);
  }
};

export const updateSchedule = async (req, res, next) => {
  try {
    const { id } = req.params;
    if (!mongoose.isValidObjectId(id)) return next({ message: "Invalid doctor id", statusCode: 400 });

    const { error, value } = updateScheduleSchema.validate(req.body, { stripUnknown: true });
    if (error) return next({ message: error.details[0].message, statusCode: 400 });

    const doctor = await Doctor.findById(id);
    if (!doctor) return next({ message: "Doctor not found", statusCode: 404 });

    let daysOff;
    if (value.days_off) {
      daysOff = [];
      for (const d of value.days_off) {
        const parsed = parseDate(d);
        if (!parsed) return next({ message: `Invalid days_off date: ${d}`, statusCode: 400 });
        daysOff.push(parsed);
      }
    }

    doctor.schedule = {
      working_days: [...value.working_days].sort((a, b) => a - b),
      start_time: value.start_time,
      end_time: value.end_time,
      break_start: value.break_start ?? null,
      break_end: value.break_end ?? null,
    };
    if (value.slot_duration_minutes) doctor.slot_duration_minutes = value.slot_duration_minutes;
    if (daysOff) doctor.days_off = daysOff;

    await doctor.save();

    res.status(200).json({
      success: true,
      message: "Schedule updated successfully",
      data: { schedule: scheduleSummary(doctor) },
    });
  } catch (err) {
    next(err);
  }
};