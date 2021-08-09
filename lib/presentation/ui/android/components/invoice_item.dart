import 'package:flutter/material.dart';
import '/data/models/contract.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:jiffy/jiffy.dart';

class InvoiceItem extends StatelessWidget {
  final Invoice invoice;

  // ignore: use_key_in_widget_constructors
  const InvoiceItem({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      color: Constants.darkerColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.62, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Chip(
                label: Text(
                  invoice.invoiceStatus,
                  style: TextStyle(
                    color: invoice.invoiceStatus.toLowerCase() == 'paid'
                        ? const Color(0XFF49B7A5)
                        : invoice.invoiceStatus == 'In process'
                            ? const Color(0xFFFDAB2A)
                            : const Color(0xFFFF426D),
                  ),
                ),
                backgroundColor: invoice.invoiceStatus.toLowerCase() == 'paid'
                    ? const Color(0XFF49B7A5).withOpacity(0.15)
                    : invoice.invoiceStatus == 'In process'
                        ? const Color(0xFFFDAB2A).withOpacity(0.15)
                        : const Color(0xFFF85379).withOpacity(0.15),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                    labelText: 'Name of the service: ',
                    infoText: ' ${invoice.serviceName}'),
                Row(
                  children: [
                    CustomRichText(
                        labelText: 'Amount: ', infoText: ' ${invoice.amount}'),
                    const Spacer(),
                    Text(
                      Jiffy(invoice.createdAt).format('dd.MM.yyyy'),
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
