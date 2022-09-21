import 'package:eshamba/registration.dart';
import 'package:eshamba/screens/driver/introduction.dart';
import 'package:eshamba/vendor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  String usertype = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1767487,
            ),
            Center(
              child: SizedBox(
                child: Image.asset(
                    height: MediaQuery.of(context).size.height * 0.29310344,
                    width: MediaQuery.of(context).size.width * 0.63466666,
                    'assets/images/bglogo.png'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.059113300,
            ),
            const Text(
              'Choose your role',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07758620,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration(
                                  usertype: "user",
                                )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.172413793,
                    width: MediaQuery.of(context).size.width * 0.3733333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF39B54A),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.04926108,
                          width: MediaQuery.of(context).size.width * 0.0925333,
                          child: SvgPicture.asset('assets/icons/user.svg',
                              color: const Color(0xFFFFFFFF),
                              fit: BoxFit.fitHeight),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.020935960591133,
                        ),
                        const Text(
                          'User',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.112,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration(
                                  usertype: "Vendor",
                                )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.172413793,
                    width: MediaQuery.of(context).size.width * 0.3733333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF39B54A),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.04926108,
                          width: MediaQuery.of(context).size.width * 0.0925333,
                          child: SvgPicture.asset('assets/icons/vendor.svg',
                              fit: BoxFit.fitHeight),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.020935960591133,
                        ),
                        const Text(
                          'Vendor',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.036945,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Registration(
                              usertype: "driver",
                            )));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.0677339,
                width: MediaQuery.of(context).size.width * 0.856,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF39B54A),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04266666,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03179802,
                      width: MediaQuery.of(context).size.width * 0.064,
                      child: SvgPicture.asset('assets/icons/driver.svg',
                          color: Colors.white, fit: BoxFit.fitHeight),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Driver',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
