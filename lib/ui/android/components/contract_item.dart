import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/ui/theme/app_constants.dart';

class ContractItem extends StatelessWidget {
  final int lastInvoice;
  final String contractStatus;

  // ignore: use_key_in_widget_constructors
  const ContractItem(
      {Key? key, required this.lastInvoice, required this.contractStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 148,
      color: Constants.darkerColor,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/paper.svg'),
              Text('№ $lastInvoice'),
              Spacer(),
              Chip(
                label: Text(
                  contractStatus,
                  style: const TextStyle(
                    color: Color(0XFF49B7A5),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
