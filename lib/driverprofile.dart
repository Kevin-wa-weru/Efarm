import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  bool istoggled = false;
  final _streetnocontroller = TextEditingController();
  final _contactController = TextEditingController();
  final _passwirdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          child: ListView(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.033251231,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.083251231,
                    backgroundImage:
                        const AssetImage('assets/images/woman.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 150,
                          child: Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                          child: Text(
                            'oliviathomson573',
                            style: TextStyle(
                                color: Color(0xFF39B54A),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              'Active Status',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CupertinoSwitch(
                                onChanged: (value) {
                                  setState(() {
                                    istoggled = !istoggled;
                                  });
                                },
                                value: istoggled,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Open",
                                  style: TextStyle(
                                      color: Color(0xFF39B54A),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8933333,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.2),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.0147783251,
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    filled: true,
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _streetnocontroller,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8933333,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.2),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.0147783251,
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    filled: true,
                    hintText: 'Contact',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _contactController,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8933333,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.2),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.0147783251,
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _passwirdController,
                  obscureText: true,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                child: Text(
                  "Earnings",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Card(
                            elevation: 2,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.185961,
                              width: MediaQuery.of(context).size.width * 0.408,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10.0),
                                    child: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            'Earning',
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontFamily: 'PublicSans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 7.0, left: 10.0),
                                    child: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            '1.85 kd',
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontFamily: 'PublicSans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 3.0, left: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.185961,
                            width: MediaQuery.of(context).size.width * 0.408,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Weekly Earnings',
                                          style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontFamily: 'PublicSans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 7.0, left: 10.0),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          '5.89 kd',
                                          style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontFamily: 'PublicSans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 3.0, left: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.185961,
                            width: MediaQuery.of(context).size.width * 0.408,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Monthly Earnings',
                                          style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontFamily: 'PublicSans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 7.0, left: 10.0),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontFamily: 'PublicSans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 3.0, left: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.185961,
                          width: MediaQuery.of(context).size.width * 0.408,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10.0),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        'Yearly Earnings',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 7.0, left: 10.0),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
