part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.deleted() = Deleted;
  const factory HomeEvent.saved() = Saved;
  const factory HomeEvent.updated() = Updated;
}
