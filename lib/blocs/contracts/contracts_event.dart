part of 'contracts_bloc.dart';

class LoadContracts extends ContractsEvent {}

class FilterContractsByDate extends ContractsEvent {
  FilterContractsByDate();
}

@immutable
abstract class ContractsEvent {}
