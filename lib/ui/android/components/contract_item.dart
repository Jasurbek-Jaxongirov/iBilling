import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/models/contract.dart';
import 'package:i_billing/ui/theme/app_constants.dart';

class ContractItem extends StatelessWidget {
  final Contract contract;

  // ignore: use_key_in_widget_constructors
  const ContractItem({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 148,
      color: Constants.darkerColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.62, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/paper.svg'),
              Text(
                '№ ${contract.lastInvoice}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              Chip(
                label: Text(
                  contract.contractStatus,
                  style: const TextStyle(
                    color: Color(0XFF49B7A5),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                    labelText: 'Fish: ', infoText: contract.fullName),
                CustomRichText(
                    labelText: 'Amount:', infoText: '${contract.amount}'),
                CustomRichText(
                    labelText: 'Last invoice: ',
                    infoText: '№ ${contract.lastInvoice}'),
                Row(
                  children: [
                    CustomRichText(
                        labelText: 'Number of invoice: ',
                        infoText: '${contract.invoiceAmount}'),
                    const Spacer(),
                    Text(
                      '${contract.createdAt}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xFF999999),
                          ),
                    ),
                  ],
                ),
              ],
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
