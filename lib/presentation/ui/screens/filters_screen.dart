import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import '/presentation/ui/theme/app_constants.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? isPaid = false;
  bool? isInProcess = false;
  bool? isRejectedByIq = false;
  bool? isRejectedByPayme = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Constants.darkestColor,
      systemNavigationBarColor: Constants.darkestColor,
    ));
    final theme = Theme.of(context);
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
            Row(
              children: [
                Checkbox(
                  value: isPaid,
                  onChanged: (isChecked) {
                    setState(() {
                      isPaid = isChecked;
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
