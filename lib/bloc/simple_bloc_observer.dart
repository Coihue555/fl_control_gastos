import 'dart:developer';

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  // ignore: unnecessary_overrides
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('bloc: $bloc .. event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('bloc: $bloc .. error: $error');

    super.onError(bloc, error, stackTrace);
  }

  @override
  // ignore: unnecessary_overrides
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // log('bloc: $bloc .. change: $change');
  }

  @override
  // ignore: unnecessary_overrides
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // log('bloc: $bloc .. transition: $transition');
  }
}
