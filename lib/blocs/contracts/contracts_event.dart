part of 'contracts_bloc.dart';

class LoadContracts extends ContractsEvent {}

class FilterContractsByDate extends ContractsEvent {
  final String pickedDateString;
  FilterContractsByDate(this.pickedDateString);
}

@immutable
abstract class ContractsEvent {}
