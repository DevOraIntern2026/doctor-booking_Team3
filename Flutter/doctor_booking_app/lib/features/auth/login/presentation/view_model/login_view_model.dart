import 'package:doctor_booking_app/config/base_response/base_response.dart';
import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/user_entity.dart';
import 'package:doctor_booking_app/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:doctor_booking_app/features/auth/login/presentation/view_model/login_events.dart';
import 'package:doctor_booking_app/features/auth/login/presentation/view_model/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginViewModel extends Cubit<LoginStates>{
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase):super(LoginStates());
  void doIntent(LoginEvents event){
    switch(event){
      
      case LoginUserEvent():
        _login(event.email, event.password);
      case TogglePasswordVisibilityEvent():
        _togglePasswordVisibility();
    }
  }
  Future<void> _login(String email,String password) async{
    emit(state.copyWith(
      loginUserState: BaseState<UserEntity>(
        isLoading: true
      )
    ));
    final res=await _loginUseCase.call(LoginRequestEntity(email: email,password: password));
    switch(res){
      
      case SuccessResponse<UserEntity>():
        emit(state.copyWith(
          loginUserState: BaseState<UserEntity>(
            isLoading: false,
            data: res.data
          )
        ));
      case ErrorResponse<UserEntity>():
        emit(state.copyWith(
          loginUserState: BaseState<UserEntity>(
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
}