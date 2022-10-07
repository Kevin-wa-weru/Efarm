// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_posted_products_state.dart';
part 'get_posted_products_cubit.freezed.dart';

class GetPostedProductsCubit extends Cubit<GetPostedProductsState> {
  GetPostedProductsCubit() : super(const GetPostedProductsState.initial());

  List allProducts = [];

  getProducts() async {
    emit(const GetPostedProductsState.loading());
    FirebaseFirestore.instance
        .collection("products")
        .doc()
        .snapshots()
        .listen((event) async {
      var productsData =
          await FirebaseFirestore.instance.collection("products").get();

      for (var product in productsData.docs) {
        allProducts.add(product.data());
      }

      emit(GetPostedProductsState.loaded(allProducts));
    });
  }
}
