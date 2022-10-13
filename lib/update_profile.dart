import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile(
      {Key? key,
      required this.email,
      required this.password,
      required this.name})
      : super(key: key);
  final String email;
  final String password;
  final String name;
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedfile;
  bool appisLoading = false;

  File? fileTodisplay;
  void pickfile() async {
    try {
      setState(() {
        appisLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'pdf', 'jpg', 'jpeg'],
        allowMultiple: false,
      );
      if (result != null) {
        fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileTodisplay = File(pickedfile!.path.toString());

        print('filename $fileName');
      }

      setState(() {
        appisLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  bool obsecurePasswordOne = true;

  @override
  void initState() {
    setState(() {
      passwordController = TextEditingController(text: widget.password);
      emailController = TextEditingController(text: widget.email);
      nameController = TextEditingController(text: widget.name);
    });

    super.initState();
  }

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
              height: MediaQuery.of(context).size.width * 0.128,
            ),
            Row(
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
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.27,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024039408,
            ),
            InkWell(
              onTap: () async {
                final picker = ImagePicker();
                var pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedImage == null) {
                } else {
                  var tempImage = File(pickedImage.path);

                  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

                  var response = await firebaseStorage
                      .ref('usersAvatar')
                      .child(
                          '${DateTime.now().microsecond.toString()}${DateTime.now().second.toString()}')
                      .putFile(tempImage);

                  final docRef = FirebaseFirestore.instance
                      .collection("users")
                      .doc(AuthenticationHelper().userid.trim());

                  await docRef.update(
                      {'avatarUrl': await response.ref.getDownloadURL()});

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                      "Updated profile picture",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                  );
                }
              },
              child: Center(
                child: Container(
                    height:
                        MediaQuery.of(context).size.height * 0.1331527093596059,
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
                    child: StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('userid',
                                isEqualTo: AuthenticationHelper().userid.trim())
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xFFF4F4F4),
                                  radius:
                                      MediaQuery.of(context).size.width * 0.20,
                                  backgroundImage: NetworkImage(
                                      snapshot.data.docs.first['avatarUrl']),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0472413793,
                                    width: MediaQuery.of(context).size.width *
                                        0.04866666,
                                    child: SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                        color: Colors.black,
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        })),
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
              onTap: () {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                      "Complete Filling The Form",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                      "Data has been updated successfully",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )),
                  );
                }
              },
              child: InkWell(
                onTap: () async {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
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
                        .doc(AuthenticationHelper().userid.trim());

                    await docRef.update({
                      'email': emailController.text,
                      'name': nameController.text,
                      'password': passwordController.text,
                    });

                    setState(() {
                      appisLoading = false;
                    });

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        "Updated profile details",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )),
                    );
                  }
                },
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
                  child: Center(
                      child: appisLoading == false
                          ? const Text(
                              'Continue',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
