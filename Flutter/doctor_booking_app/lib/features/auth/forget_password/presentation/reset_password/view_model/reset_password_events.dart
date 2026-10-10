sealed class ResetPasswordEvents {}
class ResetPasswordUserEvent extends ResetPasswordEvents{
  final String email;
  final String newPassword;
  ResetPasswordUserEvent(this.email,this.newPassword);
}
class TogglePasswordVisibilityEvent extends ResetPasswordEvents{}
class ToggleConfirmPasswordVisibilityEvent extends ResetPasswordEvents{}