import 'package:anonym_ask/Helper/api_services.dart';
import 'package:anonym_ask/Screens/about_screen.dart';
import 'package:anonym_ask/Screens/choose_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Helper/constants.dart';
import '../Helper/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Text controller for the text field
  final TextEditingController _controller = TextEditingController();

  //Chat message list
  final List<ChatMessage> _messages = [];

  //var to store the last answer by chat GPT(api response)
  String lastMsg = "";

  //variable to store api response
  String msg = "";

  bool _isTyping = false;

  //function for sending messages
  void _sendMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('userAvatar');
    String userAvatar = imagePath ?? 'male';

    ChatMessage message = ChatMessage(
        msg: _controller.text, sender: "user", userAvatar: userAvatar);
    if (message.msg.isNotEmpty) {
      //inserting the message/question asked to the Chat GPT in the message list
      setState(() {
        _messages.insert(0, message);
        _isTyping = true;
      });

      //clearing the text field after sending message
      _controller.clear();
      lastMsg = msg;
      String newMsg = "$lastMsg. ${message.msg}";

      //sending only text of the command/questions to the chat gpt api handler
      msg = await sendMessageToChatGPT(newMsg);

      setState(() {
        _isTyping = false;
        _messages.insert(
            0,
            ChatMessage(
              msg: msg,
              sender: "ChatGPT",
              userAvatar: "gpt",
            ));
      });
    } else {
      Fluttertoast.showToast(
          msg: "Text field can't be empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //text field for sending messages
  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: kTextFieldDecoration,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () => _sendMessage(),
            // color: const Color(0xFF00A67E),
            color: Colors.deepPurple,
            textColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.send_rounded,
              size: 24,
            ),
          ),
        )
      ],
    ).px12();
  }

//moreOptClickListener
  void moreOptClickListener(String value) {
    switch (value) {
      case 'About':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AboutUs()));
        break;

      case 'Change Avatar':
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const ChooseAvatar()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.deepPurple,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white, // Set the desired icon color here
              ),
              onSelected: moreOptClickListener,
              itemBuilder: (BuildContext context) {
                return {'About', 'Change Avatar'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList();
              },
            ),
          ],
          title: const Text(
            "AnonymAsk",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          // backgroundColor: const Color(0xFF8D0892)
          backgroundColor: const Color(0xFF000000),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  padding: Vx.m8,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              _isTyping == true
                  ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 20.0,
                    )
                  : const SizedBox(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: _buildTextComposer(),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
