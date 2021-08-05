part of 'contracts_bloc.dart';

class LoadContracts extends ContractsEvent {}

class FilterContractsByDate extends ContractsEvent {
  final String pickedDateString;
  FilterContractsByDate(this.pickedDateString);
}

class AddNewContractEvent extends ContractsEvent {
  final Contract contract;

  AddNewContractEvent({required this.contract});
}

@immutable
abstract class ContractsEvent {}
