import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/ui/theme/app_constants.dart';
import '/business_logic/blocs/localization/localization_bloc.dart';
// import 'package:easy_localization/easy_localization.dart';

class LanguageChangeContainer extends StatelessWidget {
  const LanguageChangeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LocalizationBloc>(context);
    return GestureDetector(
      onTap: () async {
        await showDialog(
          barrierDismissible: false,
          barrierColor: const Color(0xFF0C0C0C).withOpacity(0.8),
          context: context,
          builder: (ctx) {
            return BlocBuilder<LocalizationBloc, LocalizationState>(
              builder: (_, state) {
                if (state is LocalizationInitial ||
                    state is LocalizingState ||
                    state is LocalizedState) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    actionsPadding: const EdgeInsets.all(28),
                    backgroundColor: Constants.darkColor,
                    title: Text(
                      'Choose a language',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            bloc.setContext = context;
                            bloc.setLanguageCode = 'uz';
                            bloc.setCountryCode = '';
                            bloc.add(LocalizeEvent(
                                countryCode: bloc.getCountryCode,
                                languageCode: bloc.getLanguageCode));
                          },
                          leading:
                              SvgPicture.asset('assets/icons/uzbek-flag.svg'),
                          title: Text(
                            'O‘zbek (Lotin)',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          trailing: Radio(
                            value: 'uz',
                            groupValue: bloc.getLanguageCode,
                            onChanged: (language) {
                              bloc.radioValue = language as String;
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            bloc.setContext = context;
                            bloc.setLanguageCode = 'ru';
                            bloc.setCountryCode = '';
                            bloc.add(LocalizeEvent(
                                countryCode: bloc.getCountryCode,
                                languageCode: bloc.getLanguageCode));
                          },
                          leading:
                              SvgPicture.asset('assets/icons/rus-flag.svg'),
                          title: Text(
                            'Русский',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          trailing: Radio(
                            value: 'ru',
                            groupValue: bloc.getLanguageCode,
                            onChanged: (language) {
                              bloc.radioValue = language as String;
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            bloc.setContext = context;
                            bloc.setLanguageCode = 'en';
                            bloc.setCountryCode = 'US';
                            bloc.add(LocalizeEvent(
                                countryCode: bloc.getCountryCode,
                                languageCode: bloc.getLanguageCode));
                          },
                          leading: SvgPicture.asset('assets/icons/us-flag.svg'),
                          title: Text(
                            'English (USA)',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          trailing: Radio(
                            value: 'en',
                            groupValue: bloc.getLanguageCode,
                            onChanged: (language) {
                              bloc.radioValue = language as String;
                            },
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
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Constants.darkGreenColor)),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Done'),
                      ),
                    ],
                  );
                } else if (state is FailedToLocalizeState) {
                  Navigator.of(ctx).pop();
                  return const Center(
                    child: Text('Internal error occured'),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        );
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
            const Text('English(USA)'),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/us-flag.svg',
            ),
          ],
        ),
      ),
    );
  }
}
