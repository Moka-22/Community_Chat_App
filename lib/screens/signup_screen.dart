import 'package:communitychat/widgets/logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../models/show_snakbar.dart';
import '../themes/colors.dart';
import '../themes/icons.dart';
import '../themes/logo.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = 'SignUpScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      'Register',
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
                  height: 10,
                ),
                TextFormFieldWidget(
                  obscureText: isObscure,
                  icon: passwordIcon,
                  suffixIcon: IconButton(
                    icon: isObscure
                        ? suffixIconOff
                        : suffixIconOn,
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  lableText: 'Password',
                  hintText: 'Enter Your Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        showSnakBar(context, 'Register Successfully');
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context, 'Weak Password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context, 'email already exist');
                        }
                      } catch (e) {
                        showSnakBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'Register',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account ?',
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignInScreen.id);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
