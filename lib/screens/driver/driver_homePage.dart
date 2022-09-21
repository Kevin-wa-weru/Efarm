import 'package:eshamba/chat.dart';
import 'package:eshamba/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int currentIndex = 0;
  Widget resolveAppBarTitle(currentpage) {
    if (currentpage == 0) {
      return const Text(
        'Delivery Requests',
        style: TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w600,
            fontSize: 18),
      );
    }
    if (currentpage == 1) {
      return Container();
    }

    if (currentpage == 2) {
      return const Text(
        'Past Orders',
        style: TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w600,
            fontSize: 18),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color(0xFF3EA334),
        showUnselectedLabels: true,
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '',
            backgroundColor: Colors.white,
            icon: currentIndex == 0
                ? Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/home.svg',
                            color: const Color(0xFF3EA334),
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  )
                : Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/home.svg',
                            color: const Color(0xFF3EA334),
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: currentIndex == 2
                ? Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/chat.svg',
                            color: const Color(0xFF3EA334),
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  )
                : Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/chat.svg',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: currentIndex == 4
                ? Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/network.svg',
                            color: const Color(0xFF3EA334),
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  )
                : Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/network.svg',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: resolveAppBarTitle(currentIndex),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/images/woman.jpg'),
              ),
            ),
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: cateogry
                            .map((e) => const SingleDeliveryRequest())
                            .toList(),
                      )
                    ],
                  )
                ],
              ),
              const Chat(),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                      children: cateogry
                          .map((e) => const SinglePastOrderForDriver())
                          .toList()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleDeliveryRequest extends StatelessWidget {
  const SingleDeliveryRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
        child: Card(
          elevation: 6,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3719211822,
            width: MediaQuery.of(context).size.width * 0.89333333333,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
                        width: MediaQuery.of(context).size.width * 0.0330133,
                        child: SvgPicture.asset('assets/icons/location.svg',
                            fit: BoxFit.contain),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Juja, Kikuyu',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.5730133,
                        color: Colors.transparent,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '\$90/day',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
                        width: MediaQuery.of(context).size.width * 0.0330133,
                        child: SvgPicture.asset('assets/icons/calendar.svg',
                            fit: BoxFit.contain),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          '16/02/2022',
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
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03987684,
                        width: MediaQuery.of(context).size.width * 0.0593333333,
                        child: SvgPicture.asset('assets/icons/truck.svg',
                            fit: BoxFit.contain),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          '22Vehicle',
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05172413793,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.850666666,
                  height: MediaQuery.of(context).size.height * 0.068965517,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFEFFFF1),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Color(0xFFEFFFF1),
                            Color(0xFFF8F8F8),
                          ])),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 12, bottom: 12, right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/woman.jpg'),
                        ),
                      ),
                      const Text(
                        'Wade Warren',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.30666666,
                        height: MediaQuery.of(context).size.height * 0.02987684,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.02987684,
                            width: MediaQuery.of(context).size.width *
                                0.0693333333,
                            child: SvgPicture.asset('assets/icons/text.svg',
                                fit: BoxFit.contain),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05665024,
                        width: MediaQuery.of(context).size.width * 0.312,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [
                                  Color(0xFFFF9595),
                                  Color(0xFFFF9595),
                                ])),
                        child: const Center(
                          child: Text(
                            'Decline',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05665024,
                        width: MediaQuery.of(context).size.width * 0.312,
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
                            'Accept',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SinglePastOrderForDriver extends StatelessWidget {
  const SinglePastOrderForDriver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
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
      ),
    );
  }
}
