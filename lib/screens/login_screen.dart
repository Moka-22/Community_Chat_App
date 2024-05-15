import 'package:communitychat/screens/chat_screen.dart';
import 'package:communitychat/screens/forget_password_screen.dart';
import 'package:communitychat/screens/home_screen.dart';
import 'package:communitychat/screens/signup_screen.dart';
import 'package:communitychat/themes/icons.dart';
import 'package:communitychat/widgets/logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../models/show_snakbar.dart';
import '../themes/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});
  static String id = 'SignInScreen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                      'Sign In',
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
                        await signInUser();
                        showSnakBar(context, 'Sign In Successfully');
                        Navigator.pushNamed(context, HomeScreen.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          showSnakBar(context, 'Invalid Email');
                        }else if (e.code == 'wrong-password') {
                          showSnakBar(context, 'Password is wrong');
                        }
                      } catch (e) {
                        showSnakBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'Sign In',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ForgetPassWordScreen.id);
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(color: tabColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account ?',
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: tabColor),
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

  Future<void> signInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
