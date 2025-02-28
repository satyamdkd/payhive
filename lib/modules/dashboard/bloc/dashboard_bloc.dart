import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<BottomNavPressed>(bottomNavPressed);
  }

  bottomNavPressed(BottomNavPressed event, Emitter<DashboardState> emit) async {
    if (event.bottomNavIndex == 0) {
      emit(SwitchToHome());
    } else if (event.bottomNavIndex == 1) {
      emit(SwitchToPhotos());
    } else if (event.bottomNavIndex == 2) {
      emit(SwitchToVideos());
    } else if (event.bottomNavIndex == 3) {
      emit(SwitchToProfile());
    }
  }
}
