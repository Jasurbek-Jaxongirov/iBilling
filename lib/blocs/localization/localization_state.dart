part of 'localization_bloc.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class LocalizingState extends LocalizationState {}

class LocalizedState extends LocalizationState {}

class FailedToLocalizeState extends LocalizationState {}
