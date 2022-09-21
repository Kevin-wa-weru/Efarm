import 'package:eshamba/book_lorry_step2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class BookLorryStep1 extends StatefulWidget {
  const BookLorryStep1({Key? key}) : super(key: key);

  @override
  State<BookLorryStep1> createState() => _BookLorryStep1State();
}

class _BookLorryStep1State extends State<BookLorryStep1> {
  String googleApikey = "AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0";
  String startLocation = "Starting Point";
  String endLocation = "Where to";
  LatLng? startingPoint;
  LatLng? endPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.08374384,
        width: MediaQuery.of(context).size.width * 0.1813333333,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: Colors.transparent,
            border: Border.all(
              color: const Color(0xFFBBBBBB),
              width: 1,
            )),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.0472413793,
            width: MediaQuery.of(context).size.width * 0.04866666,
            child: SvgPicture.asset('assets/icons/map.svg',
                color: Colors.black, fit: BoxFit.contain),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
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
                  width: MediaQuery.of(context).size.width * 0.268,
                ),
                const Text(
                  'Enter Location',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0581773399,
            ),
            Card(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1465517241,
                width: MediaQuery.of(context).size.width * 0.268,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: const Color(0xFFD9D9D9),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, bottom: 2),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.0541871921,
                                width: 2,
                                color: const Color(0xFFD9D9D9),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              color: const Color(0xFF000000),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0, top: 10),
                            child: InkWell(
                              onTap: () async {
                                var place = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: googleApikey,
                                    mode: Mode.overlay,
                                    types: [],
                                    strictbounds: false,
                                    components: [
                                      Component(Component.country, 'np')
                                    ],
                                    //google_map_webservice package
                                    onError: (err) {
                                      print(err);
                                    });

                                if (place != null) {
                                  setState(() {
                                    startLocation =
                                        place.description.toString();
                                  });

                                  //form google_maps_webservice package
                                  final plist = GoogleMapsPlaces(
                                    apiKey: googleApikey,
                                    apiHeaders: await const GoogleApiHeaders()
                                        .getHeaders(),
                                    //from google_api_headers package
                                  );
                                  String placeid = place.placeId ?? "0";
                                  final detail =
                                      await plist.getDetailsByPlaceId(placeid);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;
                                  var newlatlang = LatLng(lat, lang);
                                  setState(() {
                                    startingPoint = newlatlang;
                                  });

                                  //move map camera to selected place with animation
                                  // mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: const Color(0xFFFAFAFA),
                                ),
                                width: MediaQuery.of(context).size.width *
                                    0.674666666,
                                height: MediaQuery.of(context).size.height *
                                    0.044334975,
                                child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.574666666,
                                              child: Text(
                                                startLocation,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Color(0xFF000000),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0, top: 10),
                            child: InkWell(
                              onTap: () async {
                                var place = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: googleApikey,
                                    mode: Mode.overlay,
                                    types: [],
                                    strictbounds: false,
                                    components: [
                                      Component(Component.country, 'np')
                                    ],
                                    //google_map_webservice package
                                    onError: (err) {
                                      print(err);
                                    });

                                if (place != null) {
                                  setState(() {
                                    endLocation = place.description.toString();
                                  });

                                  //form google_maps_webservice package
                                  final plist = GoogleMapsPlaces(
                                    apiKey: googleApikey,
                                    apiHeaders: await const GoogleApiHeaders()
                                        .getHeaders(),
                                    //from google_api_headers package
                                  );
                                  String placeid = place.placeId ?? "0";
                                  final detail =
                                      await plist.getDetailsByPlaceId(placeid);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;
                                  var newlatlang = LatLng(lat, lang);
                                  setState(() {
                                    endPoint = newlatlang;
                                  });

                                  //move map camera to selected place with animation
                                  // mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: const Color(0xFFEEEEEE),
                                ),
                                width: MediaQuery.of(context).size.width *
                                    0.674666666,
                                height: MediaQuery.of(context).size.height *
                                    0.044334975,
                                child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Container(
                                              color: Colors.transparent,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.574666666,
                                              child: Text(
                                                endLocation,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Color(0xFF000000),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30.0, left: 10),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.052566502,
                    width: MediaQuery.of(context).size.width * 0.09866666,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100.0),
                        topRight: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                        topLeft: Radius.circular(100.0),
                      ),
                      color: Color(0xFFD9D9D9),
                    ),
                    child: Center(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.0472413793,
                        width: MediaQuery.of(context).size.width * 0.04866666,
                        child: SvgPicture.asset('assets/icons/star.svg',
                            color: Colors.white, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Saved Places',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.052566502,
                    width: MediaQuery.of(context).size.width * 0.09866666,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100.0),
                        topRight: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                        topLeft: Radius.circular(100.0),
                      ),
                      color: Color(0xFFD9D9D9),
                    ),
                    child: Center(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.0472413793,
                        width: MediaQuery.of(context).size.width * 0.04866666,
                        child: SvgPicture.asset('assets/icons/location.svg',
                            color: Colors.white, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Set location on map',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  if (startingPoint == null || endPoint == null) {
                    var snackBar = const SnackBar(
                        content: Text(
                      'Select start and end ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookLorryStep2(
                                  start: startingPoint!,
                                  end: endPoint!,
                                  destination: endLocation,
                                  origin: startLocation,
                                )));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xFFFAFAFA),
                  ),
                  width: MediaQuery.of(context).size.width * 0.674666666,
                  height: MediaQuery.of(context).size.height * 0.044334975,
                  child: const Center(
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
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
