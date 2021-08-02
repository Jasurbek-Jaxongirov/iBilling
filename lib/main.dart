import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/contracts/contracts_bloc.dart';
import '/ui/home.dart';
import '/ui/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('uz'),
          Locale('en', 'US'),
          Locale('ru')
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        // fallbackLocale: const Locale('ru'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ContractsBloc()
            ..add(
              LoadContracts(),
            ),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'iBilling',
        theme: AppTheme.darkTheme(),
        home: const MyHomePage(title: 'iBilling'),
      ),
    );
  }
}
