import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/user_entity.dart';
import 'package:doctor_booking_app/features/auth/register/domain/use_cases/register_use_case.dart';
import 'package:doctor_booking_app/features/auth/register/presentation/view_model/register_events.dart';
import 'package:doctor_booking_app/features/auth/register/presentation/view_model/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterViewModel extends Cubit<RegisterStates>{
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase):super(RegisterStates());
  void doIntent(RegisterEvents event){
    switch(event){
      
      case RegisterUserEvent():
        _registerUser(event.name, event.email, event.password, event.confirmPassword);
      case TogglePasswordVisibilityEvent():
        _togglePasswordVisibility();
      case ToggleConfirmPasswordVisibilityEvent():
        _toggleConfirmPasswordVisibility();
      case ToggleAgreementCheckboxEvent():
       _toggleAgreementCheckbox();
    }
  }
  Future<void> _registerUser(String name,String email,String password,String confirmPassword)async{
    if (state.isAgreementChecked != true) return;
    emit(state.copyWith(
      registerState: BaseState<UserEntity>(isLoading: true)
    ));
    final res=await _registerUseCase.call(RegisterRequestEntity(userName: name,email: email,password: password,confirmPassword: confirmPassword));
    switch(res){
      
      case SuccessResponse<UserEntity>():
        emit(state.copyWith(
          registerState: BaseState<UserEntity>(
            isLoading: false,
            data: res.data
          )
        ));
      case ErrorResponse<UserEntity>():
        emit(state.copyWith(
          registerState: BaseState<UserEntity>(
            isLoading: false,
            errorMessage: res.error.message
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
  void _toggleAgreementCheckbox() {                 
    emit(state.copyWith(
      isAgreementChecked: !state.isAgreementChecked! 
    ));
  }
}