import 'package:eshamba/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordOneController = TextEditingController();
  final passwordTwoController = TextEditingController();

  bool obsecurePasswordOne = true;
  bool obsecurePasswordTwo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
            child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0537438,
                    ),
                    Center(
                      child: SizedBox(
                        child: Image.asset(
                            height:
                                MediaQuery.of(context).size.height * 0.092364,
                            width: MediaQuery.of(context).size.width * 0.2,
                            'assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height * 0.04064039408867,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width * 0.053333333,
                        ),
                        const Text(
                          'Sign Up',
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
                            width:
                                MediaQuery.of(context).size.width * 0.053333333,
                          ),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.060344827,
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
                              vertical: MediaQuery.of(context).size.height *
                                  0.0197339,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14,
                                  right: 14.0,
                                  bottom: 14.0,
                                  left: 24.5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.02193349,
                                width: MediaQuery.of(context).size.width * 0.04,
                                child: SvgPicture.asset(
                                    'assets/icons/person.svg',
                                    color: const Color(0xFF39B54A),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            filled: true,
                            hintText: 'Name',
                            hintStyle: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: nameController,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -15.0),
                      child: SizedBox(
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
                                vertical: MediaQuery.of(context).size.height *
                                    0.0197339,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 14,
                                    right: 14.0,
                                    bottom: 14.0,
                                    left: 24.5),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.0147783251,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                  child: SvgPicture.asset(
                                      'assets/icons/email.svg',
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
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -30.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8933333,
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
                                vertical: MediaQuery.of(context).size.height *
                                    0.0197339,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 14,
                                    right: 14.0,
                                    bottom: 14.0,
                                    left: 24.5),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.0147783251,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                  child: SvgPicture.asset(
                                      'assets/icons/password.svg',
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
                                            MediaQuery.of(context).size.width *
                                                0.05872),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.0159729064,
                                      width: MediaQuery.of(context).size.width *
                                          0.034586666,
                                      child: SvgPicture.asset(
                                          'assets/icons/eye.svg',
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
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -45.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8933333,
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
                                vertical: MediaQuery.of(context).size.height *
                                    0.0197339,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 14,
                                    right: 14.0,
                                    bottom: 14.0,
                                    left: 24.5),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.0147783251,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                  child: SvgPicture.asset(
                                      'assets/icons/password.svg',
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
                                      right: MediaQuery.of(context).size.width *
                                          0.05872),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0159729064,
                                    width: MediaQuery.of(context).size.width *
                                        0.034586666,
                                    child: SvgPicture.asset(
                                        'assets/icons/eye.svg',
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
                    Transform.translate(
                      offset: const Offset(0.0, -60.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0615763,
                        width: MediaQuery.of(context).size.width * 0.41066666,
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
                            'Sign Up',
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).size.height * 0.085714285),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 20,
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Color(0xFF39B54A),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height *
                              0.055467980295567,
                          left: MediaQuery.of(context).size.height * 0.07376),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05995073,
                        width: MediaQuery.of(context).size.width * 0.1298133,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFFD3EFD7),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height *
                              0.125467980295567,
                          left: MediaQuery.of(context).size.height * 0.12376),
                      child: Container(
                        height:
                            MediaQuery.of(context).size.height * 0.0839408866,
                        width: MediaQuery.of(context).size.width * 0.18176,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFFD3EFD7),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height *
                            0.165467980295567,
                      ),
                      child: Transform.translate(
                        offset: const Offset(-30.0, 0.0),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0839408866,
                          width: MediaQuery.of(context).size.width * 0.18176,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFFD3EFD7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
