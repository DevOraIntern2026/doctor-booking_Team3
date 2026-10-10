import 'package:doctor_booking_app/config/di/di.dart';
import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/core/ui_utils/dialog_utils.dart';
import 'package:doctor_booking_app/core/validators/app_validators.dart';
import 'package:doctor_booking_app/features/auth/login/presentation/view_model/login_events.dart';
import 'package:doctor_booking_app/features/auth/login/presentation/view_model/login_states.dart';
import 'package:doctor_booking_app/features/auth/login/presentation/view_model/login_view_model.dart';
import 'package:doctor_booking_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel viewModel=getIt<LoginViewModel>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<LoginViewModel>(
          create: (context) => viewModel,
          child: BlocConsumer<LoginViewModel,LoginStates>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 0.04*width),
                child: Column(
                  children: [
                    SizedBox(
                      width: 0.6*width,
                      height: 0.27*height,
                      child: Image.asset(AppAssets.logo,fit: BoxFit.contain,)
                    ),
                    SizedBox(height: 0.01*height,),
                    Text(AppLocalizations.of(context)!.greeting,style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: 0.01*height,),
                    Text(AppLocalizations.of(context)!.login_instruction,style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: 0.05*height,),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.email,
                              prefixIcon: Icon(Icons.email_outlined,color: AppColors.greyColor,)
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return AppValidators.validateEmail(value, context);
                            },
                          ),
                          SizedBox(height: 0.01*height,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: state.isPasswordHidden!,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.password,
                              prefixIcon: Icon(Icons.lock_outline,color: AppColors.greyColor,),
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
                          SizedBox(height: 0.04*height,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.forgetPassword);
                                }, 
                                child: Text(AppLocalizations.of(context)!.forgot_password,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.blueColor
                                ),)
                              ),
                            ],
                          ),
                          SizedBox(height: 0.02*height,),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState?.validate()==true){
                                  viewModel.doIntent(LoginUserEvent(emailController.text, passwordController.text));
                                }
                              }, 
                              child: Text(AppLocalizations.of(context)!.login)
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.05*height,),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.dividerColor,
                            indent: 0.03*width,
                            endIndent: 0.05*width,
                          ),
                        ),
                        Text(AppLocalizations.of(context)!.or,style: Theme.of(context).textTheme.bodySmall,),
                        Expanded(
                          child: Divider(
                            color: AppColors.dividerColor,
                            indent: 0.03*width,
                            endIndent: 0.05*width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.05*height,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          foregroundColor: AppColors.googleButBlackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            side: BorderSide(color: AppColors.lightGreyColor,width: 2)
                          )
                        ),
                        onPressed: () {
                          
                        }, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.continue_with_google,style: Theme.of(context).textTheme.labelSmall,),
                            SizedBox(width: 0.03*width,),
                            Image.asset(AppAssets.googleIcon),
                          ],
                        )
                      ),
                    ),
                    SizedBox(height: 0.02*height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.do_not_have_account,style: Theme.of(context).textTheme.labelSmall,),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: Text(AppLocalizations.of(context)!.create_account,style: Theme.of(context).textTheme.labelMedium,)
                        )
                      ],
                    ),
                    SizedBox(height: 0.01*height,)
                  ],
                ),
              );
            }, 
            listener: (context, state) {
              if(state.loginUserState?.isLoading==true){
                DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
              }else if(state.loginUserState?.isLoading==false && state.loginUserState?.data!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.success, 
                  message: AppLocalizations.of(context)!.user_sign_in_success,
                  posActionName: AppLocalizations.of(context)!.ok,
                  posAction: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                );
              }else if(state.loginUserState?.isLoading==false && state.loginUserState?.errorMessage!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.failure, 
                  message: state.loginUserState!.errorMessage!,
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}