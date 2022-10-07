import 'package:eshamba/orders.dart';
import 'package:eshamba/privacy_policy.dart';
import 'package:eshamba/terms_and_conditions.dart';
import 'package:eshamba/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget {
  const Settings(
      {Key? key,
      required this.email,
      required this.password,
      required this.name})
      : super(key: key);
  final String email;
  final String password;
  final String name;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05970443,
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
                  width: MediaQuery.of(context).size.width * 0.268,
                ),
                const Text(
                  'Settings',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05970443,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfile(
                                  email: widget.email,
                                  name: widget.name,
                                  password: widget.password,
                                )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06773399,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0657142,
                          width: MediaQuery.of(context).size.width * 0.11733333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.020480295,
                              width: MediaQuery.of(context).size.width *
                                  0.0380266666,
                              child: SvgPicture.asset('assets/icons/edit.svg',
                                  color: const Color(0xFF39B54A),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01970443,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Orders(
                                  showbackArrow: true,
                                )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06773399,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0657142,
                          width: MediaQuery.of(context).size.width * 0.11733333,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.transparent),
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.020480295,
                              width: MediaQuery.of(context).size.width *
                                  0.0380266666,
                              child: SvgPicture.asset('assets/icons/order.svg',
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'My Order',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01970443,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsCondition()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06773399,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0657142,
                          width: MediaQuery.of(context).size.width * 0.11733333,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.transparent),
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.020480295,
                              width: MediaQuery.of(context).size.width *
                                  0.0380266666,
                              child: SvgPicture.asset('assets/icons/terms.svg',
                                  color: const Color(0xFF39B54A),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Terms & Conditions',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01970443,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06773399,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0657142,
                          width: MediaQuery.of(context).size.width * 0.11733333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.020480295,
                              width: MediaQuery.of(context).size.width *
                                  0.0380266666,
                              child: SvgPicture.asset(
                                  'assets/icons/privacy.svg',
                                  color: const Color(0xFF39B54A),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        )
                      ],
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
