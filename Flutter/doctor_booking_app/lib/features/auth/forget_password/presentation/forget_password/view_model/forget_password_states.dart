import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';

class ForgetPasswordStates {
  BaseState<ForgetPasswordResponseEntity>? forgetPasswordState;
  ForgetPasswordStates({this.forgetPasswordState});
  ForgetPasswordStates copyWith({BaseState<ForgetPasswordResponseEntity>? forgetPasswordState}){
    return ForgetPasswordStates(
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState
    );
  }
}