import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/models/days.dart';
import 'package:eshamba/screens/driver/driver_homePage.dart';
import 'package:eshamba/search_location.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart' as locater;

class DriverProfileadd extends StatefulWidget {
  const DriverProfileadd({Key? key}) : super(key: key);

  @override
  State<DriverProfileadd> createState() => _DriverProfileaddState();
}

class _DriverProfileaddState extends State<DriverProfileadd> {
  late locater.PermissionStatus _permissionGranted;
  locater.LocationData? userLocation;
  late bool _serviceEnabled;

  updateDriverProfile() async {
    final docRef = await FirebaseFirestore.instance
        .collection("users")
        .where('userid', isEqualTo: AuthenticationHelper().userid.trim())
        .get();

    final docRef2 = FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().userid.trim())
        .collection('requests');

    docRef2.add({
      'address': '',
      'date': DateTime.now(),
      'price': '',
      'requestId': '',
      'requestby': '',
      'status': 'declined',
      'vehicles': '',
    });

    await docRef.docs.first.reference.update({
      'vehicleNos': '1',
      'charge': '45',
      'activeStatus': false,
      'phone': '',
      'earnings': '0.00',
      'weeklyEarnings': '0.00',
      'monthlyEarnings': '0.00',
      'yearlyEarnings': '0.00',
      'availability': [
        {
          'day': 'Mon',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        },
        {
          'day': 'Tue',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        },
        {
          'day': 'Wed',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        },
        {
          'day': 'Thu',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        },
        {
          'day': 'Fri',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        },
        {
          'day': 'Sat',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        },
        {
          'day': 'Sun',
          'available': false,
          'open': '00:00am',
          'close': '00:00pm'
        }
      ]
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
    updateDriverProfile();
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userLocation == null
          ? Container()
          : DriverProfileaddStepOne(
              userLocation:
                  LatLng(userLocation!.latitude!, userLocation!.longitude!),
            ),
    );
  }
}

class DriverProfileaddStepOne extends StatefulWidget {
  const DriverProfileaddStepOne({super.key, required this.userLocation});
  final LatLng userLocation;

  @override
  State<DriverProfileaddStepOne> createState() =>
      _DriverProfileaddStepOneState();
}

class _DriverProfileaddStepOneState extends State<DriverProfileaddStepOne> {
  bool istoggled = false;
  final _streetnocontroller = TextEditingController();

  String googleApikey = "AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0";
  String startLocation = "Search your location";
  List<Marker> allMarkers = [];
  LatLng selectedLocation = const LatLng(0, 0);
  late GoogleMapController _controller;
  bool appisLoading = false;
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != TimeOfDay.now()) {
      return timeOfDay;
    } else {
      return '';
    }
  }

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
      allMarkers.add(Marker(
          markerId: MarkerId(selectedLocation.latitude.toString()),
          draggable: false,
          infoWindow:
              const InfoWindow(title: 'My Location', snippet: 'My Location'),
          position:
              LatLng(selectedLocation.latitude, selectedLocation.longitude)));
    });

    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: selectedLocation, zoom: 14.0, bearing: 45.0, tilt: 45.0)));
  }

  Future getAddressFromLocation() async {
    var googleGeocoding =
        GoogleGeocoding("AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0");
    var addresses = await googleGeocoding.geocoding.getReverse(LatLon(
      widget.userLocation.latitude.toDouble(),
      widget.userLocation.longitude.toDouble(),
    ));

    setState(() {
      selectedLocation = LatLng(
        widget.userLocation.latitude.toDouble(),
        widget.userLocation.longitude.toDouble(),
      );
      startLocation = addresses!
          .results!.first.addressComponents!.first.longName
          .toString();
    });
  }

  @override
  void initState() {
    allMarkers.add(Marker(
        markerId: MarkerId(widget.userLocation.latitude.toString()),
        draggable: false,
        infoWindow:
            const InfoWindow(title: 'My Location', snippet: 'My Location'),
        position: LatLng(
            widget.userLocation.latitude, widget.userLocation.longitude)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 40, right: 40),
          child: InkWell(
            onTap: () async {
              if (_streetnocontroller.text.isEmpty) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    "Provide your vehicle type",
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  )),
                );
              } else if (selectedLocation == const LatLng(0, 0)) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    "Serach and select specific location",
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
                final docRef = await FirebaseFirestore.instance
                    .collection("users")
                    .where('userid',
                        isEqualTo: AuthenticationHelper().userid.trim())
                    .get();

                await docRef.docs.first.reference.update({
                  'vehicleType': _streetnocontroller.text,
                  'addressLocation': startLocation,
                  'latitudeLocation': selectedLocation.latitude,
                  'longitudeLocation': selectedLocation.longitude
                });
                setState(() {
                  appisLoading = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DriverHomePage()));
              }
            },
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
              child: Center(
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
                    : const Text(
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
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          child: ListView(
            children: [
              Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.023251231,
                ),
                const Center(
                  child: Text(
                    'Add Your Profile',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.033251231,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.064039408,
                  width: MediaQuery.of(context).size.width * 0.8933333333333333,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
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
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 14, right: 16.0, bottom: 14.0, left: 15),
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.0233990,
                            width:
                                MediaQuery.of(context).size.width * 0.050666666,
                            child: SvgPicture.asset('assets/icons/car.svg',
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        filled: true,
                        hintText: 'Type Of Vechile',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: _streetnocontroller,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    onTap: () async {
                      navigateAndDisplaySelection(context, 'start');
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.0591133,
                      width: MediaQuery.of(context).size.width *
                          0.8933333333333333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFF4F4F4),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 17),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.0233990,
                              width: MediaQuery.of(context).size.width *
                                  0.050666666,
                              child: SvgPicture.asset(
                                  'assets/icons/location.svg',
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width:
                                MediaQuery.of(context).size.width * 0.550666666,
                            child: Text(
                              startLocation,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black54,
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03448275,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFFAFAFA),
                    ),
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    height: MediaQuery.of(context).size.height * 0.237684729,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7.0),
                        topRight: Radius.circular(7.0),
                        bottomLeft: Radius.circular(7.0),
                        bottomRight: Radius.circular(7.0),
                      ),
                      child: GoogleMap(
                        markers: Set.from(allMarkers),
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: widget.userLocation,
                          zoom: 14.4746,
                        ),
                        onMapCreated: mapCreated,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03448275,
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("Timing",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 20),
                  child: Row(
                    children: [
                      const Text("Days",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.37467,
                      ),
                      const Text("Open",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.130666,
                      ),
                      const Text("Close",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10),
                  child: Container(
                      height: 1,
                      color: const Color(0xFFC8C8C8),
                      width: MediaQuery.of(context).size.width),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('userid',
                            isEqualTo: AuthenticationHelper().userid.trim())
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List allItems = [];
                        for (var item
                            in snapshot.data!.docs.first['availability']) {
                          allItems.add(item);
                        }
                        return Column(
                            children: snapshot.data!.docs.first['availability']
                                .map<Widget>(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0, bottom: 6),
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12467,
                                          child: Text(e['day'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'PublicSans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16)),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19467,
                                          color: Colors.transparent,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Transform.scale(
                                              scale: 0.7,
                                              child: CupertinoSwitch(
                                                onChanged: (value) async {
                                                  int index = allItems
                                                      .indexWhere((element) =>
                                                          element['day'] ==
                                                          e['day']);

                                                  allItems.removeWhere(
                                                      (element) =>
                                                          element['day'] ==
                                                          e['day']);

                                                  allItems.insert(index, {
                                                    'day': e['day'],
                                                    'available':
                                                        !e['available'],
                                                    'open': e['open'],
                                                    'close': e['close']
                                                  });

                                                  final docRef =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .where('userid',
                                                              isEqualTo:
                                                                  AuthenticationHelper()
                                                                      .userid
                                                                      .trim())
                                                          .get();

                                                  await docRef
                                                      .docs.first.reference
                                                      .update({
                                                    'availability': allItems
                                                  });
                                                },
                                                value: e['available'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.010492610,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            var response =
                                                await selectTime(context);

                                            if (response == '') {
                                            } else {
                                              int index = allItems.indexWhere(
                                                  (element) =>
                                                      element['day'] ==
                                                      e['day']);

                                              allItems.removeWhere((element) =>
                                                  element['day'] == e['day']);

                                              allItems.insert(index, {
                                                'day': e['day'],
                                                'available': e['available'],
                                                'open':
                                                    '${(response.hour.toString().length == 1) ? '0${response.hour.toString()}' : response.hour.toString()}:${(response.minute.toString().length == 1) ? '0${response.minute.toString()}' : response.minute.toString()}  ${(response.hour > 12) ? 'am' : 'pm'}',
                                                'close': e['close']
                                              });

                                              final docRef = await FirebaseFirestore
                                                  .instance
                                                  .collection("users")
                                                  .where('userid',
                                                      isEqualTo:
                                                          AuthenticationHelper()
                                                              .userid
                                                              .trim())
                                                  .get();

                                              await docRef.docs.first.reference
                                                  .update({
                                                'availability': allItems
                                              });

                                              allItems = [];
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0xFFEFEFEF),
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.050492610,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2133333333,
                                              child: Center(
                                                child: Text(e['open'],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFFF0000),
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16)),
                                              )),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0500666,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            var response =
                                                await selectTime(context);

                                            if (response == '') {
                                            } else {
                                              int index = allItems.indexWhere(
                                                  (element) =>
                                                      element['day'] ==
                                                      e['day']);

                                              allItems.removeWhere((element) =>
                                                  element['day'] == e['day']);

                                              allItems.insert(index, {
                                                'day': e['day'],
                                                'available': e['available'],
                                                'close':
                                                    '${(response.hour.toString().length == 1) ? '0${response.hour.toString()}' : response.hour.toString()}:${(response.minute.toString().length == 1) ? '0${response.minute.toString()}' : response.minute.toString()}  ${(response.hour > 12) ? 'am' : 'pm'}',
                                                'open': e['open']
                                              });

                                              final docRef = await FirebaseFirestore
                                                  .instance
                                                  .collection("users")
                                                  .where('userid',
                                                      isEqualTo:
                                                          AuthenticationHelper()
                                                              .userid
                                                              .trim())
                                                  .get();

                                              await docRef.docs.first.reference
                                                  .update({
                                                'availability': allItems
                                              });
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0xFFEFEFEF),
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.050492610,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2133333333,
                                              child: Center(
                                                child: Text(e['close'],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFFF0000),
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16)),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList());
                      } else {
                        return Container();
                      }
                    })
              ]),
            ],
          ),
        ));
  }
}
