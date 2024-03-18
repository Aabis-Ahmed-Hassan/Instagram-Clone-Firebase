import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_firebase/components/my_auth_button.dart';
import 'package:instagram_clone_firebase/components/my_text_form_field.dart';
import 'package:instagram_clone_firebase/res/app_auth.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

import '../utils/Routes/route_names.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer(),
                SvgPicture.asset(
                  'assets/images/instagram_logo.svg',
                  color: primaryColor,
                  height: height * 0.075,
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                MyTextFormField(
                  hintText: 'Enter your username',
                  controller: _usernameController,
                  inputType: TextInputType.text,
                  obscureText: false,
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                MyTextFormField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                    obscureText: false),
                SizedBox(
                  height: height * 0.035,
                ),
                MyTextFormField(
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    inputType: TextInputType.text,
                    obscureText: true),
                SizedBox(
                  height: height * 0.035,
                ),
                MyTextFormField(
                    hintText: 'Enter your bio',
                    controller: _bioController,
                    inputType: TextInputType.text,
                    obscureText: false),
                SizedBox(
                  height: height * 0.035,
                ),
                MyAuthButton(
                  onTap: () async {
                    print('tapped');
                    String response = await AppAuth().signupUser(
                      _emailController.text,
                      _passwordController.text,
                      _usernameController.text,
                      _bioController.text,
                    );
                    print(response);
                    print('tapped');
                  },
                  title: 'Sign Up',
                ),
                // Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Alread have an account?  "),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.login);
                      },
                      child: Text(
                        "Log In",
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
