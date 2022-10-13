import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'get_nearest_drivers_state.dart';
part 'get_nearest_drivers_cubit.freezed.dart';

class GetNearestDriversCubit extends Cubit<GetNearestDriversState> {
  GetNearestDriversCubit() : super(const GetNearestDriversState.initial());
  List alldrivers = [];

  double calculateDistance(
    lat1,
    lon1,
    lat2,
    lon2,
  ) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getDrivers(LatLng startingPoint, LatLng endPoint) async {
    emit(const GetNearestDriversState.loading());
    List drivers = [];
    var response = await FirebaseFirestore.instance
        .collection("users")
        .where('userType', isEqualTo: 'driver')
        .get();

    for (var driver in response.docs) {
      double distance = calculateDistance(
          startingPoint.latitude,
          startingPoint.longitude,
          driver['latitudeLocation'],
          driver['longitudeLocation']);

      print('WHHHHHHHHHHHHHHHHHHHHHHHAAAAAAFFFSSRSFSdsdSDSDSDSDSD');
      print(distance);
//more than 50km ignore
      if (distance > 50) {
      } else {
        drivers.add({
          'id': driver['userid'],
          'distance': distance,
          'image': driver['avatarUrl'],
          'name': driver['name'],
          'vehicleNos': driver['vehicleNos'],
          'address': driver['addressLocation'],
          'date':
              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
          'charge': driver['charge'],
        });
      }
    }

    emit(GetNearestDriversState.loaded(drivers));

    alldrivers = [];
  }
}
