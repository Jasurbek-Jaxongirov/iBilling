part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState {}

// Loading invoices from mock data
class InvoiceInitial extends InvoiceState {}

class LoadingInvoicesStates extends InvoiceState {}

class LoadedInvoicesStates extends InvoiceState {
  final List<Invoice> invoices;
  LoadedInvoicesStates({required this.invoices});
}

class FailedToLoadInvoices extends InvoiceState {
  final Object error;
  FailedToLoadInvoices({required this.error});
}

// Filtering invoices by requested date
class FilteringInvoicesByDate extends InvoiceState {}

class FilteredInvoicesByDate extends InvoiceState {
  final List<Invoice> filteredInvoices;
  FilteredInvoicesByDate({required this.filteredInvoices});
}

class FailedToFilterInvoicesByDate extends InvoiceState {
  final String error;
  FailedToFilterInvoicesByDate({required this.error});
}

// Adding a new invoice
class AddingNewInvoiceState extends InvoiceState {}

class AddedNewInvoiceState extends InvoiceState {
  final Invoice invoice;
  AddedNewInvoiceState({required this.invoice});
}

class FailedToAddNewInvoice extends InvoiceState {
  final Object error;
  FailedToAddNewInvoice({required this.error});
}
