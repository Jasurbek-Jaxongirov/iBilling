import 'dart:async';

import 'package:bloc/bloc.dart';
import '/api/mock_ibilling_service.dart';
import '/models/contract.dart';
import 'package:meta/meta.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  List<Contract> mockData = [];

  List<Contract> _filteredItems = [];

  DateTime filteringTime = DateTime.now();

  List<Contract> get filteredItems {
    return _filteredItems;
  }

  Future<void> getMockData() async {
    mockData = await MockIBillingService().getContractResponse();
  }

  Future<void> fetchContractsByDate(DateTime time) async {
    await getMockData();
    mockData.forEach((contract) {
      try {
        if (DateTime.parse(contract.createdAt) == time) {
          _filteredItems.add(contract);
        }
      } catch (error) {
        print('Error occured: $error');
      }
    });
  }

  ContractsBloc() : super(ContractsInitialState());

  @override
  Stream<ContractsState> mapEventToState(
    ContractsEvent event,
  ) async* {
    if (event is LoadContracts) {
      yield LoadingContractsState();
      await getMockData();
      try {
        yield LoadedContractsState(contracts: mockData);
      } catch (error) {
        yield FailedToLoadContractsState(error: '$error');
      }
    } else if (event is FilterContractsByDate) {
      yield FilteringContractsByDate();
      await fetchContractsByDate(DateTime.parse('2021-07-21 18:40:26.572236'));

      try {
        yield FilteredContractsByDate(filteredContracts: _filteredItems);
      } catch (error) {
        yield FailedToFilterContractsByDate(error: '$error');
      }
    }
  }
}
