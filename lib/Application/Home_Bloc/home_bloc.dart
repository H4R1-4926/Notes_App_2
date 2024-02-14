import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yt_dupe/Domain/Home/i.home_repo.dart';
import 'package:yt_dupe/Domain/Home/model/home_model.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final InotesRepo inotesRepo;
  HomeBloc(this.inotesRepo) : super(HomeState.initial()) {
    on<_Started>((event, emit) async {
      if (state.getAlldata.isNotEmpty) {
        return emit(state);
      }
      emit(const HomeState(
        getAlldata: [],
      ));
      final get = await inotesRepo.getAllNote();
      get.sort((first, second) => second.id.compareTo(first.id));
      emit(HomeState(
        getAlldata: get,
      ));
    });
    on<Deleted>((event, emit) async {
      emit(const HomeState(
        getAlldata: [],
      ));
      final get = await inotesRepo.getAllNote();
      get.sort((first, second) => second.id.compareTo(first.id));
      emit(HomeState(
        getAlldata: get,
      ));
    });
    on<Saved>((event, emit) async {
      emit(const HomeState(
        getAlldata: [],
      ));
      final get = await inotesRepo.getAllNote();
      get.sort((first, second) => second.id.compareTo(first.id));
      emit(HomeState(
        getAlldata: get,
      ));
    });
    on<Updated>((event, emit) async {
      emit(const HomeState(
        getAlldata: [],
      ));
      final get = await inotesRepo.getAllNote();
      get.sort((first, second) => second.id.compareTo(first.id));
      emit(HomeState(
        getAlldata: get,
      ));
    });
  }
}
