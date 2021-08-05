part of 'localization_bloc.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class LocalizingState extends LocalizationState {}

class LocalizedState extends LocalizationState {
  final String languageCode;
  final String countryCode;
  final BuildContext context;
  LocalizedState({
    required this.languageCode,
    required this.countryCode,
    required this.context,
  });

  void setNewLanguage() {
    context.locale = Locale('$languageCode', '$countryCode');
  }
}

class FailedToLocalizeState extends LocalizationState {}
