part of 'localize_bloc.dart';

@immutable
abstract class LocalizeState {}

class LocalizeInitial extends LocalizeState {}

class LocalizingState extends LocalizeState {}

class LocalizedState extends LocalizeState {}

class FailedToLocalize extends LocalizeState {}
