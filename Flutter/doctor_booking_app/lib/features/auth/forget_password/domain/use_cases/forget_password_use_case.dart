import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/repos/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepoContract _repoContract;
  ForgetPasswordUseCase(this._repoContract);
  Future<BaseResponse<ForgetPasswordResponseEntity>> call(ForgetPasswordRequestEntity request)async{
    return _repoContract.forgetPassword(request);
  }
}