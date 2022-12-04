import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ],
      child: MaterialApp(
          title: 'Base60',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            primaryTextTheme: Typography().black,
            textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.black)
            ),
            primaryColor: Colors.black,
            primarySwatch: Colors.blue,
          ),
          // Wrap page with correct bloc provider
          home: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state){return state.currentView;},
          )
      ),
    );
  }
}


BlocBuilder aridrawer =
BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state){
  // listtiles
  // highlight highlight row

  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(child: Center(child: Text('Sexagesimal App', style: TextStyle(fontSize: 30),))),
        ListTile(
          title: Text('Calculator', style: TextStyle(fontSize: 20)),
          onTap: () {
            context.read<GlobalBloc>().add(ChangeView(state.calculatorView));
            Navigator.pop(context);
          },
        ),
        ListTile(
          /// TOC
          /// What is Base60
          ///   How base60 works:
          ///   Explain how decimal works
          ///     - The places and what they mean (by putting them in boxes and summing them together (11 as example and 11.1))
          ///   Base60 Given the Above (61 & convert 11.1 -> 11;6)
          ///   Trying to write base60 with decimal numbers (disaster hence made numbers)
          ///
          /// Why Base60
          ///   Disadvantages of decimal
          ///   Advantages of base 60
          ///     factors, decimal precision and measurement systems as a result
          ///
          title: Text('What is Base 60 and why use it?'),
        ),
        ListTile(
          /// Foundations:
          /// TOC
          ///   Rules: (Give an example for each)
          ///     Base symbols
          ///     Added one
          ///     What lines mean
          ///     What sub-notation means
          ///     What they mean together (valid sub-notes?)
          ///     Negative, period and 58/59 Exceptions
          ///     Reading 0<=numbers<=59 as a result
          ///     Reading other numbers by example
          ///   Writing tips:
          ///     What do these numbers represent given these rules (fractions)
          ///     (hence instantly useful for writing decimals)?
          ///     Write the numbers by think of the fractional representation of 60
          ///
          ///   Practice Reading, Writing and Converting
          ///
          title: Text('How the Numbers Work'),
        ),
        ListTile(
          /// App Mechanics:
          ///   Different Pages:
          ///     Appbar navigation and clock
          ///     How the calculator works,
          ///       - How the number typing works
          ///       - Different Calculator Functions
          ///     Other pages are explanation pages
          ///
          ///   Philosophy of the app:
          ///     Staying pure to the numbers
          ///     (mention exceptions and how they are ok)
          ///
          ///   For Developers and Resources:
          ///     (cross-platform download links)?
          ///     opensource - github repo link TODO: come up with license
          ///     [can potentially be used for other bases but the code isn't very
          ///     organized and I make to promises to maintain or update it since this was a test app]
          ///     (youtube link?)
          ///
          title: Text('How the App Works'),
        ),
        ListTile(
          /// Rules Reference
          /// Fractions /60 Reference
          /// All numbers reference
          title: Text('Cheat Sheet'),
        ),
      ],
    ),
    //listtiles that are highlighted
  );
});
