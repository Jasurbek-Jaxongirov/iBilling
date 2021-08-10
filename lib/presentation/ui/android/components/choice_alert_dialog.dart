import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../new_contract.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'new_invoice.dart';
import 'package:easy_localization/easy_localization.dart';

class ChoiceAlertDialog extends StatelessWidget {
  const ChoiceAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Constants.darkColor,
      title: Text(
        'choose-create'.tr(),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [
        MaterialButton(
          color: const Color(0xFF4E4E4E),
          onPressed: () {
            Constants.titles[2] = 'New Contract';
            Constants.pages[2] = const NewsPage();
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/contract-paper.svg'),
              Text(
                'contract'.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        MaterialButton(
          color: const Color(0xFF4E4E4E),
          onPressed: () {
            Constants.pages[2] = const NewInvoice();
            Constants.titles[2] = 'New Invoice';
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/invoice-paper.svg'),
              Text(
                'invoice'.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
