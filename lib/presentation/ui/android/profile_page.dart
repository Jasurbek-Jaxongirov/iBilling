import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '/business_logic/blocs/localize/localize_bloc.dart';
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
    final bloc = BlocProvider.of<LocalizeBloc>(context);
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
          BlocConsumer<LocalizeBloc, LocalizeState>(
            listener: (context, state) async {
              if (state is LocalizingState) {
                await showDialog(
                    barrierDismissible: true,
                    barrierColor: const Color(0xFF0C0C0C).withOpacity(0.8),
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.all(2),
                        actionsPadding: const EdgeInsets.all(2),
                        titlePadding: const EdgeInsets.all(15),
                        backgroundColor: Constants.darkColor,
                        title: Text(
                          'choose-lang'.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        actions: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  // context.setLocale(const Locale('uz'));

                                  languageGroup = 'uz';
                                  bloc.setlang = languageGroup;
                                  Navigator.of(ctx).pop();
                                  bloc.add(LocalizationEvent());
                                },
                                leading: SvgPicture.asset(
                                    'assets/icons/uzbek-flag.svg'),
                                title: Text(
                                  'O‘zbek (Lotin)',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                trailing: Radio(
                                  value: 'uz',
                                  groupValue: bloc.getlang,
                                  onChanged: (language) {},
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  // context.setLocale(const Locale('ru'));

                                  languageGroup = 'ru';
                                  bloc.setlang = languageGroup;
                                  Navigator.of(ctx).pop();
                                  bloc.add(LocalizationEvent());
                                },
                                leading: SvgPicture.asset(
                                    'assets/icons/rus-flag.svg'),
                                title: Text(
                                  'Русский',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                trailing: Radio(
                                  value: 'ru',
                                  groupValue: bloc.getlang,
                                  onChanged: (language) {},
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  languageGroup = 'en';

                                  bloc.setlang = languageGroup;
                                  Navigator.of(ctx).pop();
                                  bloc.add(LocalizationEvent());
                                },
                                leading: SvgPicture.asset(
                                    'assets/icons/us-flag.svg'),
                                title: Text(
                                  'English (USA)',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                trailing: Radio(
                                  value: 'en',
                                  groupValue: bloc.getlang,
                                  onChanged: (language) {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                minWidth: MediaQuery.of(ctx).size.width * 0.3,
                                color:
                                    Constants.darkGreenColor.withOpacity(0.3),
                                onPressed: () {
                                  bloc.setlang = initialLang.languageCode;
                                  context.setLocale(initialLang);

                                  Navigator.of(ctx).pop();
                                },
                                child: Text(
                                  'cancel'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Constants.darkGreenColor),
                                ),
                              ),
                              MaterialButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                minWidth: MediaQuery.of(ctx).size.width * 0.3,
                                color: Constants.darkGreenColor,
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  if (bloc.getlang == 'en') {
                                    context.setLocale(const Locale('en', 'US'));
                                  }
                                  if (bloc.getlang == 'ru') {
                                    context.setLocale(const Locale(
                                      'ru',
                                    ));
                                  }
                                  if (bloc.getlang == 'uz') {
                                    context.setLocale(const Locale(
                                      'uz',
                                    ));
                                  }
                                },
                                child: Text(
                                  'done'.tr(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    });
              }
            },
            builder: (_, state) => InkWell(
              onTap: () {
                bloc.add(LocalizationEvent());
              },
              child: LanguageChangeContainer(),
            ),
          ),
        ],
      ),
    );
  }
}
