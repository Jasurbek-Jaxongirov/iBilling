part of 'localization_bloc.dart';

@immutable
abstract class LocalizationEvent {}

class LocalizeEvent extends LocalizationEvent {
  final String languageCode;
  final String countryCode;

  LocalizeEvent({
    required this.languageCode,
    required this.countryCode,
  });
}
