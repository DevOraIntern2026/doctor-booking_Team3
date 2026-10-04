import 'package:doctor_booking_app/config/base_state/base_state.dart';
import 'package:doctor_booking_app/features/auth/register/domain/entities/user_entity.dart';

class RegisterStates {
  BaseState<UserEntity>? registerState;
  bool? isPasswordHidden;
  bool? isConfirmPasswordHidden;
  bool? isAgreementChecked;
  RegisterStates({this.registerState,this.isPasswordHidden=true,this.isConfirmPasswordHidden=true,this.isAgreementChecked=false});
  RegisterStates copyWith({
    BaseState<UserEntity>? registerState,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden,
    bool? isAgreementChecked
  }){
    return RegisterStates(
      registerState: registerState ?? this.registerState,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
      isAgreementChecked: isAgreementChecked ?? this.isAgreementChecked
    );
  } 
}