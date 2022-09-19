import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({Key? key}) : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.053333333,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.053333333,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius:
                            MediaQuery.of(context).size.height * 0.023251231,
                        backgroundImage:
                            const AssetImage('assets/images/woman.jpg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: const [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'oliviathomson573',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                  'Online',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                Column(
                  children: const [
                    singleReceivedBubble(),
                    singleLocalBubble(),
                    singleLocalBubble(),
                    singleReceivedBubble(),
                    singleReceivedBubble(),
                    singleLocalBubble(),
                    singleLocalBubble(),
                    singleReceivedBubble(),
                    singleReceivedBubble(),
                    singleLocalBubble(),
                    singleLocalBubble(),
                    singleReceivedBubble(),
                    singleReceivedBubble(),
                    singleLocalBubble(),
                    singleLocalBubble(),
                    singleReceivedBubble(),
                  ],
                ),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.0726600985,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                        ),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0746600985,
                          width:
                              MediaQuery.of(context).size.width * 0.157333333,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF7CD956),
                                    Color(0xFF3EA334),
                                  ])),
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.0233990,
                              width: MediaQuery.of(context).size.width *
                                  0.050666666,
                              child: SvgPicture.asset('assets/icons/add.svg',
                                  color: Colors.white, fit: BoxFit.fitHeight),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(43),
                              color: Colors.transparent,
                              border: Border.all(
                                color: const Color(0xFF39B54A),
                                width: 1,
                              )),
                          width: MediaQuery.of(context).size.width * 0.696,
                          height:
                              MediaQuery.of(context).size.height * 0.07266009,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 0.2),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.0197339,
                                ),
                                prefix: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                  ),
                                ),
                                suffix: InkWell(
                                  onTap: () {},
                                  child: Transform.translate(
                                    offset: const Offset(0.0, 2.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05872),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.029864,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.061333333333,
                                        child: SvgPicture.asset(
                                            'assets/icons/send.svg',
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                ),
                                filled: true,
                                hintText: 'Write a reply...',
                                hintStyle: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: chatController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class singleReceivedBubble extends StatelessWidget {
  const singleReceivedBubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.58933333,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Color(0xFFF4F4F4),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 2, top: 10, bottom: 10),
                child: Text(
                  'What are you doing?',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.58933333,
                child: const Text(
                  '8:36pm',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class singleLocalBubble extends StatelessWidget {
  const singleLocalBubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.58933333,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Color(0xFF39B54A),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 2, top: 10, bottom: 10),
                child: Text(
                  'I am filling out this job application',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.58933333,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '8:36pm',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
