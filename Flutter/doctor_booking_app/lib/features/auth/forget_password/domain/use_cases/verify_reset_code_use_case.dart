import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/repos/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class VerifyResetCodeUseCase {
  final ForgetPasswordRepoContract _repoContract;
  VerifyResetCodeUseCase(this._repoContract);
  Future<BaseResponse<VerifyResetCodeResponseEntity>> call(VerifyResetCodeRequestEntity request)async{
    return _repoContract.verifyResetCode(request);
  }
}