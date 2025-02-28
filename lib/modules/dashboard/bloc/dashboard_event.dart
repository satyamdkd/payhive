part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class BottomNavPressed extends DashboardEvent {
  final int bottomNavIndex;

  BottomNavPressed(this.bottomNavIndex);

  List<Object> get props => [bottomNavIndex];
}
