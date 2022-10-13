import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/show_off_workplace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class WorkingHours extends StatefulWidget {
  const WorkingHours({Key? key}) : super(key: key);

  @override
  State<WorkingHours> createState() => _WorkingHoursState();
}

class _WorkingHoursState extends State<WorkingHours> {
  bool istoggled = false;

  String isdata = '';
  bool appisLoading = false;
  DateTime dateTimeOne = DateTime.now();
  DateTime dateTimeTwo = DateTime.now();

  bool changedOne = false;
  bool changedTwo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (changedOne == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                "Select the opening time",
                style: TextStyle(
                  color: Colors.red,
                ),
              )),
            );
          } else if (changedTwo == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                "Select the closing time",
                style: TextStyle(
                  color: Colors.red,
                ),
              )),
            );
          } else {
            setState(() {
              appisLoading = true;
            });
            final docRef = FirebaseFirestore.instance
                .collection("users")
                .doc(AuthenticationHelper().userid.trim());

            await docRef.update({
              'workingHours': {
                'openStatus': istoggled,
                'openTime': '${dateTimeOne.hour}:${dateTimeOne.minute}',
                'closingTime': '${dateTimeTwo.hour}:${dateTimeTwo.minute}',
              }
            });

            setState(() {
              appisLoading = false;
            });
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShowWorkPlaceOne()));
          }
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
            child: appisLoading == true
                ? const Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Center(
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
      body: ListView(
        children: [
          const Center(
            child: Text(
              'Your Work Hours',
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
                  'Your Work Hours',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Set your working hours here',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.33333,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.3333333,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Open',
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    onChanged: (value) {
                                      setState(() {
                                        isdata = "!";
                                        istoggled = !istoggled;
                                      });
                                    },
                                    value: istoggled,
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
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.06527093,
                    width: MediaQuery.of(context).size.width * 0.434666666,
                    child: TimePickerSpinner(
                      is24HourMode: true,
                      normalTextStyle: const TextStyle(
                          color: Color(0xFF39B54A),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      highlightedTextStyle: const TextStyle(
                          color: Color(0xFF39B54A),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      spacing: 5,
                      itemHeight: 80,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          changedOne = true;
                          print(dateTimeOne);
                          dateTimeOne = time;
                        });
                      },
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.0001333,
              ),
              Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.06527093,
                  width: MediaQuery.of(context).size.width * 0.434666666,
                  child: TimePickerSpinner(
                    is24HourMode: true,
                    normalTextStyle: const TextStyle(
                        color: Color(0xFF39B54A),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    highlightedTextStyle: const TextStyle(
                        color: Color(0xFF39B54A),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    spacing: 5,
                    itemHeight: 80,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      print(dateTimeTwo);
                      setState(() {
                        changedTwo = true;
                        dateTimeTwo = time;
                      });
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
