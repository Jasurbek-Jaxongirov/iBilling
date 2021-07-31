import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/android/news_page.dart';
import '/ui/android/contracts_page.dart';
import '/ui/android/history_page.dart';
import '/ui/android/profile_page.dart';
import '/ui/theme/app_constants.dart';
import 'android/saved_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var pickedDate = DateTime.now();

class _MyHomePageState extends State<MyHomePage> {
  final _titles = ['Contracts', 'History', 'News', 'Saved', 'Profile'];
  var _index = 0;
  final pages = <Widget>[
    ContractsPage(),
    const HistoryPage(),
    const NewsPage(),
    const SavedPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Constants.darkestColor,
      systemNavigationBarColor: Constants.darkestColor,
    ));
    print(DateTime.now().toString());
    final customDateTime = DateTime.parse('2021-07-30 10:52:55.927277');
    print(customDateTime.weekday);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(fontSize: 18, color: Colors.white),
          backgroundColor: Colors.black,
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
                _titles[_index],
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
                    onPressed: () {},
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
        body: pages[_index],
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
                    return AlertDialog(
                      titlePadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      actionsPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
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
                              SvgPicture.asset(
                                  'assets/icons/contract-paper.svg'),
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
                              SvgPicture.asset(
                                  'assets/icons/invoice-paper.svg'),
                              Text(
                                'Invoice',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }

            setState(() {
              _index = passedIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Contracts',
              icon: _index == 0
                  ? SvgPicture.asset(
                      'assets/icons/contracts-bold.svg',
                      color: const Color(0XFFF2F2F2),
                    )
                  : SvgPicture.asset(
                      'assets/icons/contracts-light.svg',
                      color: const Color(0XFFA6A6A6),
                    ),
              tooltip: 'Contracts',
            ),
            BottomNavigationBarItem(
              label: 'History',
              icon: _index == 1
                  ? SvgPicture.asset(
                      'assets/icons/time-circle-bold.svg',
                      color: const Color(0XFFF2F2F2),
                    )
                  : SvgPicture.asset(
                      'assets/icons/time-circle-light.svg',
                      color: const Color(0XFFA6A6A6),
                    ),
              tooltip: 'History',
            ),
            BottomNavigationBarItem(
              label: 'News',
              icon: _index == 2
                  ? SvgPicture.asset(
                      'assets/icons/plus-bold.svg',
                      color: const Color(0XFFF2F2F2),
                    )
                  : SvgPicture.asset(
                      'assets/icons/plus-light.svg',
                      color: const Color(0XFFA6A6A6),
                    ),
              tooltip: 'News',
            ),
            BottomNavigationBarItem(
              label: 'Saved',
              icon: _index == 3
                  ? SvgPicture.asset(
                      'assets/icons/bookmark-bold.svg',
                      color: const Color(0XFFF2F2F2),
                    )
                  : SvgPicture.asset(
                      'assets/icons/bookmark-light.svg',
                      color: const Color(0XFFA6A6A6),
                    ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: _index == 4
                  ? SvgPicture.asset(
                      'assets/icons/profile-bold.svg',
                      color: const Color(0XFFF2F2F2),
                    )
                  : SvgPicture.asset(
                      'assets/icons/profile-light.svg',
                      color: const Color(0XFFA6A6A6),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
