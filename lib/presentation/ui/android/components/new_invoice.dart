import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/models/contract.dart';
import '/business_logic/blocs/invoice/invoice_bloc.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class NewInvoice extends StatefulWidget {
  const NewInvoice({Key? key}) : super(key: key);

  @override
  _NewInvoiceState createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  final List<String> invoiceItems = [
    'Paid',
    'In process',
    'Rejected by Payme',
    'Rejected by IQ'
  ];

  String? valueChosen;
  String? invoiceStatusValue;
  TextEditingController serviceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    serviceController.dispose();
    amountController.dispose();
  }

  final formKey = GlobalKey<FormState>();
  void _saveForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<InvoiceBloc>(context, listen: false).setNewInvoice =
          Invoice(
        amount: int.parse(amountController.text),
        createdAt: DateTime.now().toIso8601String(),
        invoiceStatus: invoiceStatusValue ?? '',
        serviceName: serviceController.text,
      );
      serviceController.clear();
      amountController.clear();
      BlocProvider.of<InvoiceBloc>(context).add(AddNewInvoiceEvent(
          invoice: BlocProvider.of<InvoiceBloc>(context).getNewInvoice));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Service Name'),
              TextFormField(
                controller: serviceController,
                validator: (value) {
                  if (value == '') {
                    return 'Service name is empty!';
                  } else if (value!.length < 3) {
                    return 'Service name cannot be less than three characters';
                  }
                },
                style: bodyText2,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.darkColor)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
              ),
              const Text('Amount'),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Amount is empty';
                  }
                },
                controller: amountController,
                keyboardType: TextInputType.number,
                style: bodyText2,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.darkColor)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
              ),
              const Text('Status of the invoice'),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == '') {
                    return 'Status is empty!';
                  }
                },
                dropdownColor: Constants.darkColor,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: const InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.darkColor))),
                value: invoiceStatusValue,
                isExpanded: true,
                onChanged: (value) {
                  invoiceStatusValue = value;
                },
                items: [
                  ...invoiceItems.map((e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                color: Constants.darkGreenColor,
                onPressed: _saveForm,
                child:
                    BlocBuilder<InvoiceBloc, InvoiceState>(builder: (_, state) {
                  if (state is InvoiceInitial ||
                      state is LoadedInvoicesStates ||
                      state is FilteredInvoicesByDate) {
                    return Text(
                      'save_invoice'.tr(),
                      style: Theme.of(context).textTheme.bodyText1,
                    );
                  } else if (state is AddingNewInvoiceState) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (state is AddedNewInvoiceState) {
                    return Text(
                      'save_invoice'.tr(),
                      style: Theme.of(context).textTheme.bodyText1,
                    );
                  } else if (state is FailedToAddNewInvoice) {
                    return Text('${state.error}');
                  }
                  return Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
