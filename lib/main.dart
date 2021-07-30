import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/ui/home.dart';
import '/blocs/contracts_bloc/contracts_bloc_bloc.dart';
import '/ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ContractsBlocBloc()
            ..add(
              LoadContractsEvent(),
            ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iBilling',
        theme: AppTheme.darkTheme(),
        home: const MyHomePage(title: 'iBilling'),
      ),
    );
  }
}
