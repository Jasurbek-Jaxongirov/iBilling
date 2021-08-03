import 'dart:async';

import 'package:bloc/bloc.dart';
import '/api/mock_ibilling_service.dart';
import '/models/contract.dart';
import 'package:meta/meta.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  List<Contract> mockData = [];
  late String _date;
  List<Contract> filteredItems = [];

  Future<void> getMockData() async {
    mockData = await MockIBillingService().getContractResponse();
  }

  void set setDate(String param) {
    _date = param;
  }

  String get getDate {
    return _date;
  }

  Future<void> fetchContractsByDate(DateTime time) async {
    filteredItems = [];
    await getMockData();
    mockData.forEach((contract) {
      try {
        final contractDate = DateTime.parse(contract.createdAt);

        if (time.day == contractDate.day &&
            time.month == contractDate.month &&
            time.year == contractDate.year) {
          filteredItems.add(contract);
        }
      } catch (error) {
        filteredItems = [];
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
      final filteringTime =
          DateTime.parse(FilterContractsByDate(getDate).pickedDateString);
      yield FilteringContractsByDate();
      await fetchContractsByDate(filteringTime);

      try {
        yield FilteredContractsByDate(filteredContracts: filteredItems);
      } catch (error) {
        yield FailedToFilterContractsByDate(error: '$error');
      }
    }
  }
}
