import 'package:eshamba/search_location.dart';
import 'package:eshamba/workhours.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:location/location.dart' as locater;

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  late locater.PermissionStatus _permissionGranted;
  locater.LocationData? userLocation;
  late bool _serviceEnabled;

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
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userLocation == null
          ? Container()
          : MapLocationStepOne(
              userLocation:
                  LatLng(userLocation!.latitude!, userLocation!.longitude!),
            ),
    );
  }
}

class MapLocationStepOne extends StatefulWidget {
  const MapLocationStepOne({Key? key, required this.userLocation})
      : super(key: key);
  final LatLng userLocation;
  @override
  State<MapLocationStepOne> createState() => _MapLocationStepOneState();
}

class _MapLocationStepOneState extends State<MapLocationStepOne> {
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
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (startLocation == "Search your location") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                "Select your location",
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
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
              'mapAddress': {
                'address': startLocation,
                'longitude': selectedLocation.longitude.toString(),
                'latitude': selectedLocation.latitude.toString(),
              }
            });

            setState(() {
              appisLoading = false;
            });

            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WorkingHours()));
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
              'Map Location',
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
                  'Map Location',
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
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10),
                child: Text(
                  'Pin your Business Location on Map to continue',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  onTap: () async {
                    navigateAndDisplaySelection(context, 'start');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0591133,
                    width: MediaQuery.of(context).size.width * 0.7493333333,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 17),
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.0233990,
                            width:
                                MediaQuery.of(context).size.width * 0.050666666,
                            child: SvgPicture.asset('assets/icons/location.svg',
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
            ],
          ),
          const SizedBox(
            height: 32,
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
          const SizedBox(
            height: 50,
          ),
          startLocation == 'startLocation'
              ? Container()
              : Column(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Address',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.893333333,
                            child: Text(
                              startLocation,
                              style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
