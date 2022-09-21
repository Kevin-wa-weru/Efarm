import 'package:eshamba/workhours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'dart:async';

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  String googleApikey = "AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0";
  String startLocation = "Search Location";

  late GoogleMapController _controller;

  LatLng selectedLocation = const LatLng(0, 0);

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WorkingHours()));
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
                  'Pin your Saloon Location on Map to continue',
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
                        apiHeaders: await const GoogleApiHeaders().getHeaders(),
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
                      _controller.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(target: newlatlang, zoom: 17)));
                    }
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
