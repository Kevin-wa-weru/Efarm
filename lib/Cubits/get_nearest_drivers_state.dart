part of 'get_nearest_drivers_cubit.dart';

@freezed
class GetNearestDriversState with _$GetNearestDriversState {
  const factory GetNearestDriversState.initial() = _Initial;
  const factory GetNearestDriversState.loading() = _Loading;
  const factory GetNearestDriversState.loaded(List alldrivers) = _Loaded;
  const factory GetNearestDriversState.error(String error) = _Error;
}
