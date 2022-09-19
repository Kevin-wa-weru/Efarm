import 'package:eshamba/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Cart',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03300492,
            ),
            Expanded(
                child: ListView(
              children: [
                Column(
                  children: cateogry.map((e) => const CartItem()).toList(),
                )
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ResetPassword()));
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
                        'Continue : Total \$8.90',
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
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Radio(
              activeColor: const Color(0xFF3EA334),
              value: "accepts",
              groupValue: "group value",
              onChanged: (value) {}),
          Container(
            height: MediaQuery.of(context).size.height * 0.152709,
            width: MediaQuery.of(context).size.width * 0.8533333,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(
                  color: const Color(0xFFBBBBBB),
                  width: 1,
                )),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.139162561,
                    width: MediaQuery.of(context).size.width * 0.29866666,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(80.0),
                            topRight: Radius.circular(80.0),
                            bottomLeft: Radius.circular(80.0),
                            bottomRight: Radius.circular(80.0),
                          ),
                          child: Image.asset('assets/images/veges.jpg')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.394666666,
                        color: Colors.transparent,
                        child: const Text(
                          'Farm Name goes here',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * 0.394666666,
                          color: Colors.transparent,
                          child: const Text(
                            '\$90',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.394666666,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 15),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.041871,
                                width:
                                    MediaQuery.of(context).size.width * 0.22933,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xFFBBBBBB),
                                      width: 1,
                                    )),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                      const Text(
                                        '1',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(30.0, 5.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.041871921,
                                width: MediaQuery.of(context).size.width *
                                    0.090666666,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: const Color(0xFFFF4646),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.024938,
                                    width: MediaQuery.of(context).size.width *
                                        0.04933333,
                                    child: SvgPicture.asset(
                                        'assets/icons/delete.svg',
                                        color: Colors.white,
                                        fit: BoxFit.fitHeight),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
