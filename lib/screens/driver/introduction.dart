import 'package:eshamba/models/days.dart';
import 'package:eshamba/screens/driver/driver_homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class DriverProfileadd extends StatefulWidget {
  const DriverProfileadd({super.key});

  @override
  State<DriverProfileadd> createState() => _DriverProfileaddState();
}

class _DriverProfileaddState extends State<DriverProfileadd> {
  bool istoggled = false;
  final _streetnocontroller = TextEditingController();
  final _contactController = TextEditingController();

  String googleApikey = "AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0";
  String startLocation = "Search your location";

  LatLng selectedLocation = const LatLng(0, 0);

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  late GoogleMapController _controller;

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != TimeOfDay.now()) {
      return timeOfDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 40, right: 40),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DriverHomePage()));
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
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 14, right: 14.0, bottom: 14.0, left: 0.5),
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
                      var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'np')],
                          //google_map_webservice package
                          onError: (err) {
                            print(err);
                          });

                      if (place != null) {
                        setState(() {
                          startLocation = place.description.toString();
                        });

                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);
                        setState(() {
                          selectedLocation = newlatlang;
                        });

                        //move map camera to selected place with animation
                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: newlatlang, zoom: 17)));
                      }
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
                        mapType: MapType.normal,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(23.44, 23.0),
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
                Column(
                    children: allDayes
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.only(left: 35.0, bottom: 6),
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width *
                                      0.12467,
                                  child: Text(e.dayname,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'PublicSans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.19467,
                                  color: Colors.transparent,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Transform.scale(
                                      scale: 0.7,
                                      child: CupertinoSwitch(
                                        onChanged: (value) {
                                          setState(() {
                                            e.active = !e.active;
                                          });
                                        },
                                        value: e.active,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.010492610,
                                ),
                                InkWell(
                                  onTap: () {
                                    selectTime(context);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xFFEFEFEF),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.050492610,
                                      width: MediaQuery.of(context).size.width *
                                          0.2133333333,
                                      child: Center(
                                        child: Text(e.openTime,
                                            style: const TextStyle(
                                                color: Color(0xFFFF0000),
                                                fontFamily: 'PublicSans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                      )),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0500666,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xFFEFEFEF),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.050492610,
                                    width: MediaQuery.of(context).size.width *
                                        0.2133333333,
                                    child: Center(
                                      child: Text(e.closeTime,
                                          style: const TextStyle(
                                              color: Color(0xFFFF0000),
                                              fontFamily: 'PublicSans',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                    )),
                              ],
                            ),
                          ),
                        )
                        .toList())
              ]),
            ],
          ),
        ));
  }
}
