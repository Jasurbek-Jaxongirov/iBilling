part of 'filter_by_date_bloc.dart';

@immutable
abstract class FilterByDateState {}

class FilteringByDate extends FilterByDateState {
  final DateTime filteringDate;

  FilteringByDate({required this.filteringDate});
}

class FilteredByDate extends FilterByDateState {
  final List<Contract> contractsFilteredByDate;
  FilteredByDate({required this.contractsFilteredByDate});
}

class FailedToFilterByDate extends FilterByDateState {
  final error;
  FailedToFilterByDate({required this.error});
}
