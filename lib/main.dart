import 'package:communitychat/screens/chat_screen.dart';
import 'package:communitychat/screens/forget_password_screen.dart';
import 'package:communitychat/screens/home_screen.dart';
import 'package:communitychat/screens/login_screen.dart';
import 'package:communitychat/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Chat',
      routes: {
        HomeScreen.id : (context) => HomeScreen(),
        SignInScreen.id : (context) => SignInScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        ForgetPassWordScreen.id: (context) => ForgetPassWordScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: SignInScreen.id,
    );
  }
}
