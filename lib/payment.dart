import 'package:eshamba/success_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Payment extends StatefulWidget {
  const Payment(
      {Key? key,
      required this.order,
      this.shippingfee,
      required this.orderNote})
      : super(key: key);
  final Map<String, dynamic> order;
  final int? shippingfee;
  final String orderNote;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String selectedPay = '';
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
                      width: MediaQuery.of(context).size.width * 0.198,
                    ),
                    const Text(
                      'Payment Methods',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedPay = 'card';
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1182266,
                    width: MediaQuery.of(context).size.width * 0.8533333,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        border: Border.all(
                          color: const Color(0xFFBBBBBB),
                          width: 1,
                        )),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPay = 'card';
                                });
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedPay == 'card'
                                        ? const Color(0xFF3EA334)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black87,
                                      width: selectedPay == 'card' ? 0.5 : 2,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.049261083,
                              width: MediaQuery.of(context).size.width *
                                  0.133333333,
                              child: SvgPicture.asset(
                                  'assets/icons/mastercard.svg',
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedPay = 'paypal';
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1182266,
                    width: MediaQuery.of(context).size.width * 0.8533333,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        border: Border.all(
                          color: const Color(0xFFBBBBBB),
                          width: 1,
                        )),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPay = 'paypal';
                                });
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedPay == 'paypal'
                                        ? const Color(0xFF3EA334)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black87,
                                      width: selectedPay == 'paypal' ? 0.5 : 2,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.249261083,
                              width: MediaQuery.of(context).size.width *
                                  0.233333333,
                              child: SvgPicture.asset('assets/icons/paypal.svg',
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4694581,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: InkWell(
                      onTap: () {
                        if (selectedPay == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                              "Pick your payment method",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuccessfulOrder(
                                        address: widget.order,
                                        shippingfee: widget.shippingfee!,
                                        ordernote: widget.orderNote,
                                      )));
                        }
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
