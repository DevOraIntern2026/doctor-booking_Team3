import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_response_entity.dart';

abstract class ForgetPasswordRepoContract {
  Future<BaseResponse<ForgetPasswordResponseEntity>> forgetPassword(ForgetPasswordRequestEntity request);
  Future<BaseResponse<ResetPasswordResponseEntity>> resetPassword(ResetPasswordRequestEntity request);
  Future<BaseResponse<VerifyResetCodeResponseEntity>> verifyResetCode(VerifyResetCodeRequestEntity request);
}