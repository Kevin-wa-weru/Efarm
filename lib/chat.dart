import 'package:eshamba/chat_details.dart';
import 'package:eshamba/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
                const Center(
                  child: Text(
                    'Chat',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.053251231,
                ),
                Column(
                    children: cateogry
                        .map(
                          (e) => const SingleChat(),
                        )
                        .toList())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleChat extends StatelessWidget {
  const SingleChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, bottom: 35),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatDetails()));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.023251231,
              backgroundImage: const AssetImage('assets/images/woman.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.73333333,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'oliviathomson573',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Text(
                          '8:36pm',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.73333333,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'How are you',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
