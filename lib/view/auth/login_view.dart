import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_firebase/auth/log_in_user.dart';
import 'package:instagram_clone_firebase/components/my_auth_button.dart';
import 'package:instagram_clone_firebase/components/my_text_form_field.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';
import 'package:instagram_clone_firebase/utils/constants/responsive_dimensions.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

import '../../utils/Routes/route_names.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  bool _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void logIn() async {
    setState(() {
      _loading = true;
    });
    await LogInUser()
        .logInUser(_emailController.text, _passwordController.text, context);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    print('login screen');
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: width > WebDimensions
              ? EdgeInsets.symmetric(horizontal: width * webViewPadding)
              : EdgeInsets.symmetric(
                  horizontal: width * mobileViewPadding,
                ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer(),

                SizedBox(
                  height: height * 0.2675,
                ),
                //show instagram logo
                SvgPicture.asset(
                  'assets/images/instagram_logo.svg',
                  color: primaryColor,
                  height: height * 0.075,
                ),
                SizedBox(
                  height: height * 0.035,
                ),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //enter email
                      MyTextFormField(
                        hintText: 'Enter your email',
                        focusNode: _emailFocusNode,
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          bool isValidEmail =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value);

                          if (value == null || value.isEmpty) {
                            return ' Please enter your email';
                          } else if (!isValidEmail) {
                            return 'Please enter a valid email address';
                          }
                        },
                        onFieldSubmitted: (value) {
                          Utils.changeFocusNode(
                              context, _emailFocusNode, _passwordFocusNode);
                        },
                      ),

                      SizedBox(
                        height: height * 0.035,
                      ),
                      //enter password
                      MyTextFormField(
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Password should be atleast 6 characters';
                          }
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                    ],
                  ),
                ),
                //sign up button
                MyAuthButton(
                  onTap: logIn,
                  // onTap: () async {
                  //   if (formKey.currentState!.validate()) {
                  //     await logIn();
                  //   }
                  // },
                  title: 'Log In',
                  loading: _loading,
                ),

                SizedBox(
                  height: height * 0.2675,
                ),

                //don't have an account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?  "),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.signup);
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.035,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
