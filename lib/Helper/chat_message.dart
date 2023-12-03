import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage(
      {super.key,
      required this.msg,
      required this.sender,
      required this.userAvatar});

  final String msg;
  final String sender;
  final String userAvatar;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 18.0,
              backgroundImage: widget.sender == "ChatGPT"
                  ? const AssetImage("images/gpt.png")
                  : AssetImage('images/user_${widget.userAvatar}.png'),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: widget.sender == "ChatGPT"
                      ? const Color(0xFF00A67E)
                      : const Color(0xFF7900B5)
                  // const Color(0xFFA102A9),
                  ),
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
              child: Container(
                margin: const EdgeInsets.only(right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                            ClipboardData(text: widget.msg));
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.copy_all_rounded,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      widget.msg,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
