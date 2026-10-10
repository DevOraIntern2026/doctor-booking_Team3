import 'package:doctor_booking_app/config/di/di.dart';
import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/core/ui_utils/dialog_utils.dart';
import 'package:doctor_booking_app/core/validators/app_validators.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:doctor_booking_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordViewModel viewModel=getIt<ForgetPasswordViewModel>();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(child: BlocProvider<ForgetPasswordViewModel>(
        create: (context) => viewModel,
        child: BlocConsumer<ForgetPasswordViewModel,ForgetPasswordStates>(
          builder: (context, state) {
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
                  Text(AppLocalizations.of(context)!.forgot_password,style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 0.01*height,),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(AppLocalizations.of(context)!.forget_password_instruction,style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 0.05*height,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.email,style: Theme.of(context).textTheme.bodySmall,),
                        SizedBox(height: 0.01*height,),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.hint_email,
                            prefixIcon: Icon(Icons.email_outlined,color: AppColors.greyColor,)
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return AppValidators.validateEmail(value,context);
                          },
                        ),
                        SizedBox(height: 0.05*height,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState?.validate()==true){
                                viewModel.doIntent(ForgetPasswordUserEvent(emailController.text));
                              }
                            }, 
                            child: Text(AppLocalizations.of(context)!.send_otp)
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            );
          }, 
          listener: (context, state) {
            if(state.forgetPasswordState?.isLoading==true){
              DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
            }else if(state.forgetPasswordState?.isLoading==false && state.forgetPasswordState?.data!=null){
              DialogUtils.removeLoading(context: context);
              DialogUtils.showMessage(
                context: context,
                title: AppLocalizations.of(context)!.success, 
                message: state.forgetPasswordState!.data!.info!,
                posActionName: AppLocalizations.of(context)!.ok,
                posAction: () {
                  Navigator.pushNamed(context, AppRoutes.verifyOtp,arguments: emailController.text);
                },
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
        ),
      )),
    );
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}