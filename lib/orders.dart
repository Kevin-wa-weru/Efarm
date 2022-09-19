import 'package:eshamba/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String selectedOrder = 'current';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Center(
              child: Text(
                'Current Orders',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height:
                      MediaQuery.of(context).size.height * 0.0874384236453202,
                  width: MediaQuery.of(context).size.width * 0.89333333,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFFBFBFB),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedOrder = 'current';
                          });
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.057881773,
                          width: MediaQuery.of(context).size.width * 0.37866666,
                          decoration: selectedOrder == 'current'
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      colors: [
                                        Color(0xFF7CD956),
                                        Color(0xFF3EA334),
                                      ]))
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(62),
                                  color: const Color(0xFFFBFBFB),
                                  border: Border.all(
                                      color: Colors.black12, width: 2)),
                          child: Center(
                              child: Text(
                            'Current Orders',
                            style: TextStyle(
                                color: selectedOrder == 'current'
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF888888),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedOrder = 'past';
                          });
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.057881773,
                          width: MediaQuery.of(context).size.width * 0.37866666,
                          decoration: selectedOrder == 'past'
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      colors: [
                                        Color(0xFF7CD956),
                                        Color(0xFF3EA334),
                                      ]))
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(62),
                                  color: const Color(0xFFFBFBFB),
                                  border: Border.all(
                                      color: Colors.black12, width: 2)),
                          child: Center(
                            child: Text(
                              'Past Orders',
                              style: TextStyle(
                                  color: selectedOrder == 'past'
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFF888888),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.029556650,
                ),
                selectedOrder == 'current'
                    ? Column(
                        children: cateogry
                            .map(
                              (e) => const SingleCurrentOrder(),
                            )
                            .toList())
                    : Column(
                        children: cateogry
                            .map(
                              (e) => const SinglePastOrder(),
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

class SinglePastOrder extends StatelessWidget {
  const SinglePastOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.167487684,
        width: MediaQuery.of(context).size.width * 0.893333333,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFFBFBFB),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'ORDER ID #125288767',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 11.0),
                    child: Text(
                      '\$347.00',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Total Items: 2',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 11.0),
                    child: Row(
                      children: const [
                        Text(
                          'View',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0283251,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0418719,
                    width: MediaQuery.of(context).size.width * 0.23466666,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Color(0xFF7CD956),
                              Color(0xFF3EA334),
                            ])),
                    child: const Center(
                      child: Text(
                        'Complete',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleCurrentOrder extends StatelessWidget {
  const SingleCurrentOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.167487684,
        width: MediaQuery.of(context).size.width * 0.893333333,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFFBFBFB),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'ORDER ID #125288767',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 11.0),
                    child: Text(
                      '\$347.00',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Total Items: 2',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 11.0),
                    child: Row(
                      children: const [
                        Text(
                          'View',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0283251,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0418719,
                    width: MediaQuery.of(context).size.width * 0.23466666,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFFFE9D2C)),
                    child: const Center(
                      child: Text(
                        'Complete',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
