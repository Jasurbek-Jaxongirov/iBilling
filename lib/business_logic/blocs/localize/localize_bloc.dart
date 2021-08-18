import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'localize_event.dart';
part 'localize_state.dart';

class LocalizeBloc extends Bloc<LocalizeEvent, LocalizeState> {
  LocalizeBloc() : super(LocalizeInitial());
  String _lang = '';

  set setlang(String lang) {
    _lang = lang;
  }

  String get getlang {
    return _lang;
  }

  @override
  Stream<LocalizeState> mapEventToState(
    LocalizeEvent event,
  ) async* {
    if (event is LocalizationEvent) {
      yield LocalizingState();
    }
  }
}
