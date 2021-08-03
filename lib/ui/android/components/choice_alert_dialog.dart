import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/ui/theme/app_constants.dart';

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
        'What would you like to create?',
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
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/contract-paper.svg'),
              Text(
                'Contract',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        MaterialButton(
          color: const Color(0xFF4E4E4E),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/invoice-paper.svg'),
              Text(
                'Invoice',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}