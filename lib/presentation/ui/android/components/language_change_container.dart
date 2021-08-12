import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageChangeContainer extends StatefulWidget {
  const LanguageChangeContainer({Key? key}) : super(key: key);

  @override
  _LanguageChangeContainerState createState() =>
      _LanguageChangeContainerState();
}

class _LanguageChangeContainerState extends State<LanguageChangeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: const BoxDecoration(
        color: Constants.darkColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text('lang'.tr() == 'Ingliz tili (AQSh)'
              ? "O'zbek tili"
              : 'lang'.tr() == 'English(USA)'
                  ? 'English(USA)'
                  : 'Русский'),
          const Spacer(),
          SvgPicture.asset(
            'lang'.tr() == 'English(USA)'
                ? 'assets/icons/us-flag.svg'
                : 'lang'.tr() == 'Ingliz tili (AQSh)'
                    ? 'assets/icons/uzbek-flag.svg'
                    : 'assets/icons/rus-flag.svg',
          ),
        ],
      ),
    );
  }
}
