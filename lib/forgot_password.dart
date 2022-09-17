import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

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
                )
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
                    'Enter your email for the verification process, ',
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
                    'We will send a four digit code to your email ',
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9633333,
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
                        child: SvgPicture.asset('assets/icons/email.svg',
                            color: const Color(0xFF39B54A),
                            fit: BoxFit.contain),
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
                  controller: emailController,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.051724137,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.0615763,
              width: MediaQuery.of(context).size.width * 0.8933333,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient:
                      const LinearGradient(begin: Alignment.topCenter, colors: [
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
          ],
        )),
      ),
    );
  }
}
