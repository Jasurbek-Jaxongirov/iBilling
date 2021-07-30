part of 'contracts_bloc_bloc.dart';

@immutable
abstract class ContractsBlocState {}

class LoadingContractsState extends ContractsBlocState {}

class LoadedContractsState extends ContractsBlocState {
  final List<Contract> contracts;

  LoadedContractsState({required this.contracts});
}

class FailedToLoadContractsState extends ContractsBlocState {
  final Object error;

  FailedToLoadContractsState({required this.error});
}
