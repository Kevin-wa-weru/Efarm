import 'package:eshamba/models/data.dart';
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
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.168,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.073251,
                ),
                Column(
                  children:
                      cateogry.map((e) => const SingleNotification()).toList(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleNotification extends StatelessWidget {
  const SingleNotification({
    Key? key,
  }) : super(key: key);

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
            Transform.translate(
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
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 0),
                    child: Text(
                      'New video was uploaded',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.0, top: 10),
                    child: Text(
                      '12:00 am',
                      style: TextStyle(
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
                    child: const Text(
                      'Lorem ipsum dolor sit amet, consectetur dipiscing elit. Ornare sapien, et elit, ornare amet... See more ',
                      style: TextStyle(
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
