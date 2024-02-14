part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<NoteModel> getAlldata,
  }) = _HomeState;
  factory HomeState.initial() {
    return const HomeState(getAlldata: []);
  }
}
