import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_response_entity.dart';

class VerifyResetCodeStates {
  BaseState<VerifyResetCodeResponseEntity>? verifyOtpState;
  VerifyResetCodeStates({this.verifyOtpState});
  VerifyResetCodeStates copyWith({BaseState<VerifyResetCodeResponseEntity>? verifyOtpState}){
    return VerifyResetCodeStates(
      verifyOtpState: verifyOtpState ?? this.verifyOtpState
    );
  }
}