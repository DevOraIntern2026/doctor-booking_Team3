import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/user_entity.dart';
import 'package:doctor_booking_app/features/auth/login/domain/repos/login_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract{
  @override
  Future<BaseResponse<UserEntity>> login(LoginRequestEntity request) {
    // TODO: implement login
    throw UnimplementedError();
  }

}