sealed class VerifyResetCodeEvents {}
class VerifyResetCodeUserEvent extends VerifyResetCodeEvents{
  final String resetCode;
  VerifyResetCodeUserEvent(this.resetCode);
}