import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/user_entity.dart';

abstract class RegisterRepoContract {
  Future<BaseResponse<UserEntity>> register(RegisterRequestEntity request);
}