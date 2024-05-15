import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communitychat/fire_collection/collection.dart';
import 'package:communitychat/models/message_model.dart';
import 'package:communitychat/widgets/chat_widget_another_user.dart';
import 'package:communitychat/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/logo.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);

  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();
  String? email;
  bool isAttachment = false;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    height: 50,
                    color: textColor,
                  ),
                  Text(
                    'Community Chat',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              backgroundColor: primaryColor,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatWidget(
                                message: messageList[index],
                              )
                            : ChatFriendUserWidget(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        kMessage: value,
                        kCreatedAt: DateTime.now(),
                        'id': email
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    cursorColor: textColor,
                    decoration: InputDecoration(
                      hintText: 'Send a Message',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            if (controller.text.isNotEmpty) {
                              messages.add({
                                kMessage: controller.text,
                                kCreatedAt: DateTime.now(),
                                'id': email,
                              });
                              controller.clear();
                              _controller.animateTo(
                                0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: primaryColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  LogoWidget(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
