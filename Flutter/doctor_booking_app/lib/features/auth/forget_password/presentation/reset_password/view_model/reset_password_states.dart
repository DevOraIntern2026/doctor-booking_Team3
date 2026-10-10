import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';

class ResetPasswordStates {
  BaseState<ResetPasswordResponseEntity>? resetPasswordState;
  bool? isPasswordHidden;
  bool? isConfirmPasswordHidden;
  ResetPasswordStates({this.resetPasswordState,this.isPasswordHidden=true,this.isConfirmPasswordHidden=true});
  ResetPasswordStates copyWith({
    BaseState<ResetPasswordResponseEntity>? resetPasswordState,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden
  }){
    return ResetPasswordStates(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden
    );
  }
}