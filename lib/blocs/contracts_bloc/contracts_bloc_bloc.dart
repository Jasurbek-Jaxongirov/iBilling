import 'dart:async';

import 'package:bloc/bloc.dart';
import '/api/mock_ibilling_service.dart';
import '/models/contract.dart';
import 'package:meta/meta.dart';

part 'contracts_bloc_event.dart';
part 'contracts_bloc_state.dart';

class ContractsBlocBloc extends Bloc<ContractsBlocEvent, ContractsBlocState> {
  ContractsBlocBloc() : super(LoadingContractsState());

  @override
  Stream<ContractsBlocState> mapEventToState(
    ContractsBlocEvent event,
  ) async* {
    if (event is LoadContractsEvent) {
      yield LoadingContractsState();

      try {
        final mockData = await MockIBillingService().getContractResponse();

        yield LoadedContractsState(contracts: mockData);
      } catch (error) {
        yield FailedToLoadContractsState(error: error);
      }
    }
  }
}
