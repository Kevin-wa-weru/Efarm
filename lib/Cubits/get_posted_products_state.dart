part of 'get_posted_products_cubit.dart';

@freezed
class GetPostedProductsState with _$GetPostedProductsState {
  const factory GetPostedProductsState.initial() = _Initial;
  const factory GetPostedProductsState.loading() = _Loading;
  const factory GetPostedProductsState.loaded(List postedProducts) = _Loaded;
  const factory GetPostedProductsState.error(String error) = _Error;
}
