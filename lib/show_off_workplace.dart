import 'package:dotted_border/dotted_border.dart';
import 'package:eshamba/show_off_workplace_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowWorkPlaceOne extends StatefulWidget {
  const ShowWorkPlaceOne({Key? key}) : super(key: key);

  @override
  State<ShowWorkPlaceOne> createState() => _ShowWorkPlaceOneState();
}

class _ShowWorkPlaceOneState extends State<ShowWorkPlaceOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShowWorkPlaceTwo()));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
          child: Container(
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
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0911330049,
          ),
          const Center(
            child: Text(
              'Show off your  workplace',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0911330049,
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Show off your  workplace',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6911330049,
                  color: Colors.transparent,
                  child: const Text(
                    'This photo will be displayed on your shop profile when clients look for you on Eshamba',
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0911330049,
          ),
          DottedBorder(
            color: const Color(0xFF39B54A),
            strokeWidth: 1,
            dashPattern: const [10, 6],
            child: Container(
                width: MediaQuery.of(context).size.width * 0.873333333,
                height: MediaQuery.of(context).size.height * 0.23029556,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03939655,
                        width: MediaQuery.of(context).size.width * 0.0730133,
                        child: SvgPicture.asset('assets/icons/camera.svg',
                            color: Colors.black12, fit: BoxFit.contain),
                      ),
                      const Text(
                        'Add workspace photo',
                        style: TextStyle(
                            color: Colors.black12,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
