import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookLorryStep2 extends StatefulWidget {
  const BookLorryStep2(
      {Key? key,
      required this.start,
      required this.end,
      required this.origin,
      required this.destination})
      : super(key: key);
  final LatLng start;
  final LatLng end;
  final String origin;
  final String destination;

  @override
  State<BookLorryStep2> createState() => BookLorryStep2State();
}

class BookLorryStep2State extends State<BookLorryStep2> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleApikey = "AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0";
  Map<PolylineId, Polyline> polylines = {};
  List<Marker> allMarkers = [];
  int polylineCounter = 1;

  Future getDirection(String origin, String destination) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApikey,
      PointLatLng(widget.start.latitude, widget.start.longitude),
      PointLatLng(widget.end.latitude, widget.end.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }

    addPolyLine(polylineCoordinates);
    return;
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  Future determineIfEnded() async {
    await getDirection(widget.origin, widget.destination);
  }

  @override
  void initState() {
    super.initState();
    // getDirection(widget.origin, widget.destination);
    allMarkers.add(Marker(
        markerId: MarkerId(widget.end.latitude.toString()),
        draggable: false,
        infoWindow:
            InfoWindow(title: widget.destination, snippet: widget.destination),
        position: LatLng(widget.end.latitude, widget.end.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId(widget.start.latitude.toString()),
        draggable: false,
        infoWindow: InfoWindow(title: widget.origin, snippet: widget.origin),
        position: LatLng(widget.start.latitude, widget.start.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SizedBox(
          height: 20,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: Color(0xFFFF0000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
        ),
      ),
      body: FutureBuilder<dynamic>(
          future: determineIfEnded(),
          builder: (context, snapshot) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0581773399,
                ),
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
                Container(
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
                      polylines: Set<Polyline>.of(polylines.values),
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            widget.start.latitude, widget.start.longitude),
                        zoom: 12.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0581773399,
                ),
                // const loadingDriver(),
                Card(
                  elevation: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    height: MediaQuery.of(context).size.height * 0.1009852216,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 10),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/woman.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 10),
                              child: Text(
                                'Wade Warren',
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width *
                                  0.393333333,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, top: 15),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02987684,
                                    width: MediaQuery.of(context).size.width *
                                        0.0693333333,
                                    child: SvgPicture.asset(
                                        'assets/icons/text.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.03987684,
                              width: MediaQuery.of(context).size.width *
                                  0.0593333333,
                              child: SvgPicture.asset('assets/icons/truck.svg',
                                  fit: BoxFit.contain),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                '22 vehicle',
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 50.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
                        width: MediaQuery.of(context).size.width * 0.0330133,
                        child: SvgPicture.asset('assets/icons/location.svg',
                            fit: BoxFit.contain),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Juja, Kikuyu',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 50.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
                        width: MediaQuery.of(context).size.width * 0.0330133,
                        child: SvgPicture.asset('assets/icons/calendar.svg',
                            fit: BoxFit.contain),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          '16/02/2022',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.600133,
                        color: Colors.transparent,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '\$8.90/day',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class loadingDriver extends StatelessWidget {
  const loadingDriver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFAFAFA),
        ),
        width: MediaQuery.of(context).size.width * 0.893333333,
        height: MediaQuery.of(context).size.height * 0.238916256,
        child: const Center(
          child: Text(
            'Connecting to the nearby driver',
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      ),
    );
  }
}
