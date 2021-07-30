import 'dart:async';

import 'package:bloc/bloc.dart';
import '/api/mock_ibilling_service.dart';
import '/models/contract.dart';
import 'package:meta/meta.dart';

part 'filter_by_date_event.dart';
part 'filter_by_date_state.dart';

class FilterByDateBloc extends Bloc<FilterByDateEvent, FilterByDateState> {
  bool _isClicked = false;
  DateTime _filteringByDate = DateTime.parse('2021-07-30 19:40:26.572236');
  final List<Contract> _filteredItems = [];
  DateTime get filteringByDate {
    return _filteringByDate = DateTime.parse('2021-07-30 19:40:26.572236');
  }

  List<Contract> get filteredItems {
    return _filteredItems;
  }

  void toggleClick(bool isClicked) {
    print('entered');
    _isClicked = isClicked;
  }

  Future<void> filterContracts() async {
    final mockData = await MockIBillingService().getContractResponse();
    mockData.forEach((contract) {
      print(contract);
      if (DateTime.parse(contract.createdAt).day == filteringByDate.day &&
          DateTime.parse(contract.createdAt).month == filteringByDate.month &&
          DateTime.parse(contract.createdAt).year == filteringByDate.year &&
          DateTime.parse(contract.createdAt).weekday ==
              filteringByDate.weekday) {
        print('Added a new contract');

        _filteredItems.add(contract);
      } else {
        print('Not parsed');
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
      if (_isClicked == true) {
        await filterContracts();
        yield FilteringByDate(filteringDate: filteringByDate);

        try {
          yield FilteredByDate(contractsFilteredByDate: _filteredItems);
        } catch (error) {
          yield FailedToFilterByDate(error: error);
        }
      }
    }
  }
}
