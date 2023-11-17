import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SwitchEvent {}

class Switched extends SwitchEvent {}

class SwitchBloc extends Bloc<SwitchEvent, bool> {
  SwitchBloc() : super(true) {
    on<Switched>((event, emit) {
      if (!state) {
        print(!state);
      } else {
        print(!state);
      }
      emit(!state);
    });
  }
}
