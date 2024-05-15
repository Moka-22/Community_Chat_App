import 'package:communitychat/screens/login_screen.dart';
import 'package:communitychat/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../themes/logo.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Center(
                child: Column(
                  children: [
                    Image.asset(logo,color: textColor,height: 100,),
                    Text(
                      'Community Chat',
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text('Home',style: TextStyle(color: textColor),),
                  leading: Icon(Icons.home, color: textColor,),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text('Logout',style: TextStyle(color: textColor),),
              leading: Icon(Icons.logout_outlined, color: textColor,),
              onTap: (){
                _signOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async{
    try{
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, SignInScreen.id);
    }catch (e){
      print('Error signing out : $e');
    }
  }
}
