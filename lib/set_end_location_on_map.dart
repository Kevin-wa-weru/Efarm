import 'package:eshamba/book_lorry_step2.dart';
import 'package:flutter/material.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class SetEndLocationOnMap extends StatefulWidget {
  const SetEndLocationOnMap(
      {Key? key,
      required this.userLocation,
      required this.startLocation,
      required this.startAddress})
      : super(key: key);
  final LatLng userLocation;

  final LatLng startLocation;
  final String startAddress;
  @override
  State<SetEndLocationOnMap> createState() => _SetEndLocationOnMapState();
}

class _SetEndLocationOnMapState extends State<SetEndLocationOnMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng selectedLocation =
      LatLng(widget.startLocation.latitude, widget.startLocation.longitude);
  List<Marker> allMarkers = [];
  String? selectedAddress;

  handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      selectedLocation = tappedPoint;
      allMarkers = [];
      allMarkers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          draggable: true,
          onDragEnd: (dragEndPosition) {}));
    });
    getAddressFromLocation(tappedPoint.latitude, tappedPoint.longitude);
  }

  Future getAddressFromLocation(double lat, double lng) async {
    var googleGeocoding =
        GoogleGeocoding("AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0");
    var addresses = await googleGeocoding.geocoding.getReverse(LatLon(
      lat,
      lng,
    ));
    setState(() {
      selectedAddress =
          addresses!.results!.first.addressComponents!.first.longName;
    });
  }

  @override
  void initState() {
    allMarkers.add(Marker(
      markerId: const MarkerId('Your Location'),
      draggable: false,
      infoWindow:
          const InfoWindow(title: 'Your Location', snippet: 'Your Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position:
          LatLng(widget.startLocation.latitude, widget.startLocation.longitude),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                width: MediaQuery.of(context).size.width * 0.028,
              ),
              const Text(
                ' Set End location',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  if (selectedLocation ==
                      LatLng(widget.startLocation.latitude,
                          widget.startLocation.longitude)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        "Select your destination",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookLorryStep2(
                                  start: widget.startLocation,
                                  end: selectedLocation,
                                  destination: selectedAddress.toString(),
                                  origin: widget.startAddress,
                                  address: widget.startAddress,
                                )));
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.428,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' Next',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0581773399,
          ),
          selectedAddress == null
              ? Container()
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 10),
                      child: Text(
                        selectedAddress.toString(),
                        style: const TextStyle(
                            color: Colors.black54,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.681773399,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10),
                child: GoogleMap(
                  markers: Set.from(allMarkers),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.startLocation.latitude,
                        widget.startLocation.longitude),
                    zoom: 12.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: handleTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
