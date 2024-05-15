import 'package:communitychat/screens/chat_screen.dart';
import 'package:communitychat/themes/colors.dart';
import 'package:communitychat/themes/logo.dart';
import 'package:communitychat/widgets/drawer_widget.dart';
import 'package:communitychat/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? email;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MenuDrawer(),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text(
          'Home',
          style: TextStyle(
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50,),),
                    ),
                    backgroundColor: tabColor,
                    minimumSize: Size(double.infinity, 50),
                    elevation: 0),
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                },
                child: Text(
                  'Go To Chatting',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
