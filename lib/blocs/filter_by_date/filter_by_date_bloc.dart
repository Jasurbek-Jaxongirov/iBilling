import 'dart:async';

import 'package:bloc/bloc.dart';
import '/api/mock_ibilling_service.dart';
import '/models/contract.dart';
import 'package:meta/meta.dart';

part 'filter_by_date_event.dart';
part 'filter_by_date_state.dart';

class FilterByDateBloc extends Bloc<FilterByDateEvent, FilterByDateState> {
  bool _isClicked = false;
  List<Contract> mockData = [];
  DateTime _filteringByDate = DateTime.now();
  final List<Contract> _filteredItems = [];

  void set filteringDate(DateTime chosenTime) {
    print('Entered set filtering date function');
    _filteringByDate = chosenTime;
  }

  List<Contract> get filteredItems {
    return _filteredItems;
  }

  void toggleClick(bool isClicked) {
    print('entered');
    _isClicked = isClicked;
  }

  Future<void> getMockData() async {
    mockData = await MockIBillingService().getContractResponse();
  }

  void filterContracts() {
    mockData.forEach((contract) {
      print(contract);
      if (DateTime.parse(contract.createdAt).day == _filteringByDate.day &&
          DateTime.parse(contract.createdAt).month == _filteringByDate.month &&
          DateTime.parse(contract.createdAt).year == _filteringByDate.year &&
          DateTime.parse(contract.createdAt).weekday ==
              _filteringByDate.weekday) {
        print('Added a new contract');

        _filteredItems.add(contract);
      } else {
        print('Nothing related to the date has been found');
      }
    });
  }

  FilterByDateBloc()
      : super(FilteringByDate(
            filteringDate: DateTime.parse('2021-07-30 22:12:43.684105')));

  @override
  Stream<FilterByDateState> mapEventToState(
    FilterByDateEvent event,
  ) async* {
    if (event is ClickDateContainer) {
      await getMockData();
      print('Is Clicked changed $_isClicked');
      if (_isClicked == true) {
        print('Worked isClicked area');
        filterContracts();
        yield FilteringByDate(filteringDate: _filteringByDate);

        try {
          yield FilteredByDate(contractsFilteredByDate: _filteredItems);
        } catch (error) {
          yield FailedToFilterByDate(error: error);
        }
      } else {
        print('Came to no clicked place');
        mockData.forEach((element) {
          _filteredItems.add(element);
        });
        try {
          yield FilteredByDate(contractsFilteredByDate: _filteredItems);
        } catch (error) {
          yield FailedToFilterByDate(error: error);
        }
      }
    }
  }
}
