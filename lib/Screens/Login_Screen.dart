import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utilities/Colors.dart';
import 'package:instagram/widgets/Text_Field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            //logo
            SvgPicture.asset(
              'Assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),

            const SizedBox(
              height: 64,
            ),

            TextFieldInput(
              hintText: 'Enter your Email',
              textEditingController: emailController,
              textInputType: TextInputType.emailAddress,
            ),

            const SizedBox(
              height: 24,
            ),

            TextFieldInput(
              hintText: 'Enter your Password',
              textEditingController: passwordController,
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
                height: 24,
            ),

            Container(  
              child: const Text('Login'),
              width: double.infinity,
              alignment: Alignment.center,
              padding:const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  color: blueColor),
            )
          ],
        ),
      )),
    );
  }
}
