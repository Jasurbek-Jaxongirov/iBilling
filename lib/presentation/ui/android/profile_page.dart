import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/data/models/user.dart';
import '/presentation/ui/android/components/profile_container.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'components/language_change_container.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var languageGroup = '';
    final initialLang = context.locale;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Constants.darkestColor,
      ),
      child: Column(
        children: [
          ProfileContainer(
            user: User(
                userId: DateTime.now().toString(),
                firstName: 'Otabek',
                lastName: 'Abdusamatov',
                dateOfBirth: DateTime(2001, 09, 16),
                phoneNumber: '+998 97 721 06 88',
                email: 'predatorhunter041@gmail.com'),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
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
                            leading:
                                SvgPicture.asset('assets/icons/uzbek-flag.svg'),
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
                            leading:
                                SvgPicture.asset('assets/icons/rus-flag.svg'),
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
                            leading:
                                SvgPicture.asset('assets/icons/us-flag.svg'),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
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
            child: const LanguageChangeContainer(),
          ),
        ],
      ),
    );
  }
}
