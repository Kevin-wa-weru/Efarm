import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/Cubits/get_nearest_drivers_cubit.dart';
import 'package:eshamba/homepage.dart';
import 'package:eshamba/quick_chat.dart';
import 'package:eshamba/screens/driver/driver_homePage.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/vendorpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookLorryStep2 extends StatefulWidget {
  const BookLorryStep2(
      {Key? key,
      required this.start,
      required this.end,
      required this.origin,
      required this.destination,
      required this.address})
      : super(key: key);
  final LatLng start;
  final LatLng end;
  final String origin;
  final String destination;
  final String address;

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

  String? username;
  String? userAvatarUrl;
  String? userType;

  getUserDetails() async {
    final docRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().userid.trim())
        .get();

    setState(() {
      userAvatarUrl = docRef.data()!['avatarUrl'];
      username = docRef.data()!['name'];
      userType = docRef.data()!['userType'];
    });
  }

  @override
  void initState() {
    super.initState();
    // getDirection(widget.origin, widget.destination);
    getUserDetails();
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

    context.read<GetNearestDriversCubit>().getDrivers(widget.start, widget.end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              'Search Results',
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
        padding: const EdgeInsets.only(bottom: 30.0),
        child: SizedBox(
          height: 20,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                if (userType == 'user') {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }

                if (userType == 'Vendor') {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Vendorprofile()));
                }

                if (userType == 'driver') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DriverHomePage()));
                }
              },
              child: const Text(
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
      ),
      body: FutureBuilder<dynamic>(
          future: determineIfEnded(),
          builder: (context, snapshot) {
            return Column(
              children: [
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
                BlocBuilder<GetNearestDriversCubit, GetNearestDriversState>(
                  builder: (context, state) {
                    return state.when(initial: () {
                      return const loadingDriver();
                    }, loading: () {
                      return const loadingDriver();
                    }, loaded: (alldrivers) {
                      if (alldrivers.isEmpty) {
                        return const FoundNoDriver();
                      } else {
                        return Column(
                          children: alldrivers
                              .map((e) => SingleNearbyDriver(
                                    driver: e,
                                    address: widget.address,
                                    avatar: userAvatarUrl!,
                                    username: username!,
                                  ))
                              .toList(),
                        );
                      }
                    }, error: (error) {
                      return const Center(child: Text('error'));
                    });
                  },
                ),
              ],
            );
          }),
    );
  }
}

class SingleNearbyDriver extends StatelessWidget {
  const SingleNearbyDriver({
    Key? key,
    required this.driver,
    required this.address,
    required this.avatar,
    required this.username,
  }) : super(key: key);
  final Map driver;
  final String address;
  final String avatar;
  final String username;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.893333333,
              height: MediaQuery.of(context).size.height * 0.1009852216,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: driver['image'] == ''
                            ? Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xFFE8E8E8),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0147783251,
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                    child: SvgPicture.asset(
                                        'assets/icons/user.svg',
                                        color: Colors.black12,
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(driver['image']),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Text(
                          driver['name'],
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.393333333,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0, top: 15),
                            child: InkWell(
                              onTap: () async {
                                final docRef = FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(driver['id'])
                                    .collection('requests');

                                await docRef.add({
                                  'status': 'none',
                                  'address': address,
                                  'date': DateTime.now(),
                                  'price': driver['charge'],
                                  'requestby': {
                                    'avatarUrl': avatar,
                                    'name': username,
                                  },
                                  'vehicles': '1',
                                  'requestId':
                                      AuthenticationHelper().userid.trim()
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuickChatDetails(
                                              name: driver['name'],
                                              userID: driver['id'],
                                              avatarUrl: driver['image'],
                                            )));
                              },
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.02987684,
                                width: MediaQuery.of(context).size.width *
                                    0.0693333333,
                                child: SvgPicture.asset('assets/icons/text.svg',
                                    fit: BoxFit.contain),
                              ),
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
                        height: MediaQuery.of(context).size.height * 0.03987684,
                        width: MediaQuery.of(context).size.width * 0.0593333333,
                        child: SvgPicture.asset('assets/icons/truck.svg',
                            fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          '${driver['vehicleNos']} vehicle(s)',
                          style: const TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    driver['address'],
                    style: const TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    driver['date'],
                    style: const TextStyle(
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
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '\$${driver['charge']}/day',
                      style: const TextStyle(
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
      ),
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

class FoundNoDriver extends StatelessWidget {
  const FoundNoDriver({
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
            'Oops. No drivers are near you at the moment',
            style: TextStyle(
                color: Colors.red,
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      ),
    );
  }
}
