import 'package:eshamba/quick_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailedFarm extends StatefulWidget {
  const DetailedFarm({Key? key, required this.farm}) : super(key: key);
  final Map<String, dynamic> farm;
  @override
  State<DetailedFarm> createState() => _DetailedFarmState();
}

class _DetailedFarmState extends State<DetailedFarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
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
                  width: MediaQuery.of(context).size.width * 0.268,
                ),
                const Text(
                  'Farm Details',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                child: Card(
                  elevation: 2,
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.4178325,
                    width: MediaQuery.of(context).size.width * 0.89333333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.2426108,
                          width: MediaQuery.of(context).size.width * 0.89333333,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.network(widget.farm['link']),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0, left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.farm['name'],
                                style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 15.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QuickChatDetails(
                                                  name: widget
                                                      .farm['postedByName'],
                                                  userID:
                                                      widget.farm['postedById'],
                                                  avatarUrl: widget.farm[
                                                      'postedByAvatarUrl'],
                                                )));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.028460591,
                                    width: MediaQuery.of(context).size.width *
                                        0.15733333,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF7CD956),
                                              Color(0xFF3EA334),
                                            ])),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Chat',
                                            style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontFamily: 'PublicSans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 2),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.030480295,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02432266,
                                              child: SvgPicture.asset(
                                                  'assets/icons/chat2.svg',
                                                  fit: BoxFit.contain),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.01939655,
                                width: MediaQuery.of(context).size.width *
                                    0.0330133,
                                child: SvgPicture.asset(
                                    'assets/icons/location.svg',
                                    fit: BoxFit.contain),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  widget.farm['location'],
                                  style: const TextStyle(
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
                          padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.01939655,
                                width: MediaQuery.of(context).size.width *
                                    0.0330133,
                                child: SvgPicture.asset(
                                    'assets/icons/clock.svg',
                                    fit: BoxFit.contain),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Available: ${widget.farm['time']}',
                                  style: const TextStyle(
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
                                padding: const EdgeInsets.only(
                                    left: 4.0, bottom: 15),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.79333333,
                                  child: Text(
                                    widget.farm['description'],
                                    style: const TextStyle(
                                        color: Color(0xFF707070),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Center(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/woman.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 0.682666666,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'William David',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.019704433,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.042666666,
                                        child: SvgPicture.asset(
                                            'assets/icons/star2.svg',
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '4.5',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 0.682666666,
                            // color: Colors.re/d,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20.0, top: 5),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.482666666,
                                    child: const Text(
                                      '10 May 2021 04:30 PM',
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontFamily: 'PublicSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, top: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.728,
                          child: const Text(
                            'Lorem Ipsum is simply dummy text of he printing and Lorem Ipsum is simply dummy text of he printing and Lorem Ipsum is simply dummy text of he printing and lorum.',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
