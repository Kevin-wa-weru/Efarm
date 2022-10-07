part of 'get_farms_cubit.dart';

@freezed
class GetFarmsState with _$GetFarmsState {
  const factory GetFarmsState.initial() = _Initial;
  const factory GetFarmsState.loading() = _Loading;
  const factory GetFarmsState.loaded(List allFarms) = _Loaded;
  const factory GetFarmsState.error(String error) = _Error;
}
