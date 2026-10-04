import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/user_entity.dart';
import 'package:doctor_booking_app/features/auth/login/domain/repos/login_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginUseCase {
  final LoginRepoContract _repoContract;
  LoginUseCase(this._repoContract);
  Future<BaseResponse<UserEntity>> call(LoginRequestEntity request)async{
    return _repoContract.login(request);
  }
}