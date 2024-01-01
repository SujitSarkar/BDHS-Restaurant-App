import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/text_size.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/solid_button.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../provider/authentication_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AuthenticationProvider authProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              ///Header
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/login_header_bg.jpg',
                      width: size.width,
                      height: size.height * .3,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height * .3,
                      color: Colors.black.withOpacity(0.4),
                      child: const Text(
                        'Lettuce\nEat',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            height: 1,
                            color: Colors.white,
                            fontSize: TextSize.headerText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              ///Body
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  height: size.height * .7,
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      color: AppColor.appBodyBg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: authProvider.signupFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(AppString.signUpHeader,
                              style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontSize: TextSize.titleText,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          TextFormFieldWidget(
                            controller: authProvider.emailController,
                            labelText: 'Enter Your Full Name',
                            hintText: 'Full Name',
                            required: true,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextFormFieldWidget(
                            controller: authProvider.emailController,
                            labelText: 'Enter Your Email Address',
                            hintText: 'Email Address',
                            required: true,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextFormFieldWidget(
                            controller: authProvider.passwordController,
                            obscure: true,
                            labelText: 'Enter Password',
                            hintText: 'Password',
                            required: true,
                          ),
                          const SizedBox(height: 20),

                          ///Login Button
                          SolidButton(
                              onTap: () async {
                                await authProvider.signupButtonOnTap();
                              },
                              child: authProvider.loading
                                  ? const LoadingWidget(color: Colors.white)
                                  : const Text(
                                'Signup',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TextSize.buttonText,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(height: 24),

                          ///Create Account
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: TextSize.bodyText),
                              children: [
                                const TextSpan(text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Sign In',
                                  style:
                                  const TextStyle(color: AppColor.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
