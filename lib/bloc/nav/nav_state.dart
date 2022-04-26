part of 'nav_bloc.dart';

@immutable
 class NavState {
   String screen;

   NavState({
     required this.screen
   });

   NavState copyWith({
     final String? screen,
   }) => NavState(screen: screen ?? this.screen);


 }
