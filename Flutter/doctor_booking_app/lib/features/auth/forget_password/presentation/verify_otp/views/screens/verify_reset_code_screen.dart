import 'package:doctor_booking_app/config/di/di.dart';
import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/core/ui_utils/dialog_utils.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/verify_otp/view_model/verify_reset_code_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/verify_otp/view_model/verify_reset_code_states.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/verify_otp/view_model/verify_reset_code_view_model.dart';
import 'package:doctor_booking_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  const VerifyResetCodeScreen({super.key});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
  VerifyResetCodeViewModel viewModel=getIt<VerifyResetCodeViewModel>();
  final ForgetPasswordViewModel _forgetPasswordViewModel=getIt<ForgetPasswordViewModel>();
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)?.settings.arguments as String;
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<VerifyResetCodeViewModel>(
          create: (context) => viewModel,
          child: BlocConsumer<VerifyResetCodeViewModel,VerifyResetCodeStates>(
            builder: (context, state) {
              Color boxColor=AppColors.pinputBgWhiteColor;
              Color borderColor=AppColors.lightGreyColor;
              String? errorText;
              if(state.verifyOtpState?.errorMessage!=null){
                borderColor=AppColors.pinputBgErrColor;
                borderColor=AppColors.redColor;
                errorText=state.verifyOtpState?.errorMessage;
              }
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 0.04*width),
                child: Column(
                  children: [
                    SizedBox(
                      width: 0.44*width,
                      height: 0.2*height,
                      child: Image.asset(AppAssets.logo,fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 0.02*height,),
                    Text(AppLocalizations.of(context)!.enter_otp,style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: 0.01*height,),
                    Text(AppLocalizations.of(context)!.enter_otp_instructions,style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),
                    SizedBox(height: 0.02*height,),
                    Pinput(
                      length: 6,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      defaultPinTheme: PinTheme(
                        width: 0.13*width,
                        height: 0.13*width,
                        textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 16
                        ),
                        decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(0.03*width),
                          border: Border.all(
                            color: borderColor
                          )
                        )
                      ),
                      focusedPinTheme: PinTheme(
                        width: 0.13*width,
                        height: 0.13*width,
                        textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 16
                        ),
                        decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(0.03*width),
                          border: Border.all(
                            color: state.verifyOtpState?.errorMessage!=null?AppColors.redColor:AppColors.blueColor
                          )
                        )
                      ),
                      onCompleted: (value) {
                        viewModel.doIntent(VerifyResetCodeUserEvent(value));
                      },
                    ),
                    if(errorText!=null) ...[
                      SizedBox(height: 0.01*height,),
                      Text(errorText,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.redColor),)
                    ],
                    SizedBox(height: 0.1*height,),
                    BlocProvider<ForgetPasswordViewModel>(
                      create: (context) => _forgetPasswordViewModel,
                      child: BlocListener<ForgetPasswordViewModel,ForgetPasswordStates>(
                        listener: (context, state) {
                          if(state.forgetPasswordState?.isLoading==true){
                            DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
                          }else if(state.forgetPasswordState?.isLoading==false && state.forgetPasswordState?.data!=null){
                            DialogUtils.removeLoading(context: context);
                            DialogUtils.showMessage(
                              context: context,
                              title: AppLocalizations.of(context)!.success, 
                              message: state.forgetPasswordState!.data!.info!,
                              posActionName: AppLocalizations.of(context)!.ok
                            );
                          }else if(state.forgetPasswordState?.isLoading==false && state.forgetPasswordState?.errorMessage!=null){
                            DialogUtils.removeLoading(context: context);
                            DialogUtils.showMessage(
                              context: context,
                              title: AppLocalizations.of(context)!.failure, 
                              message: state.forgetPasswordState!.errorMessage!,
                              negActionName: AppLocalizations.of(context)!.cancel
                            );
                          }
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _forgetPasswordViewModel.doIntent(ForgetPasswordUserEvent(email));
                            }, 
                            child: Text(AppLocalizations.of(context)!.send_otp)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.02*height,),
                    Text(AppLocalizations.of(context)!.resending_otp_duration,style: Theme.of(context).textTheme.bodyMedium,)
                  ],
                ),
              );
            }, 
            listener: (context, state) {
              if(state.verifyOtpState?.isLoading==true){
                DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
              }else if(state.verifyOtpState?.isLoading==false && state.verifyOtpState?.data!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.success, 
                  message: state.verifyOtpState!.data!.status!,
                  posActionName: AppLocalizations.of(context)!.ok,
                  posAction: () {
                    Navigator.pushNamed(context, AppRoutes.resetPassword,arguments: email);
                  },
                );
              }else if(state.verifyOtpState?.isLoading==false && state.verifyOtpState?.errorMessage!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.failure, 
                  message: state.verifyOtpState!.errorMessage!,
                  negActionName: AppLocalizations.of(context)!.cancel,
                );
              }
            },
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}