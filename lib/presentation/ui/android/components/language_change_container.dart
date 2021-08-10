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
  var languageGroup = '';
  @override
  Widget build(BuildContext context) {
    final initialLang = context.locale;
    return GestureDetector(
      onTap: () async {
        await showDialog(
            barrierDismissible: true,
            barrierColor: const Color(0xFF0C0C0C).withOpacity(0.8),
            context: context,
            builder: (ctx) {
              return AlertDialog(
                clipBehavior: Clip.hardEdge,
                contentPadding: const EdgeInsets.all(2),
                actionsPadding: const EdgeInsets.all(2),
                titlePadding: const EdgeInsets.all(15),
                backgroundColor: Constants.darkColor,
                title: Text(
                  'choose-lang'.tr(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        context.setLocale(const Locale('uz'));
                        setState(() {
                          languageGroup = 'uz';
                        });
                      },
                      leading: SvgPicture.asset('assets/icons/uzbek-flag.svg'),
                      title: Text(
                        'O‘zbek (Lotin)',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: Radio(
                        value: 'uz',
                        groupValue: languageGroup,
                        onChanged: (language) {},
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.setLocale(const Locale('ru'));
                        setState(() {
                          languageGroup = 'ru';
                        });
                      },
                      leading: SvgPicture.asset('assets/icons/rus-flag.svg'),
                      title: Text(
                        'Русский',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: Radio(
                        value: 'ru',
                        groupValue: languageGroup,
                        onChanged: (language) {},
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.setLocale(const Locale('en', 'US'));
                        setState(() {
                          languageGroup = 'en';
                        });
                      },
                      leading: SvgPicture.asset('assets/icons/us-flag.svg'),
                      title: Text(
                        'English (USA)',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: Radio(
                        value: 'en',
                        groupValue: languageGroup,
                        onChanged: (language) {},
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Constants.darkGreenColor)),
                    onPressed: () {
                      languageGroup = '';

                      context.setLocale(initialLang);
                      Navigator.of(ctx).pop();
                    },
                    child: Text('cancel'.tr()),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Constants.darkGreenColor)),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('done'.tr()),
                  ),
                ],
              );
            });
      },
      child: Container(
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
      ),
    );
  }
}
