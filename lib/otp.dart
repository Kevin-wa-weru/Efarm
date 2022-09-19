import 'package:eshamba/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
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
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.053333333,
                ),
                const Text(
                  'Forgot Password',
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
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  const Text(
                    'Enter the four digit code for the verification process, ',
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
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  const Text(
                    'We have sent a four digit code to your email ',
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
            OtpTextField(
              numberOfFields: 4,
              fillColor: const Color(0xFFEFEFEF),
              borderColor: Colors.transparent,

              hasCustomInputDecoration: true,
              fieldWidth: MediaQuery.of(context).size.width * 0.16266666,
              decoration: InputDecoration(
                counterText: '',
                isDense: true,
                fillColor: const Color(0xFFEFEFEF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(70),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.2),
                  borderRadius: BorderRadius.circular(70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 2),
                  borderRadius: BorderRadius.circular(70),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical:
                      MediaQuery.of(context).size.height * 0.0301231527093596,
                ),
                filled: true,
              ),

              showFieldAsBox: true,

              onCodeChanged: (String code) {},

              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.051724137,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResetPassword()));
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
                    'Continue',
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
