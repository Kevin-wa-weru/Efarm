import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obsecurePasswordOne = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.093251,
            ),
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
                      width: MediaQuery.of(context).size.width * 0.368,
                    ),
                    const Text(
                      'Edit',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05788177,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1331527093596059,
                width: MediaQuery.of(context).size.width * 0.266666666,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150.0),
                    topRight: Radius.circular(150.0),
                    bottomLeft: Radius.circular(150.0),
                    topLeft: Radius.circular(150.0),
                  ),
                  color: Color(0xFFD9D9D9),
                ),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0472413793,
                    width: MediaQuery.of(context).size.width * 0.04866666,
                    child: SvgPicture.asset('assets/icons/camera.svg',
                        color: Colors.black, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Change Photo',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05788177,
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
                      horizontal: 20,
                    ),
                    filled: true,
                    hintText: 'Change Name',
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
                      horizontal: 20,
                    ),
                    filled: true,
                    hintText: 'Change Email',
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
                      horizontal: 20,
                    ),
                    filled: true,
                    hintText: 'Change Password',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: passwordController,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10714285,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height * 0.0615763,
                width: MediaQuery.of(context).size.width * 0.8033333,
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
        ),
      ),
    );
  }
}
