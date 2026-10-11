import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/verify_reset_code_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/verify_otp/view_model/verify_reset_code_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/verify_otp/view_model/verify_reset_code_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class VerifyResetCodeViewModel extends Cubit<VerifyResetCodeStates>{
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  VerifyResetCodeViewModel(this._verifyResetCodeUseCase):super(VerifyResetCodeStates());
  void doIntent(VerifyResetCodeEvents event){
    switch(event){
      
      case VerifyResetCodeUserEvent():
       _verifyResetCode(event.resetCode);
    }
  }
  Future<void> _verifyResetCode(String resetCode)async{
    emit(state.copyWith(
      verifyOtpState: BaseState<VerifyResetCodeResponseEntity>(
        isLoading: true
      )
    ));
    final res=await _verifyResetCodeUseCase.call(VerifyResetCodeRequestEntity(resetCode: resetCode));
    switch(res){
      
      case SuccessResponse<VerifyResetCodeResponseEntity>():
        emit(state.copyWith(
          verifyOtpState: BaseState<VerifyResetCodeResponseEntity>(
            isLoading: false,
            data: res.data
          )
        ));
      case ErrorResponse<VerifyResetCodeResponseEntity>():
        emit(state.copyWith(
          verifyOtpState: BaseState<VerifyResetCodeResponseEntity>(
            isLoading: false,
            errorMessage: res.error.message
          )
        ));
    }
  }
}