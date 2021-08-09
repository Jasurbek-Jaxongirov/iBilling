import 'dart:async';

import 'package:bloc/bloc.dart';
import '/data/repositories/mock_ibilling_service.dart';
import '/data/models/contract.dart';
import 'package:meta/meta.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial());
  List<Invoice> invoices = [];
  List<Invoice> filteredInvoice = [];
  late String _date;
  late Invoice _invoice;
  void set setNewInvoice(Invoice invoice) {
    _invoice = invoice;
  }

  Invoice get getNewInvoice {
    return _invoice;
  }

  void set setDate(String param) {
    _date = param;
  }

  String get getDate {
    return _date;
  }

  Future<void> fetchInvoicesByDate(DateTime time) async {
    filteredInvoice = [];
    invoices.forEach((contract) {
      try {
        final contractDate = DateTime.parse(contract.createdAt);

        if (time.day == contractDate.day &&
            time.month == contractDate.month &&
            time.year == contractDate.year) {
          filteredInvoice.add(contract);
        }
      } catch (error) {
        filteredInvoice = [];
      }
    });
  }

  Future<void> getMockInvoices() async {
    try {
      invoices = await MockIBillingService().getInvoiceResponse();
    } catch (error) {
      print(error);
      invoices = [];
    }
  }

  @override
  Stream<InvoiceState> mapEventToState(
    InvoiceEvent event,
  ) async* {
    if (event is LoadInvoices) {
      yield LoadingInvoicesStates();
      await getMockInvoices();

      try {
        yield LoadedInvoicesStates(invoices: invoices);
      } catch (error) {
        yield FailedToLoadInvoices(error: error);
      }
      // Filtering requested contracts
    } else if (event is FilterInvoicesByDate) {
      final filteringTime =
          DateTime.parse(FilterInvoicesByDate(getDate).pickedDateString);
      yield FilteringInvoicesByDate();
      await fetchInvoicesByDate(filteringTime);

      try {
        yield FilteredInvoicesByDate(filteredInvoices: filteredInvoice);
      } catch (error) {
        yield FailedToFilterInvoicesByDate(error: '$error');
      }
    }
    // Adding a new contract
    else if (event is AddNewInvoiceEvent) {
      yield AddingNewInvoiceState();
      final newInvoice = AddNewInvoiceEvent(invoice: getNewInvoice).invoice;
      invoices.add(newInvoice);
      try {
        yield AddedNewInvoiceState(invoice: newInvoice);
      } catch (error) {
        yield FailedToAddNewInvoice(error: error);
      }
    }
  }
}
