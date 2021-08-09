import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/ui/android/components/custom_checkbox_button.dart';
import '/presentation/ui/theme/app_constants.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isPaid = false;
  bool isInProcess = false;
  bool isRejectedByIq = false;
  bool isRejectedByPayme = false;

  Future<void> _showDialog() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().add(const Duration(days: 365)).year),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Constants.darkestColor,
      systemNavigationBarColor: Constants.darkestColor,
    ));
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'filter'.tr(),
          style:
              theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Constants.darkestColor,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status',
              style: theme.textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPaid = !isPaid;
                    });
                  },
                  child: CustomCheckboxButton(
                    width: (mediaQuery.size.width - 32) * 0.4,
                    buttonText: 'Paid',
                    isChecked: isPaid,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isRejectedByIq = !isRejectedByIq;
                    });
                  },
                  child: CustomCheckboxButton(
                    width: (mediaQuery.size.width - 32) * 0.6,
                    buttonText: 'Rejected by IQ',
                    isChecked: isRejectedByIq,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isInProcess = !isInProcess;
                    });
                  },
                  child: CustomCheckboxButton(
                    width: (mediaQuery.size.width - 32) * 0.4,
                    buttonText: 'In process',
                    isChecked: isInProcess,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    isRejectedByPayme = !isRejectedByPayme;
                    setState(() {});
                  },
                  child: CustomCheckboxButton(
                    width: (mediaQuery.size.width - 32) * 0.6,
                    buttonText: 'Rejected by Payme',
                    isChecked: isRejectedByPayme,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Date'),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: mediaQuery.size.width * 0.40,
                  child: MaterialButton(
                    color: Constants.darkColor,
                    onPressed: _showDialog,
                    child: Row(
                      children: [
                        Text(
                          'From ',
                          style: theme.textTheme.bodyText1,
                        ),
                        const Spacer(),
                        SvgPicture.asset('assets/icons/calendar-bold.svg')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaQuery.size.width * 0.02),
                  child: const Text(
                    ' - ',
                    style: TextStyle(
                        color: Color(0XFFD1D1D1), fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.40,
                  child: MaterialButton(
                    color: Constants.darkColor,
                    onPressed: _showDialog,
                    child: Row(
                      children: [
                        Text('To ', style: theme.textTheme.bodyText1),
                        const Spacer(),
                        SvgPicture.asset('assets/icons/calendar-bold.svg')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                MaterialButton(
                  minWidth: (mediaQuery.size.width - 32) * 0.45,
                  color: const Color(0xFF008F7F).withOpacity(0.5),
                  onPressed: () {},
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: Constants.darkGreenColor,
                    ),
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  minWidth: (mediaQuery.size.width - 32) * 0.45,
                  color: const Color(0xFF008F7F),
                  onPressed: () {},
                  child: Text(
                    'Apply Filters',
                    style: theme.textTheme.bodyText1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
