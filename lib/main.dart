import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/blocs/invoice/invoice_bloc.dart';
import 'business_logic/blocs/history/history_bloc.dart';
import 'presentation/ui/screens/filters_screen.dart';
import 'business_logic/blocs/contracts/contracts_bloc.dart';
import 'presentation/ui/home.dart';
import 'presentation/ui/theme/app_theme.dart';
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
        fallbackLocale: const Locale('uz'),
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
        ),
        BlocProvider(
          create: (_) => InvoiceBloc()
            ..add(
              LoadInvoices(),
            ),
        ),
        BlocProvider(
          create: (_) => HistoryBloc()
            ..add(
              InitializeHistoryEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'iBilling',
        theme: AppTheme.darkTheme(),
        home: const MyHomePage(title: 'iBilling'),
        routes: {
          FiltersScreen.routeName: (_) => const FiltersScreen(),
        },
      ),
    );
  }
}
