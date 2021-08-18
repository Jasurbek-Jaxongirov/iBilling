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
    'paid'.tr(),
    'in-process'.tr(),
    'rej-by-payme'.tr(),
    'rej-by-iq'.tr()
  ];

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
      BlocProvider.of<InvoiceBloc>(context).add(AddNewInvoiceEvent(
          invoice: BlocProvider.of<InvoiceBloc>(context).getNewInvoice));
      serviceController.clear();

      amountController.clear();
      invoiceStatusValue = null;
      BlocProvider.of<InvoiceBloc>(context).add(LoadInvoices());
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
              Text('service-name'.tr()),
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
              Text('amount'.tr()),
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
              Text('invoice-status'.tr()),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Status is empty!';
                  }
                },
                dropdownColor: Constants.darkColor,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: const InputDecoration(
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
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
                  child: BlocListener<InvoiceBloc, InvoiceState>(
                    listener: (_, state) {
                      if (state is AddingNewInvoiceState) {
                      } else if (state is AddedNewInvoiceState) {
                        showDialog(
                            barrierDismissible: true,
                            barrierColor:
                                const Color(0xFF0C0C0C).withOpacity(0.8),
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                backgroundColor: Constants.darkColor,
                                content: Text(
                                  'New Invoice has successfully been added',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                actions: [
                                  MaterialButton(
                                    color: Constants.darkGreenColor
                                        .withOpacity(0.4),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      'Done',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Text(
                      'save_invoice'.tr(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
