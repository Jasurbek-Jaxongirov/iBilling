part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent {}

class LoadInvoices extends InvoiceEvent {}

class FilterInvoicesByDate extends InvoiceEvent {
  final String pickedDateString;
  FilterInvoicesByDate(this.pickedDateString);
}

class AddNewInvoiceEvent extends InvoiceEvent {
  final Invoice invoice;

  AddNewInvoiceEvent({required this.invoice});
}
