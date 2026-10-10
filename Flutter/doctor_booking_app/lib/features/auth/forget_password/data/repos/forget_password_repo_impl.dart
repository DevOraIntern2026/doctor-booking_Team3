import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/repos/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract{
  @override
  Future<BaseResponse<ForgetPasswordResponseEntity>> forgetPassword(ForgetPasswordRequestEntity request) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<ResetPasswordResponseEntity>> resetPassword(ResetPasswordRequestEntity request) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponseEntity>> verifyResetCode(VerifyResetCodeRequestEntity request) {
    // TODO: implement verifyResetCode
    throw UnimplementedError();
  }

}