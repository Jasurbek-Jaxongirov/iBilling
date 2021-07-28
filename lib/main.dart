import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:i_billing/ui/android/contracts_page.dart';
import 'package:i_billing/ui/android/history_page.dart';
import 'package:i_billing/ui/theme/app_constants.dart';
import 'package:i_billing/ui/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme(),
      home: MyHomePage(title: 'iBilling'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var pickedDate = DateTime.now();

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  final pages = <Widget>[
    ContractsPage(),
    HistoryPage(),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Constants.darkestColor,
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Constants.darkestColor,
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Constants.darkestColor,
    ),
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
          backgroundColor: Colors.black,
          title: Container(
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/ellipse.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.032,
                ),
                Text(
                  'Contracts',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0.0),
              icon: SvgPicture.asset(
                'assets/icons/filter-bold.svg',
              ),
            ),
            // IconButton(
            //   onPressed: null,
            //   padding: const EdgeInsets.all(0.0),
            //   icon: SvgPicture.asset(
            //     'assets/icons/line.svg',
            //
            //   ),
            // ),
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
          onTap: (passedIndex) {
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
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
