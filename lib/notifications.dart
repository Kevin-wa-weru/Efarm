import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.053333333,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 60,
                width: 60,
                color: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            const Text(
              'Notifications',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(AuthenticationHelper().userid.trim())
                      .collection('notifications')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.3275862,
                                  width: MediaQuery.of(context).size.width *
                                      0.70933,
                                  color: Colors.transparent,
                                  child: Image.asset(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3275862,
                                      width: MediaQuery.of(context).size.width *
                                          0.70933,
                                      'assets/images/Notify.gif'),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    'It is empty here',
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleNotification(
                                body: snapshot.data.docs[index]['body'],
                                date: DateTime.parse(snapshot
                                    .data.docs[index]['date']
                                    .toDate()
                                    .toString()),
                                title: snapshot.data.docs[index]['title'],
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class SingleNotification extends StatefulWidget {
  const SingleNotification({
    Key? key,
    required this.title,
    required this.body,
    required this.date,
  }) : super(key: key);
  final String title;
  final String body;
  final DateTime date;

  @override
  State<SingleNotification> createState() => _SingleNotificationState();
}

class _SingleNotificationState extends State<SingleNotification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11266009,
        width: MediaQuery.of(context).size.width * 0.8933333,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xFFF4F4F4),
        ),
        child: Column(
          children: [
            (DateTime.now().difference(widget.date).inDays >= 1)
                ? Container(
                    height: 10,
                  )
                : Transform.translate(
                    offset: const Offset(0.0, -10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: const Color(0xFF39B54A),
                              border: Border.all(
                                color: const Color(0xFF202020),
                                width: 2,
                              )),
                        )
                      ],
                    ),
                  ),
            Transform.translate(
              offset: const Offset(0.0, -5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 0),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 10),
                    child: Text(
                      '${widget.date.hour}:${widget.date.minute} ${widget.date.hour > 12 ? 'am' : 'pm'}',
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 4),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6933333,
                    child: Text(
                      widget.body,
                      style: const TextStyle(
                          color: Color(0xFF545454),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
