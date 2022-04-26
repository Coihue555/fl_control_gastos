part of 'nav_bloc.dart';

@immutable
 class NavState {
   final String screen;

   const NavState({
     required this.screen
   });

   NavState copyWith({
     final String? screen,
   }) => NavState(screen: screen ?? this.screen);


 }
