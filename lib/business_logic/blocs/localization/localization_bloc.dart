import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial());
  var countryCode = '';
  var languageCode = '';
  var radioValue = '';
  late BuildContext context;
  set setLanguageCode(String langCode) {
    languageCode = langCode;
  }

  set setCountryCode(String countryCode) {
    countryCode = countryCode;
  }

  String get getLanguageCode {
    return languageCode;
  }

  String get getCountryCode {
    return countryCode;
  }

  set setContext(BuildContext countryCode) {
    countryCode = countryCode;
  }

  BuildContext get getContext {
    return context;
  }

  @override
  Stream<LocalizationState> mapEventToState(
    LocalizationEvent event,
  ) async* {
    if (event is LocalizeEvent) {
      yield LocalizingState();

      try {
        yield LocalizedState(
            context: getContext,
            countryCode: getCountryCode,
            languageCode: getLanguageCode)
          ..setNewLanguage();
      } catch (error) {
        yield FailedToLocalizeState();
      }
    }
  }
}
