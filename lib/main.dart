import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/explanation_bloc/explanation_bloc.dart';
import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/bloc/number_typing_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_calculator_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GlobalBloc()),
        BlocProvider(create: (context) => NumberTypingBloc()),
        BlocProvider(create: (context) => DecimalCalculatorBloc()),
        BlocProvider(create: (context) => ExplanationBloc())
      ],
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Base60',
              debugShowCheckedModeBanner: false,
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              // active theme
              darkTheme: ThemeData.dark(),
              theme: ThemeData(
                // primaryTextTheme: Typography().black,
                // textTheme: TextTheme(
                //   displayLarge: TextStyle(color: Colors.black),
                //   displayMedium: TextStyle(color: Colors.black),
                //   displaySmall: TextStyle(color: Colors.black),
                // ),
                // primaryColor: Colors.black,
                // primarySwatch: Colors.blue,
              ),
              // Wrap page with correct bloc provider
              home: state.currentView);
                },
              )
          );
        }
  }



