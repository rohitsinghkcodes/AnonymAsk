import 'package:flutter/material.dart';
import '../Helper/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  static const id = "about_us_screen";

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

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
          backgroundColor: const Color(0xFF000000),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'About Us',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.ac_unit_rounded)),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                          'AnonymAsk is an interactive chat bot application built using artificial intelligence techniques. This Flutter project leverages the power of natural language processing to engage in conversations and provide responses to user input. It aims to showcase the capabilities of AI in the field of conversational agents through a mobile application.\n\nAnonymAsk offers a unique feature that allows users to ask questions on this platform anonymously. Users can engage in open and candid conversations without revealing their identity, making it a secure and private space for inquiries. Whether seeking information, advice, or simply engaging in casual chat, AnonymAsk provides a seamless and anonymous experience, highlighting the versatility of AI in fostering meaningful interactions.',
                          textAlign:  TextAlign.justify,
                          style: content),
                    ),
                    const SizedBox(height: 20),
                    Text("Features", style: headingStyle),
                    const SizedBox(height: 1),
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🔹 Interactive Conversations", style: content),
                          const SizedBox(height: 1),
                          Text("🔹 Natural Language Processing",
                              style: content),
                          const SizedBox(height: 1),
                          Text("🔹 Customizable Responses: ", style: content),
                          const SizedBox(height: 1),
                          Text("🔹 Multiple Integration Options",
                              style: content),
                          const SizedBox(height: 1),
                          Text("🔹 Extensible Architecture", style: content),
                          const SizedBox(height: 1),
                          Text("🔹 Anonymous Inquiry", style: content),

                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("License", style: headingStyle),
                    const SizedBox(height: 1),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                          "AnonymAsk Flutter project is released under the 'MIT License'. Feel free to modify and distribute the code as per the terms of the license.",
                          textAlign:  TextAlign.justify,
                          style: content),
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                child: Text(
                  'D E V E L O P E D . B Y . R O H I T',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
