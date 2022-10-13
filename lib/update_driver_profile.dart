import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/search_location.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as locater;

class UpdateDriverProfile extends StatefulWidget {
  const UpdateDriverProfile(
      {Key? key,
      required this.email,
      required this.password,
      required this.name,
      required this.location,
      required this.phone})
      : super(key: key);
  final String email;
  final String password;
  final String name;
  final String location;
  final String phone;
  @override
  State<UpdateDriverProfile> createState() => _UpdateDriverProfileState();
}

class _UpdateDriverProfileState extends State<UpdateDriverProfile> {
  var firstnameController = TextEditingController();
  var secondnameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedfile;
  bool appisLoading = false;
  String startLocation = "Search your location";
  LatLng selectedLocation = const LatLng(0, 0);

  File? fileTodisplay;
  late locater.PermissionStatus _permissionGranted;
  locater.LocationData? userLocation;
  late bool _serviceEnabled;

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

  Future<void> navigateAndDisplaySelection(
      BuildContext context, String where) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchLocation(),
        ));

    if (!mounted) return;

    if (result == 'mylocation') {
      await getAddressFromLocation();
    } else {
      setState(() {
        startLocation = result;
      });
      getLocationFromAdress(
        result,
      );
    }
  }

  Future getLocationFromAdress(
    address,
  ) async {
    var googleGeocoding =
        GoogleGeocoding("AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0");
    var result = await googleGeocoding.geocoding.get(address, []);

    setState(() {
      selectedLocation = LatLng(
          (result!.results!.first.geometry!.location!.lat)!.toDouble(),
          (result.results!.first.geometry!.location!.lng)!.toDouble());
    });
  }

  Future getAddressFromLocation() async {
    var googleGeocoding =
        GoogleGeocoding("AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0");
    var addresses = await googleGeocoding.geocoding.getReverse(LatLon(
      userLocation!.latitude!.toDouble(),
      userLocation!.longitude!.toDouble(),
    ));
    setState(() {
      startLocation = addresses!
          .results!.first.addressComponents!.first.longName
          .toString();
    });
  }

  Future<void> getUserLocation() async {
    locater.Location location = locater.Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == locater.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != locater.PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      userLocation = locationData;
    });
  }

  @override
  void initState() {
    setState(() {
      startLocation = widget.location;
      passwordController = TextEditingController(text: widget.password);
      phoneController = TextEditingController(text: widget.phone);
      firstnameController = TextEditingController(text: widget.name);
    });
    getUserLocation();

    super.initState();
  }

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
              width: MediaQuery.of(context).size.width * 0.22,
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40, bottom: 20),
        child: InkWell(
          onTap: () async {
            if (firstnameController.text.isEmpty ||
                secondnameController.text.isEmpty ||
                passwordController.text.isEmpty ||
                phoneController.text.isEmpty) {
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
                'phone': phoneController.text,
                'name':
                    '${firstnameController.text} ${secondnameController.text}',
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

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.0615763,
            width: MediaQuery.of(context).size.width * 0.8033333,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient:
                    const LinearGradient(begin: Alignment.topCenter, colors: [
                  Color(0xFF7CD956),
                  Color(0xFF3EA334),
                ])),
            child: Center(
                child: appisLoading == false
                    ? const Text(
                        'Save',
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.00251,
                ),
                InkWell(
                  onTap: () async {
                    final picker = ImagePicker();
                    var pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedImage == null) {
                    } else {
                      var tempImage = File(pickedImage.path);

                      FirebaseStorage firebaseStorage =
                          FirebaseStorage.instance;

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
                        height: MediaQuery.of(context).size.height *
                            0.1331527093596059,
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
                                    isEqualTo:
                                        AuthenticationHelper().userid.trim())
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFFF4F4F4),
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.20,
                                      backgroundImage: NetworkImage(snapshot
                                          .data.docs.first['avatarUrl']),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0472413793,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                      'Change Image',
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
                        hintText: 'First Name',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: firstnameController,
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
                        hintText: 'Last Name',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: secondnameController,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0.0, 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: InkWell(
                      onTap: () async {
                        navigateAndDisplaySelection(context, 'start');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0591133,
                        width: MediaQuery.of(context).size.width * 0.8933333,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xFFF4F4F4),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width *
                                  0.700666666,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  startLocation,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03448275,
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
                      keyboardType: TextInputType.phone,
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
                        hintText: 'Phone Number',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: phoneController,
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
                                  right: MediaQuery.of(context).size.width *
                                      0.05872),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0159729064,
                                width: MediaQuery.of(context).size.width *
                                    0.034586666,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
