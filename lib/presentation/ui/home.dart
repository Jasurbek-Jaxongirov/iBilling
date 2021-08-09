import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/ui/screens/filters_screen.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

import 'android/components/choice_alert_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var pickedDate = DateTime.now();

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  List<String> titles = [
    'contract'.tr(),
    'history'.tr(),
    'news'.tr(),
    'saved'.tr(),
    'profile'.tr()
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Constants.darkestColor,
      systemNavigationBarColor: Constants.darkestColor,
    ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(fontSize: 18, color: Colors.white),
          backgroundColor: Constants.darkestColor,
          title: Row(
            children: [
              Image.asset(
                'assets/icons/ellipse.png',
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.032,
              ),
              Text(
                titles[_index],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          actions: _index == 2 || _index == 4
              ? []
              : [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(FiltersScreen.routeName);
                    },
                    padding: const EdgeInsets.all(0.0),
                    icon: SvgPicture.asset(
                      'assets/icons/filter-bold.svg',
                    ),
                  ),
                  Center(
                    child: Text(
                      '|',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/zoom.svg',
                    ),
                  ),
                ],
        ),
        body: Constants.pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Constants.darkestColor,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color(0XFFA6A6A6),
          selectedItemColor: const Color(0XFFF2F2F2),
          currentIndex: _index,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (passedIndex) async {
            if (passedIndex == 2) {
              await showDialog(
                useSafeArea: true,
                barrierDismissible: false,
                barrierColor: const Color(0xFF0C0C0C).withOpacity(0.8),
                context: context,
                builder: (ctx) {
                  return const ChoiceAlertDialog();
                },
              );
            }
            setState(() {
              _index = passedIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'contract'.tr(),
              icon: SvgPicture.asset(
                _index == 0
                    ? 'assets/icons/contracts-bold.svg'
                    : 'assets/icons/contracts-light.svg',
              ),
              tooltip: 'Contracts',
            ),
            BottomNavigationBarItem(
              label: 'history'.tr(),
              icon: SvgPicture.asset(
                _index == 1
                    ? 'assets/icons/time-circle-bold.svg'
                    : 'assets/icons/time-circle-light.svg',
              ),
              tooltip: 'History',
            ),
            BottomNavigationBarItem(
              label: 'news'.tr(),
              icon: SvgPicture.asset(
                _index == 2
                    ? 'assets/icons/plus-bold.svg'
                    : 'assets/icons/plus-light.svg',
              ),
              tooltip: 'News',
            ),
            BottomNavigationBarItem(
              label: 'saved'.tr(),
              icon: SvgPicture.asset(_index == 3
                  ? 'assets/icons/bookmark-bold.svg'
                  : 'assets/icons/bookmark-light.svg'),
            ),
            BottomNavigationBarItem(
                label: 'profile'.tr(),
                icon: SvgPicture.asset(
                  _index == 4
                      ? 'assets/icons/profile-bold.svg'
                      : 'assets/icons/profile-light.svg',
                )),
          ],
        ),
      ),
    );
  }
}
