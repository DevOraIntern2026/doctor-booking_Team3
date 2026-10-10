sealed class ForgetPasswordEvents {}
class ForgetPasswordUserEvent extends ForgetPasswordEvents{
  final String email;
  ForgetPasswordUserEvent(this.email);
}