import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/business_logic/blocs/localize/localize_bloc.dart';
import '/presentation/ui/theme/app_constants.dart';

class LanguageChangeContainer extends StatefulWidget {
  const LanguageChangeContainer({Key? key}) : super(key: key);

  @override
  _LanguageChangeContainerState createState() =>
      _LanguageChangeContainerState();
}

class _LanguageChangeContainerState extends State<LanguageChangeContainer> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LocalizeBloc>(context, listen: false).getlang;
    return Container(
      width: double.infinity,
      height: 44,
      decoration: const BoxDecoration(
        color: Constants.darkColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(bloc == 'uz'
              ? "O'zbek tili"
              : bloc == 'en'
                  ? 'English(USA)'
                  : 'Русский'),
          const Spacer(),
          SvgPicture.asset(
            bloc == 'en'
                ? 'assets/icons/us-flag.svg'
                : bloc == 'uz'
                    ? 'assets/icons/uzbek-flag.svg'
                    : 'assets/icons/rus-flag.svg',
          ),
        ],
      ),
    );
  }
}
