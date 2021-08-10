import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Constants.darkestColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/bookmark-big.svg',
            color: const Color(0xFFF9F9F9),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'empty-contract'.tr(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
