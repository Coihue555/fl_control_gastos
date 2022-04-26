import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super( NavState(screen: 'Home')) {

    on<GetScreen>(_getScreen);

  }

  _getScreen(GetScreen event, Emitter emit) {
    emit(state.copyWith( screen: ''));
    
    state.screen = event.screen;

  }



}
