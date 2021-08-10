part of 'contracts_bloc.dart';

@immutable
abstract class ContractsState {}

class ContractsInitialState extends ContractsState {}

class LoadingContractsState extends ContractsState {}

// Loading all contracts states
class LoadedContractsState extends ContractsState {
  final List<Contract> contracts;

  LoadedContractsState({required this.contracts});
}

class FailedToLoadContractsState extends ContractsState {
  final String error;

  FailedToLoadContractsState({required this.error});
}

// Filtering contracts by date states
class FilteringContractsByDate extends ContractsState {}

class FilteredContractsByDate extends ContractsState {
  final List<Contract> filteredContracts;
  FilteredContractsByDate({required this.filteredContracts});
}

class FailedToFilterContractsByDate extends ContractsState {
  final String error;
  FailedToFilterContractsByDate({required this.error});
}

// Adding new contract
class AddingNewContract extends ContractsState {}

class AddedNewContract extends ContractsState {
  final Contract contract;

  AddedNewContract({required this.contract});
}

class FailedToAddNewContract extends ContractsState {
  final Object error;

  FailedToAddNewContract({required this.error});
}

// Deleting contract

class DeletingContractState extends ContractsState {}

class DeletedContractState extends ContractsState {
  final Contract deletedContract;
  DeletedContractState({required this.deletedContract});
}

class FailedToDeleteContractState extends ContractsState {
  final Object error;
  FailedToDeleteContractState({required this.error});
}
