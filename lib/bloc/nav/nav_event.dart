part of 'nav_bloc.dart';

@immutable
abstract class NavEvent {}

class GetScreen extends NavEvent{
  String screen;
  GetScreen(this.screen);
}
