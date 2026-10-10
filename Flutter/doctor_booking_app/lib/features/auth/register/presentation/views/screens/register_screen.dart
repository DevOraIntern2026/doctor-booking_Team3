import 'package:doctor_booking_app/config/di/di.dart';
import 'package:doctor_booking_app/core/resources/app_assets.dart';
import 'package:doctor_booking_app/core/resources/app_colors.dart';
import 'package:doctor_booking_app/core/routes/app_routes.dart';
import 'package:doctor_booking_app/core/ui_utils/dialog_utils.dart';
import 'package:doctor_booking_app/core/validators/app_validators.dart';
import 'package:doctor_booking_app/features/auth/register/presentation/view_model/register_events.dart';
import 'package:doctor_booking_app/features/auth/register/presentation/view_model/register_states.dart';
import 'package:doctor_booking_app/features/auth/register/presentation/view_model/register_view_model.dart';
import 'package:doctor_booking_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModel viewModel=getIt<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<RegisterViewModel>(
          create: (context) => viewModel,
          child: BlocConsumer<RegisterViewModel,RegisterStates>(
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
                    SizedBox(height: 0.01*height,),
                    Text(AppLocalizations.of(context)!.register_headline,style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: 0.005*height),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(AppLocalizations.of(context)!.register_instruction,style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 0.005*height),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.full_name,style: Theme.of(context).textTheme.bodySmall,),
                          SizedBox(height: 0.01*height,),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.hint_full_name,
                              prefixIcon: Icon(Icons.person_outline,color: AppColors.greyColor,)
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return AppValidators.validateUserName(value,context);
                            },
                          ),
                          SizedBox(height: 0.01*height,),
                          Text(AppLocalizations.of(context)!.email,style: Theme.of(context).textTheme.bodySmall,),
                          SizedBox(height: 0.01*height,),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.email,
                              prefixIcon: Icon(Icons.email_outlined,color: AppColors.greyColor,)
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return AppValidators.validateEmail(value,context);
                            },
                          ),
                          SizedBox(height: 0.01*height,),
                          Text(AppLocalizations.of(context)!.password,style: Theme.of(context).textTheme.bodySmall,),
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
                          SizedBox(height: 0.01*height,),
                          Text(AppLocalizations.of(context)!.confirm_password,style: Theme.of(context).textTheme.bodySmall,),
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
                          SizedBox(height: 0.03*height,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                side: BorderSide(
                                  color: AppColors.blueColor
                                ),
                                checkColor: AppColors.whiteColor,
                                activeColor: AppColors.blueColor,
                                value: state.isAgreementChecked, 
                                onChanged: (value) {
                                  viewModel.doIntent(ToggleAgreementCheckboxEvent());
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(4)
                                ),
                              ),
                              SizedBox(width: 0.02*width,),
                              Text(AppLocalizations.of(context)!.agreement,style: Theme.of(context).textTheme.labelSmall,),
                              SizedBox(width: 0.01*width,),
                              Text(AppLocalizations.of(context)!.terms_conditions,style: Theme.of(context).textTheme.labelMedium,),
                              SizedBox(width: 0.01*width,),
                              Text(AppLocalizations.of(context)!.and,style: Theme.of(context).textTheme.labelSmall,),
                              SizedBox(width: 0.01*width,),
                              Text(AppLocalizations.of(context)!.privacy_policy,style: Theme.of(context).textTheme.labelMedium,)
                            ],
                          ),
                          SizedBox(height: 0.03*height,),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final isFormValid = _formKey.currentState?.validate() ?? false;
                                final isAgreementChecked = state.isAgreementChecked ?? false;
                                if(isFormValid && isAgreementChecked){
                                  viewModel.doIntent(RegisterUserEvent(nameController.text,emailController.text,passwordController.text,confirmPasswordController.text));
                                }else if(!isAgreementChecked){
                                  DialogUtils.showMessage(
                                    context: context,
                                    title: AppLocalizations.of(context)!.failure,
                                    message: AppLocalizations.of(context)!.agreement_required,  
                                   posActionName: AppLocalizations.of(context)!.ok,
                                  );
                                }
                              }, 
                              child: Text(AppLocalizations.of(context)!.create_account)
                            ),
                          ),
                        ],
                      )
                    ),
                    SizedBox(height: 0.03*height,),
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
                    SizedBox(height: 0.03*height,),
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
                    SizedBox(height: 0.04*height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.already_have_account,style: Theme.of(context).textTheme.labelSmall,),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.login,style: Theme.of(context).textTheme.labelMedium,)
                        )
                      ],
                    ),
                    SizedBox(height: 0.01*height,)
                  ],
                ),
              );
            }, 
            listener: (context, state) {
              if(state.registerState?.isLoading==true){
                DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
              }else if(state.registerState?.isLoading==false && state.registerState?.data!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.success, 
                  message: AppLocalizations.of(context)!.user_sign_up_success,
                  posActionName: AppLocalizations.of(context)!.ok,
                  posAction: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                );
              }else if(state.registerState?.isLoading==false && state.registerState?.errorMessage!=null){
                DialogUtils.removeLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: AppLocalizations.of(context)!.failure, 
                  message: state.registerState!.errorMessage!,
                  negActionName: AppLocalizations.of(context)!.cancel,
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}