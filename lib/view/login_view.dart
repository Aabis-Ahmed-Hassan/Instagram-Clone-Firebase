import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_firebase/components/my_auth_button.dart';
import 'package:instagram_clone_firebase/components/my_text_form_field.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset(
                'assets/images/instagram_logo.svg',
                color: primaryColor,
                height: height * 0.075,
              ),
              SizedBox(
                height: height * 0.035,
              ),
              MyTextFormField(
                  hintText: 'Enter Your Email',
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  obscureText: false),
              SizedBox(
                height: height * 0.035,
              ),
              MyTextFormField(
                  hintText: 'Enter Your Password',
                  controller: _passwordController,
                  inputType: TextInputType.text,
                  obscureText: true),
              SizedBox(
                height: height * 0.035,
              ),
              MyAuthButton(
                onTap: () {},
                title: 'Login',
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?  "),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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
      )),
    );
  }
}
