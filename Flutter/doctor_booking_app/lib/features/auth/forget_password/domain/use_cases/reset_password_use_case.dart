import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/repos/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract _repoContract;
  ResetPasswordUseCase(this._repoContract);
  Future<BaseResponse<ResetPasswordResponseEntity>> call(ResetPasswordRequestEntity request)async{
    return _repoContract.resetPassword(request);
  }
}