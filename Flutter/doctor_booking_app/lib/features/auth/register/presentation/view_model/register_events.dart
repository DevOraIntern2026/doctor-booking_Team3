sealed class RegisterEvents {}
class RegisterUserEvent extends RegisterEvents{
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  RegisterUserEvent(this.name,this.email,this.password,this.confirmPassword);
}
class TogglePasswordVisibilityEvent extends RegisterEvents{}
class ToggleConfirmPasswordVisibilityEvent extends RegisterEvents{}
class ToggleAgreementCheckboxEvent extends RegisterEvents {}