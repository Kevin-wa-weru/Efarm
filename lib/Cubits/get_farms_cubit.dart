// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_farms_state.dart';
part 'get_farms_cubit.freezed.dart';

class GetFarmsCubit extends Cubit<GetFarmsState> {
  GetFarmsCubit() : super(const GetFarmsState.initial());

  List allFarms = [];

  getFarms() async {
    emit(const GetFarmsState.loading());
    FirebaseFirestore.instance
        .collection("farms")
        .doc()
        .snapshots()
        .listen((event) async {
      var farmData = await FirebaseFirestore.instance.collection("farms").get();

      for (var farm in farmData.docs) {
        allFarms.add(farm.data());
      }

      emit(GetFarmsState.loaded(allFarms));
    });
  }
}
