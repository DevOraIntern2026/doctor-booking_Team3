import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/reset_password/view_model/reset_password_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/reset_password/view_model/reset_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordStates>{
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordViewModel(this._resetPasswordUseCase):super(ResetPasswordStates());
  void doIntent(ResetPasswordEvents event){
    switch(event){
      
      case ResetPasswordUserEvent():
        _resetPassword(event.email, event.newPassword);
      case TogglePasswordVisibilityEvent():
        _togglePasswordVisibility();
      case ToggleConfirmPasswordVisibilityEvent():
        _toggleConfirmPasswordVisibility();
    }
  }
  Future<void> _resetPassword(String email,String newPassword)async{
    emit(state.copyWith(
      resetPasswordState: BaseState<ResetPasswordResponseEntity>(
        isLoading: true
      )
    ));
    final res=await _resetPasswordUseCase.call(ResetPasswordRequestEntity(email: email,newPassword: newPassword));
    switch(res){
      
      case SuccessResponse<ResetPasswordResponseEntity>():
        emit(state.copyWith(
          resetPasswordState: BaseState<ResetPasswordResponseEntity>(
            isLoading: false,
            data: res.data
          )
        ));
      case ErrorResponse<ResetPasswordResponseEntity>():
        emit(state.copyWith(
          resetPasswordState: BaseState<ResetPasswordResponseEntity>(
            isLoading: false,
            errorMessage: res.error.toString()
          )
        ));
    }
  }
  void _togglePasswordVisibility(){
    emit(state.copyWith(
      isPasswordHidden: !state.isPasswordHidden!
    ));
  }
  void _toggleConfirmPasswordVisibility(){
    emit(state.copyWith(
      isConfirmPasswordHidden: !state.isConfirmPasswordHidden!
    ));
  }
}