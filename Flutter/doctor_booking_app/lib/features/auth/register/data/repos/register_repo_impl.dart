import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/user_entity.dart';
import 'package:doctor_booking_app/features/auth/register/domain/repos/register_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RegisterRepoContract)
class RegisterRepoImpl implements RegisterRepoContract{
  @override
  Future<BaseResponse<UserEntity>> register(RegisterRequestEntity request) {
    // TODO: implement register
    throw UnimplementedError();
  }

}