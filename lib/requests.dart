import 'package:eshamba/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
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
                      width: MediaQuery.of(context).size.width * 0.298,
                    ),
                    const Text(
                      'Farmer',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03694581,
                ),
                Column(
                  children: cateogry
                      .map(
                        (e) => const SingleRequest(),
                      )
                      .toList(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SingleRequest extends StatelessWidget {
  const SingleRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
          bottomLeft: Radius.circular(7.0),
          bottomRight: Radius.circular(7.0),
        ),
        child: Card(
          elevation: 2,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.256157635,
            width: MediaQuery.of(context).size.width * 0.89333333,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color(0xFFFFFFFF),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020935,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Job title goes here',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0158620,
                        child: SvgPicture.asset('assets/icons/threedots.svg',
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.01939655,
                            width:
                                MediaQuery.of(context).size.width * 0.0330133,
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
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Text(
                        '\$80.17/day',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
                        width: MediaQuery.of(context).size.width * 0.0330133,
                        child: SvgPicture.asset('assets/icons/clock.svg',
                            fit: BoxFit.contain),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Available: 11:00 am to 1:30pm',
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
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          color: Colors.transparent,
                          width:
                              MediaQuery.of(context).size.width * 0.768666666,
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet neque congue molestie ac ut malesuada.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet neque congue molestie ac ut malesuada.',
                            style: TextStyle(
                                color: Color(0xFF707070),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 10.00),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    'View Request',
                    style: TextStyle(
                        color: Color(0xFF39B54A),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
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
