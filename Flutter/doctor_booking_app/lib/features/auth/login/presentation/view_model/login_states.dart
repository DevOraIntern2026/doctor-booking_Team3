import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/login/domain/entities/user_entity.dart';

class LoginStates {
  BaseState<UserEntity>? loginUserState;
  bool? isPasswordHidden;
  LoginStates({this.loginUserState,this.isPasswordHidden=true});
  LoginStates copyWith({
    BaseState<UserEntity>? loginUserState,
    bool? isPasswordHidden
  }){
    return LoginStates(
      loginUserState: loginUserState ?? this.loginUserState,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden
    );
  }
}