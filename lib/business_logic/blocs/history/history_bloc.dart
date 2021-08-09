import 'dart:async';

import 'package:bloc/bloc.dart';
import '/data/models/contract.dart';
import '../../../data/repositories/mock_ibilling_service.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());
  String initialPeriod = '';
  String lastPeriod = '';
  List<Contract> mockData = [];
  List<Contract> historyContracts = [];
  void set setInitialPeriod(String initialPeriod) {
    this.initialPeriod = initialPeriod;
  }

  void set setLastPeriod(String lastPeriod) {
    this.lastPeriod = lastPeriod;
  }

  String get getInitialPeriod {
    return initialPeriod;
  }

  String get getLastPeriod {
    return lastPeriod;
  }

  // Fetch All Json data from sample.json file
  Future<void> fetchMockData() async {
    mockData = await MockIBillingService().getContractResponse();
  }

  // Apply logic to filter requested contracts out of mockData
  void filterHistoryContracts() {
    historyContracts = [];
    mockData.forEach((contract) {
      final contractCreated = DateTime.parse(contract.createdAt);
      if (contractCreated.isBefore(DateTime.parse(lastPeriod)) &&
          contractCreated.isAfter(DateTime.parse(initialPeriod))) {
        historyContracts.add(contract);
      }
    });
  }

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is InitializeHistoryEvent) {
      yield HistoryInitial();
    }
    if (event is LoadHistoryContractsEvent) {
      if (!(initialPeriod == '' || lastPeriod == '')) {
        yield LoadingHistoryContractsState();
        await fetchMockData();
        filterHistoryContracts();
        try {
          yield LoadedHistoryContractsState(contracts: historyContracts);
        } catch (error) {
          yield FailedToLoadHistoryContractsState(error: error);
        }
      } else {
        yield DateNotProvidedState();
      }
    }
  }
}
