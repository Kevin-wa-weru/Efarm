import 'package:eshamba/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordOneController = TextEditingController();
  final passwordTwoController = TextEditingController();

  bool obsecurePasswordOne = true;
  bool obsecurePasswordTwo = true;

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
                  'Reset new password ',
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
                    'Enter your new password',
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
                  obscureText: obsecurePasswordOne,
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.name,
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
                        child: SvgPicture.asset('assets/icons/password.svg',
                            color: const Color(0xFF39B54A),
                            fit: BoxFit.contain),
                      ),
                    ),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          obsecurePasswordOne = !obsecurePasswordOne;
                        });
                      },
                      child: Transform.translate(
                        offset: const Offset(0.0, 2.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 0.05872),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.0159729064,
                            width:
                                MediaQuery.of(context).size.width * 0.034586666,
                            child: SvgPicture.asset('assets/icons/eye.svg',
                                color: obsecurePasswordOne == false
                                    ? const Color(0xFF39B54A)
                                    : Colors.black,
                                fit: BoxFit.contain),
                          ),
                        ),
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
                  controller: passwordOneController,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0.0, -15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9633333,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    obscureText: obsecurePasswordTwo,
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: const Color(0xFFEFEFEF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0.2),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical:
                            MediaQuery.of(context).size.height * 0.0197339,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.0147783251,
                          width: MediaQuery.of(context).size.width * 0.04,
                          child: SvgPicture.asset('assets/icons/password.svg',
                              color: const Color(0xFF39B54A),
                              fit: BoxFit.contain),
                        ),
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            obsecurePasswordTwo = !obsecurePasswordTwo;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 0.05872),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.0159729064,
                            width:
                                MediaQuery.of(context).size.width * 0.034586666,
                            child: SvgPicture.asset('assets/icons/eye.svg',
                                color: obsecurePasswordTwo == false
                                    ? const Color(0xFF39B54A)
                                    : Colors.black,
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      filled: true,
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: passwordTwoController,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.051724137,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
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
                    'Reset',
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
