import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import '/data/models/contract.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:jiffy/jiffy.dart';
import 'package:easy_localization/easy_localization.dart';

class SingleContractItem extends StatelessWidget {
  final Contract contract;
  // ignore: use_key_in_widget_constructors
  const SingleContractItem({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 370,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.62, vertical: 12),
            color: Constants.darkerColor,
            height: 310,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  labelText: '${'full-name'.tr()}: ',
                  infoText: contract.fullName,
                ),
                CustomRichText(
                  labelText: '${'contract-status'.tr()}: ',
                  infoText: contract.contractStatus.tr(),
                ),
                CustomRichText(
                  labelText: '${'amount'.tr()}: ',
                  infoText: contract.amount.toString(),
                ),
                CustomRichText(
                  labelText: '${'last-invoice'.tr()}: ',
                  infoText: contract.lastInvoice.toString(),
                ),
                CustomRichText(
                  labelText: '${'invoice-number'.tr()}: ',
                  infoText: contract.invoiceAmount.toString(),
                ),
                CustomRichText(
                  labelText: '${'org-address'.tr()}: ',
                  infoText: contract.address,
                ),
                CustomRichText(
                  labelText: '${'vatin'.tr()}: ',
                  infoText: contract.organizationItn.toString(),
                ),
                CustomRichText(
                  labelText: 'Created at: ',
                  infoText:
                      Jiffy(contract.createdAt).format('h:mm, dd MMM, yyyy'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: MaterialButton(
              color: const Color(0xFFFF426D).withOpacity(0.3),
              minWidth: double.infinity,
              onPressed: () {
                BlocProvider.of<ContractsBloc>(context, listen: false)
                    .setContractToDelete = contract;
                BlocProvider.of<ContractsBloc>(context, listen: false)
                    .add(DeleteContractEvent(contract: contract));
              },
              child: BlocBuilder<ContractsBloc, ContractsState>(
                  builder: (_, state) {
                if (!(state is DeletingContractState) &&
                    !(state is FailedToDeleteContractState) &&
                    !(state is DeletedContractState)) {
                  return Text(
                    'Delete contract',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: const Color(0xFFFF426D)),
                  );
                } else if (state is DeletingContractState) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is DeletedContractState) {
                  BlocProvider.of<ContractsBloc>(context, listen: false)
                      .add(LoadContracts());
                  return Text(
                    'Delete contract',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: const Color(0xFFFF426D)),
                  );
                } else if (state is FailedToDeleteContractState) {
                  return Text('$state.error');
                }
                return Container();
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String labelText;
  final String infoText;

  const CustomRichText(
      {Key? key, required this.labelText, required this.infoText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: labelText, children: [
        TextSpan(
          text: infoText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color(0xFF999999),
              ),
        ),
      ]),
    );
  }
}
