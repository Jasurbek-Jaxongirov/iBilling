import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import '/data/models/contract.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> _entityItems = ['corporal'.tr(), 'juredical'.tr()];
  final List<String> _contractStatus = [
    'paid'.tr(),
    'in-process'.tr(),
    'rej-by-payme'.tr(),
    'rej-by-iq'.tr()
  ];
  String? entityValue;
  String? contractStatusValue;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController vatinController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  void _saveFrom() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    BlocProvider.of<ContractsBloc>(context, listen: false).setNewContract =
        Contract(
      fullName: fullnameController.text,
      contractStatus: contractStatusValue!.tr(),
      amount: 0,
      lastInvoice: 0,
      invoiceAmount: 0,
      address: addressController.text,
      createdAt: DateTime.now().toIso8601String(),
      organizationItn: int.parse(vatinController.text),
    );
    BlocProvider.of<ContractsBloc>(context, listen: false).add(
      AddNewContractEvent(
          contract: BlocProvider.of<ContractsBloc>(context, listen: false)
              .getNewContract),
    );
    fullnameController.clear();
    addressController.clear();
    vatinController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    vatinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(fullnameController.text);
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return Container(
      padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.black,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('entity'.tr()),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == '') {
                    return 'No Entity is selected! Please, select one...';
                  }
                },
                dropdownColor: Constants.darkColor,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: const InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.darkColor))),
                value: entityValue,
                isExpanded: true,
                onChanged: (value) {
                  entityValue = value;
                },
                items: [
                  ..._entityItems.map((e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                ],
              ),
              Text('full-name'.tr()),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Fullname cannot be empty!';
                  } else if (value!.isNotEmpty && value.length <= 3) {
                    return 'Name is too short!';
                  }
                },
                controller: fullnameController,
                style: bodyText2,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Constants.darkColor,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              Text('org-address'.tr()),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Address cannot be empty!';
                  } else if (value!.isNotEmpty && value.length <= 3) {
                    return 'Address is too short!';
                  }
                },
                controller: addressController,
                minLines: 1,
                style: bodyText2,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Constants.darkColor,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              Text('vatin'.tr()),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'VATIN cannot be empty!';
                  }

                  if (value!.length < 3) {
                    return 'VATIN length cannot be less than 3 numbers!';
                  }
                },
                controller: vatinController,
                keyboardType: TextInputType.number,
                style: bodyText2,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/icons/help-circle.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Constants.darkColor,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              Text('contract-status'.tr()),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == '') {
                    return 'No status is selected! Please, select one...';
                  }
                  return null;
                },
                dropdownColor: Constants.darkColor,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: const InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.darkColor))),
                value: contractStatusValue,
                isExpanded: true,
                onChanged: (value) {
                  contractStatusValue = value;
                },
                items: [
                  ..._contractStatus.map((e) => DropdownMenuItem<String>(
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
                onPressed: _saveFrom,
                child: BlocBuilder<ContractsBloc, ContractsState>(
                  builder: (_, state) {
                    if (!(state is AddingNewContract) &&
                        !(state is AddedNewContract)) {
                      return Text(
                        'save_contract'.tr(),
                        style: Theme.of(context).textTheme.bodyText1,
                      );
                    } else if (state is AddingNewContract) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is AddedNewContract) {
                      return Text(
                        'save_contract'.tr(),
                        style: Theme.of(context).textTheme.bodyText1,
                      );
                    } else if (state is FailedToLoadContractsState) {
                      return Text('${state.error}');
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
