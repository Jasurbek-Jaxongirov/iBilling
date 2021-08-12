import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data/repositories/mock_ibilling_service.dart';
import '/data/models/contract.dart';
import 'package:meta/meta.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  bool isClicked = false;
  bool showButton = false;
  String text = '';
  List<Contract> mockData = [];
  late Contract contractToDelete;
  late String _date;
  List<Contract> filteredItems = [];
  late Contract _newContract;
  int inc = 0;
  set setContractToDelete(Contract contract) {
    contractToDelete = contract;
  }

  Contract get getContractToDelete {
    return contractToDelete;
  }

  set setNewContract(Contract contract) {
    _newContract = contract;
  }

  void deleteRequestedContract() {
    final temporaryList = <Contract>[];
    // mockData
    //     .removeWhere((item) => contractToDelete.createdAt == item.createdAt);
    mockData.forEach((element) {
      if (element.createdAt != contractToDelete.createdAt) {
        temporaryList.add(element);
      }
    });
    mockData = temporaryList;
  }

  Contract get getNewContract {
    return _newContract;
  }

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
    print(showButton);
    // Loading all contracts
    if (event is LoadContracts) {
      yield LoadingContractsState();
      print('Loading Initialized');
      if (inc == 0) {
        await getMockData();
        inc = 1;
        print('Initialized once...');
      }

      try {
        yield LoadedContractsState(contracts: mockData);
      } catch (error) {
        yield FailedToLoadContractsState(error: '$error');
      }
      // Filtering requested contracts
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
      // Adding a new contract
    } else if (event is AddNewContractEvent) {
      yield AddingNewContract();
      final newContract =
          AddNewContractEvent(contract: getNewContract).contract;
      mockData.add(newContract);

      try {
        yield AddedNewContract(contract: newContract);
      } catch (error) {
        yield FailedToAddNewContract(error: error);
      }
    } else if (event is DeleteContractEvent) {
      yield DeletingContractState();
      deleteRequestedContract();
      try {
        yield DeletedContractState(deletedContract: getContractToDelete);
      } catch (error) {
        yield FailedToDeleteContractState(error: error);
      }
    }
  }
}
