import 'package:communitychat/models/show_snakbar.dart';
import 'package:communitychat/screens/login_screen.dart';
import 'package:communitychat/widgets/button_widget.dart';
import 'package:communitychat/widgets/logo_widget.dart';
import 'package:communitychat/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../themes/colors.dart';
import '../themes/icons.dart';

class ForgetPassWordScreen extends StatefulWidget {
  const ForgetPassWordScreen({super.key});
  static String id = 'ForgetPasswordScreen';
  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}

class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                LogoWidget(),
                const SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 24,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                  icon: emailIcon,
                  onChanged: (value) {
                    email = value;
                  },
                  lableText: 'Email',
                  hintText: 'Enter Your Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      Navigator.pushNamed(context, SignInScreen.id);
                      try {
                        await restPassword();
                        showSnakBar(context, 'Rest Password Link sent');
                      } on FirebaseAuthException catch (e) {
                        print(e);
                        showSnakBar(context, e.message.toString());
                      }
                      setState(
                        () {
                          isLoading = false;
                        },
                      );
                    }
                  },
                  text: 'Reset Password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future restPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
  }
}
