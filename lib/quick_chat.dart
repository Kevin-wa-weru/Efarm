import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickChatDetails extends StatefulWidget {
  const QuickChatDetails(
      {Key? key,
      required this.userID,
      required this.name,
      required this.avatarUrl})
      : super(key: key);
  final String userID;
  final String name;
  final String avatarUrl;

  @override
  State<QuickChatDetails> createState() => _QuickChatDetailsState();
}

class _QuickChatDetailsState extends State<QuickChatDetails> {
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
                      widget.avatarUrl == ''
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xFFE8E8E8),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.0147783251,
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                  child: SvgPicture.asset(
                                      'assets/icons/user.svg',
                                      color: Colors.black12,
                                      fit: BoxFit.contain),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: MediaQuery.of(context).size.height *
                                  0.023251231,
                              backgroundImage: NetworkImage(widget.avatarUrl),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            const Padding(
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(AuthenticationHelper().userid.trim())
                    .collection('messages')
                    .doc(widget.userID.trim())
                    .collection('thread')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Expanded(
                        child: ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container();
                      },
                    ));
                  } else {
                    if (snapshot.data.docs.length < 1) {
                      return Expanded(
                          child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Container();
                        },
                      ));
                    } else {
                      return Expanded(
                          child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data!.docs[index]['userId'] ==
                              AuthenticationHelper().userid.trim()) {
                            return SingleLocalBubble(
                                message: snapshot.data!.docs[index]['message'],
                                time: DateTime.parse(snapshot
                                    .data!.docs[index]['time']
                                    .toDate()
                                    .toString()));
                          } else {
                            return SingleReceivedBubble(
                                message: snapshot.data!.docs[index]['message'],
                                time: DateTime.parse(snapshot
                                    .data!.docs[index]['time']
                                    .toDate()
                                    .toString()));
                          }
                        },
                      ));
                    }
                  }
                }),
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
                              keyboardType: TextInputType.name,
                              enableSuggestions: true,
                              textCapitalization: TextCapitalization.sentences,
                              autocorrect: true,
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
                                      child: InkWell(
                                        onTap: () async {
                                          if (chatController.text.isEmpty) {
                                          } else {
                                            final CollectionReference chatRef =
                                                FirebaseFirestore.instance
                                                    .collection('chats')
                                                    .doc(AuthenticationHelper()
                                                        .userid
                                                        .trim())
                                                    .collection('messages')
                                                    .doc(widget.userID.trim())
                                                    .collection('thread');

                                            final latestMessage =
                                                FirebaseFirestore.instance
                                                    .collection('chats')
                                                    .doc(AuthenticationHelper()
                                                        .userid
                                                        .trim())
                                                    .collection('messages')
                                                    .doc(widget.userID.trim());

                                            await chatRef.add({
                                              'userId':
                                                  AuthenticationHelper().userid,
                                              'time': DateTime.now(),
                                              'message': chatController.text,
                                            });

                                            await latestMessage.set({
                                              'avatarUrl': widget.avatarUrl,
                                              'name': widget.name,
                                              'message': chatController.text,
                                              'id': widget.userID.trim(),
                                              'time': DateTime.now()
                                            });

                                            chatController.clear();
                                          }
                                        },
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.029864,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.061333333333,
                                          child: SvgPicture.asset(
                                              'assets/icons/send.svg',
                                              fit: BoxFit.contain),
                                        ),
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

class SingleReceivedBubble extends StatelessWidget {
  const SingleReceivedBubble({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);
  final String message;
  final DateTime time;
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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 2, top: 10, bottom: 10),
                child: Text(
                  message,
                  style: const TextStyle(
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
                child: Text(
                  '${time.hour}:${time.minute}${time.hour > 12 ? 'pm' : 'am'}',
                  style: const TextStyle(
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

class SingleLocalBubble extends StatelessWidget {
  const SingleLocalBubble({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);
  final String message;
  final DateTime time;

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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 2, top: 10, bottom: 10),
                child: Text(
                  message,
                  style: const TextStyle(
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
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${time.hour}:${time.minute}${time.hour > 12 ? 'pm' : 'am'}',
                    style: const TextStyle(
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
