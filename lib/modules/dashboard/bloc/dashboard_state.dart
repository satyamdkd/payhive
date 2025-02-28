part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class SwitchToHome extends DashboardState {}

final class SwitchToPhotos extends DashboardState {}

final class SwitchToProfile extends DashboardState {}

final class SwitchToVideos extends DashboardState {}
