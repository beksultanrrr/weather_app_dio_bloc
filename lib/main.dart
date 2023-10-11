import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_theme.dart';

import 'package:weather_app/screens/main/bloc/main_bloc.dart';
import 'package:weather_app/screens/main/home_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainBloc()..add(InitialMainEvent())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme().data,
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
