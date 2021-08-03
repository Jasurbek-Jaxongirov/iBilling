part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class InitializeHistoryEvent extends HistoryEvent {}

class LoadHistoryContractsEvent extends HistoryEvent {
  final String initialDate;
  final String lastDate;

  LoadHistoryContractsEvent(this.initialDate, this.lastDate);
}
