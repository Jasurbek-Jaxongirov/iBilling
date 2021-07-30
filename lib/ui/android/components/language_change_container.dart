import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/theme/app_constants.dart';

class LanguageChangeContainer extends StatefulWidget {
  const LanguageChangeContainer({Key? key}) : super(key: key);

  @override
  _LanguageChangeContainerState createState() =>
      _LanguageChangeContainerState();
}

class _LanguageChangeContainerState extends State<LanguageChangeContainer> {
  String langType = 'en';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
          // barrierDismissible: false,
          barrierColor: const Color(0xFF0C0C0C).withOpacity(0.8),
          context: context,
          builder: (ctx) {
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
                      setState(() {
                        langType = 'uz';
                      });
                    },
                    leading: SvgPicture.asset('assets/icons/uzbek-flag.svg'),
                    title: Text(
                      'O‘zbek (Lotin)',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Radio(
                      value: 'uz',
                      groupValue: langType,
                      onChanged: (language) {
                        setState(() {
                          langType = language as String;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        langType = 'ru';
                      });
                    },
                    leading: SvgPicture.asset('assets/icons/rus-flag.svg'),
                    title: Text(
                      'Русский',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Radio(
                      value: 'ru',
                      groupValue: langType,
                      onChanged: (language) {
                        setState(() {
                          langType = language as String;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        langType = 'en';
                      });
                    },
                    leading: SvgPicture.asset('assets/icons/us-flag.svg'),
                    title: Text(
                      'English (USA)',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Radio(
                      value: 'en',
                      groupValue: langType,
                      onChanged: (language) {
                        setState(() {
                          langType = language as String;
                        });
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
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Constants.darkGreenColor)),
                  onPressed: () {},
                  child: const Text('Done'),
                ),
              ],
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
