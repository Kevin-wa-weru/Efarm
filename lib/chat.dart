import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/Cubits/get_messaged_user_cubit.dart';
import 'package:eshamba/chat_details.dart';
import 'package:eshamba/models/data.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Column(
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
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chats")
                        .doc(AuthenticationHelper().userid.trim())
                        .collection('messages')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChat(
                              avatarUrl: snapshot.data!.docs[index]
                                  ['avatarUrl'],
                              message: snapshot.data!.docs[index]['message'],
                              name: snapshot.data!.docs[index]['name'],
                              time: DateTime.parse(snapshot
                                  .data!.docs[index]['time']
                                  .toDate()
                                  .toString()),
                              userId: snapshot.data!.docs[index]['id'],
                            );
                          },
                        );
                      } else {
                        return Column(
                            children: cateogry
                                .map(
                                  (e) => const SingleLoadingChat(),
                                )
                                .toList());
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

class SingleChat extends StatelessWidget {
  const SingleChat({
    Key? key,
    required this.avatarUrl,
    required this.message,
    required this.name,
    required this.time,
    required this.userId,
  }) : super(key: key);

  final String avatarUrl;
  final String message;
  final String name;
  final DateTime time;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, bottom: 35),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetails(
                        avatarUrl: avatarUrl,
                        name: name,
                        userID: userId,
                      )));
        },
        child: Row(
          children: [
            Hero(
              tag: avatarUrl,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.023251231,
                backgroundImage: NetworkImage(avatarUrl),
              ),
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
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Text(
                          '${time.hour}:${time.minute}',
                          style: const TextStyle(
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
                        children: [
                          Text(
                            message,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          const Text(
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

class SingleLoadingChat extends StatelessWidget {
  const SingleLoadingChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, bottom: 35),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.0581773399,
            width: MediaQuery.of(context).size.height * 0.0581773399,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFAFAFA),
            ),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.02987684,
                width: MediaQuery.of(context).size.width * 0.0693333333,
                child: SvgPicture.asset('assets/icons/users.svg',
                    color: Colors.black12, fit: BoxFit.contain),
              ),
            ),
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
                    children: [
                      Container(
                        width: 150,
                        height: 10,
                        color: const Color(0xFFFAFAFA),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        color: const Color(0xFFFAFAFA),
                      )
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
                      children: [
                        Container(
                          width: 250,
                          height: 10,
                          color: const Color(0xFFFAFAFA),
                        ),
                        const Text(
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
    );
  }
}
