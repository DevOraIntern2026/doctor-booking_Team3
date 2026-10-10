import 'package:doctor_booking_app/config/di/di.dart';
import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/core/ui_utils/dialog_utils.dart';
import 'package:doctor_booking_app/core/validators/app_validators.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/reset_password/view_model/reset_password_events.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/reset_password/view_model/reset_password_states.dart';
import 'package:doctor_booking_app/features/auth/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:doctor_booking_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordViewModel viewModel=getIt<ResetPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)?.settings.arguments as String;
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<ResetPasswordViewModel>(
          create: (context) => viewModel,
          child: BlocConsumer<ResetPasswordViewModel,ResetPasswordStates>(
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
                    Text(AppLocalizations.of(context)!.make_new_password,style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: 0.01*height,),
                    Text(AppLocalizations.of(context)!.new_password_instruction,style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: 0.02*height,),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.label_new_password,style: Theme.of(context).textTheme.bodySmall,),
                          SizedBox(height: 0.01*height,),
                          TextFormField(
                            obscureText: state.isPasswordHidden!,
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.password,
                              prefixIcon: Icon(Icons.lock_outlined,color: AppColors.greyColor,),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  viewModel.doIntent(TogglePasswordVisibilityEvent());
                                }, 
                                icon: state.isPasswordHidden!?Icon(Icons.visibility_off_outlined,color: AppColors.toggleBlackColor,):Icon(Icons.visibility_outlined,color: AppColors.toggleBlackColor,)
                              )
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return AppValidators.validatePassword(value,context);
                            },
                          ),
                          SizedBox(height: 0.02*height,),
                          Text(AppLocalizations.of(context)!.label_new_password,style: Theme.of(context).textTheme.bodySmall,),
                          SizedBox(height: 0.01*height,),
                          TextFormField(
                            obscureText: state.isConfirmPasswordHidden!,
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.hint_confirm_password,
                              prefixIcon: Icon(Icons.lock_outline,color: AppColors.greyColor,),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  viewModel.doIntent(ToggleConfirmPasswordVisibilityEvent());
                                }, 
                                icon: state.isConfirmPasswordHidden!?Icon(Icons.visibility_off_outlined,color: AppColors.toggleBlackColor,):Icon(Icons.visibility_outlined,color: AppColors.toggleBlackColor,)
                              )
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return AppValidators.validateConfirmPassword(value,passwordController.text,context);
                            },
                          ),
                          SizedBox(height: 0.02*height,),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState?.validate()==true){
                                  viewModel.doIntent(ResetPasswordUserEvent(email, passwordController.text));
                                }
                              }, 
                              child: Text(AppLocalizations.of(context)!.save_password)
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
              if(state.resetPasswordState?.isLoading==true){
                DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
              }else if(state.resetPasswordState?.isLoading==false && state.resetPasswordState?.data!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.success, 
                  message: state.resetPasswordState!.data!.message!,
                  posActionName: AppLocalizations.of(context)!.ok,
                  posAction: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                );
              }else if(state.resetPasswordState?.isLoading==false && state.resetPasswordState?.errorMessage!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.failure, 
                  message: state.resetPasswordState!.errorMessage!,
                  negActionName: AppLocalizations.of(context)!.cancel
                );
              }
            },
          ),
        )
      ),
    );
  }
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}