import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/data/models/contract.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:jiffy/jiffy.dart';
import 'package:easy_localization/easy_localization.dart';

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
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: contract.contractStatus.tr() == 'paid'.tr()
                      ? const Color(0XFF49B7A5).withOpacity(0.15)
                      : contract.contractStatus.tr() == 'in-process'.tr()
                          ? const Color(0xFFFDAB2A).withOpacity(0.15)
                          : const Color(0xF85379).withOpacity(0.15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Text(
                  contract.contractStatus.tr(),
                  style: TextStyle(
                    color: contract.contractStatus.tr() == 'paid'.tr()
                        ? const Color(0XFF49B7A5)
                        : contract.contractStatus.tr() == 'in-process'.tr()
                            ? const Color(0xFFFDAB2A)
                            : const Color(0xFFFF426D),
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
                    labelText: '${'full-name'.tr()}: ',
                    infoText: contract.fullName),
                CustomRichText(
                    labelText: '${'amount'.tr()}:',
                    infoText: '${contract.amount}'),
                CustomRichText(
                    labelText: '${'last-invoice'.tr()}: ',
                    infoText: '№ ${contract.lastInvoice}'),
                Row(
                  children: [
                    CustomRichText(
                        labelText: '${'invoice-number'.tr()}: ',
                        infoText: '${contract.invoiceAmount}'),
                    const Spacer(),
                    Text(
                      Jiffy(contract.createdAt).format('dd.MM.yyyy'),
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
