import 'package:eshamba/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Farmdetails extends StatefulWidget {
  const Farmdetails({super.key});

  @override
  State<Farmdetails> createState() => _FarmdetailsState();
}

class _FarmdetailsState extends State<Farmdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark
                .copyWith(statusBarColor: Colors.transparent),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.073891625,
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
                  const Text(
                    'Farm',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01860837,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.88,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cateogry.length,
                    itemBuilder: (BuildContext context, int index) {
                      return const SingleTopProduct();
                    },
                  ),
                ),
              ),
            ])));
  }
}

class SingleTopProduct extends StatelessWidget {
  const SingleTopProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
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
              height: MediaQuery.of(context).size.height * 0.277093596,
              width: MediaQuery.of(context).size.width * 0.893333333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.164433497,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Image.asset('assets/images/veges.jpg')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/woman.jpg'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Ali Hassan',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w300,
                                fontSize: 9.16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, left: 50.0),
                            child: Row(
                              children: const [
                                Text(
                                  'Vegatable',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 6.0, left: 27.0),
                            child: Row(
                              children: const [
                                Text(
                                  '\$8.90',
                                  style: TextStyle(
                                      color: Color(0xFF39B54A),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0.0, bottom: 0.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.046798,
                          width: MediaQuery.of(context).size.width *
                              0.258666666666,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF7CD956),
                                    Color(0xFF3EA334),
                                  ])),
                          child: const Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
