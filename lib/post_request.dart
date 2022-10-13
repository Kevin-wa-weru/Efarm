import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/requests.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class PostRequest extends StatefulWidget {
  const PostRequest({Key? key}) : super(key: key);

  @override
  State<PostRequest> createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  final jobTitleController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final numberofPersonsController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime dateTimeOne = DateTime.now();
  DateTime dateTimeTwo = DateTime.now();
  bool appisLoading = false;

  int maxLine = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.053333333,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 60,
                width: 60,
                color: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            const Text(
              'Your Address',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
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
                          vertical:
                              MediaQuery.of(context).size.height * 0.0197339,
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Job title',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: jobTitleController,
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
                      keyboardType: TextInputType.number,
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
                          vertical:
                              MediaQuery.of(context).size.height * 0.0197339,
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Price',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: priceController,
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
                          vertical:
                              MediaQuery.of(context).size.height * 0.0197339,
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Location',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: locationController,
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
                          vertical:
                              MediaQuery.of(context).size.height * 0.0197339,
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Number of persons',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: numberofPersonsController,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8933333,
                  height: maxLine * 24.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      maxLines: maxLine,
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
                          vertical:
                              MediaQuery.of(context).size.height * 0.0197339,
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: descriptionController,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03527093,
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Select Time',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
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
                          height:
                              MediaQuery.of(context).size.height * 0.06527093,
                          width:
                              MediaQuery.of(context).size.width * 0.434666666,
                          child: TimePickerSpinner(
                            is24HourMode: false,
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
                          is24HourMode: false,
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
                              dateTimeOne = time;
                            });
                          },
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03527093,
                ),
                InkWell(
                  onTap: () async {
                    if (jobTitleController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        locationController.text.isEmpty ||
                        numberofPersonsController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          "Fill all elements of the form",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                      );
                    } else {
                      setState(() {
                        appisLoading = true;
                      });
                      final docRef = FirebaseFirestore.instance
                          .collection("users")
                          .doc(AuthenticationHelper().userid.trim())
                          .collection('jobRequests');

                      await docRef.add({
                        'title': jobTitleController.text,
                        'price': priceController.text,
                        'locatiom': locationController.text,
                        'persons': numberofPersonsController.text,
                        'description': descriptionController.text,
                        'from': dateTimeOne,
                        'to': dateTimeTwo,
                        'postedbyId': AuthenticationHelper().userid.trim(),
                      });

                      setState(() {
                        appisLoading = false;
                      });

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          "Sent request",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Requests()));
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.0615763,
                      width: MediaQuery.of(context).size.width * 0.7933333,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Color(0xFF7CD956),
                                Color(0xFF3EA334),
                              ])),
                      child: appisLoading == false
                          ? const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            )
                          : const Center(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
