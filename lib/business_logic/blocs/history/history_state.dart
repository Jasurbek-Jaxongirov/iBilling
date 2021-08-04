part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class LoadingHistoryContractsState extends HistoryState {}

class LoadedHistoryContractsState extends HistoryState {
  final List<Contract> contracts;

  LoadedHistoryContractsState({required this.contracts});
}

class FailedToLoadHistoryContractsState extends HistoryState {
  final Object error;

  FailedToLoadHistoryContractsState({required this.error});
}

class DateNotProvidedState extends HistoryState {}
