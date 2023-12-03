import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/constants.dart';
import 'chat_screen.dart';

class ChooseAvatar extends StatefulWidget {
  const ChooseAvatar({Key? key}) : super(key: key);

  static const id = "about_us_screen";

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  var userDp;
  int selectedCard = -1;

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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xFF000000),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Choose Your Avatar',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GridView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      itemCount: userArtLinks.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCard = index;
                              userDp = userArtLinks[index];
                            });
                          },
                          child: Card(
                            shape: const CircleBorder(),
                            // Check if the index is equal to the selected Card integer
                            color: selectedCard == index
                                ? Colors.white
                                : Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              height: 200,
                              width: 200,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  // Image radius
                                  child: Image.asset(
                                      'images/user_${userArtLinks[index]}.png',
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedCard != -1) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('userAvatar', userDp.toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ChatScreen()));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please choose an avatar to continue!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor:
                        selectedCard == -1 ? Colors.black : Colors.deepPurple,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                  child: Text(
                    selectedCard == -1 ? 'CHOOSE AVATAR' : 'SET AVATAR',
                    style: TextStyle(
                        color: selectedCard == -1
                            ? Colors.deepPurple
                            : Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
