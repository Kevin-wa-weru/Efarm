import 'dart:async';

import 'package:eshamba/homepage.dart';
import 'package:eshamba/reset_password.dart';
import 'package:eshamba/screens/driver/introduction.dart';
import 'package:eshamba/vendor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key, required this.userType}) : super(key: key);
  final String userType;
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    } else {}
  }

  sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      await user.sendEmailVerification();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0268719,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.168,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02068719,
            ),
            Center(
              child: SizedBox(
                child: Image.asset(
                    height: MediaQuery.of(context).size.height * 0.092364,
                    width: MediaQuery.of(context).size.width * 0.2,
                    'assets/images/logo.png'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04064039408867,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Verify Email',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Proceed to your email inbox to verify your email ',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'We have sent a verifying link to your email ',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.060344827,
            ),
            isEmailVerified == false
                ? Container()
                : InkWell(
                    onTap: () async {
                      if (widget.userType == 'user') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('stringValue', "user");
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }

                      if (widget.userType == 'Vendor') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('stringValue', "Vendor");
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Vendor()));
                      }

                      if (widget.userType == 'driver') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('stringValue', "driver");
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DriverProfileadd()));
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.0615763,
                      width: MediaQuery.of(context).size.width * 0.8933333,
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
                          'Email verified : Continue',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
          ],
        )),
      ),
    );
  }
}
