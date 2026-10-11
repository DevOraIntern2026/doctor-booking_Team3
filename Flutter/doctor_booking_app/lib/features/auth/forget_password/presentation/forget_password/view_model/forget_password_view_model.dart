import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_request_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:doctor_booking_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordStates>{
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase):super(ForgetPasswordStates());
  void doIntent(ForgetPasswordEvents event){
    switch(event){
      
      case ForgetPasswordUserEvent():
        _forgetPassword(event.email);
    }
  }
  Future<void> _forgetPassword(String email)async{
    emit(state.copyWith(
      forgetPasswordState: BaseState<ForgetPasswordResponseEntity>(
        isLoading: true
      )
    ));
    final res=await _forgetPasswordUseCase.call(ForgetPasswordRequestEntity(email: email));
    switch(res){
      
      case SuccessResponse<ForgetPasswordResponseEntity>():
        emit(state.copyWith(
          forgetPasswordState: BaseState<ForgetPasswordResponseEntity>(
            isLoading: false,
            data: res.data
          )
        ));
      case ErrorResponse<ForgetPasswordResponseEntity>():
        emit(state.copyWith(
          forgetPasswordState: BaseState<ForgetPasswordResponseEntity>(
            isLoading: false,
            errorMessage: res.error.message
          )
        ));
    }
  }
}