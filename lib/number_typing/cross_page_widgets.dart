import 'package:auto_size_text/auto_size_text.dart';
import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base60clock.dart';

BlocBuilder aridrawer =
BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state){
  // listtiles
  // highlight highlight row

  // Map<String, Widget> viewMap = {
  //   'NumberTypingPage': index_view[0],
  //   'DecimalTypingPage': index_view[1],
  //   'WhatIsBase60Page': index_view[2],
  //   'HowTheNumbersWork': index_view[3],
  //   'HowTheAppWorksPage': index_view[4],
  //   'CheatSheetPage': index_view[5],
  //   'SettingsPage': index_view[6]
  // };
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
          onTap: (){
            context.read<GlobalBloc>().add(ChangeView(viewMap['WhatIsBase60Page']!));
            Navigator.pop(context);
          },
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
          onTap: (){
            context.read<GlobalBloc>().add(ChangeView(viewMap['HowTheNumbersWorkPage']!));
            Navigator.pop(context);
          }
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
          onTap: (){
            context.read<GlobalBloc>().add(ChangeView(viewMap['HowTheAppWorksPage']!));
            Navigator.pop(context);
          }
        ),
        ListTile(
          /// Rules Reference
          /// Fractions /60 Reference
          /// All numbers reference
          title: Text('Cheat Sheet'),
          onTap: (){
            context.read<GlobalBloc>().add(ChangeView(viewMap['CheatSheetPage']!));
            Navigator.pop(context);
          }
        ),
        ListTile(
          /// Rules Reference
          /// Fractions /60 Reference
          /// All numbers reference
          title: Text('Settings'),
          onTap: (){
            context.read<GlobalBloc>().add(ChangeView(viewMap['SettingsPage']!));
            Navigator.pop(context);
          }
        ),
      ],
    ),
    //listtiles that are highlighted
  );
});
AppBar ariAppBar(BuildContext context, String title) => AppBar(
  title: AutoSizeText(title),
  toolbarHeight: 55,
  actions: [
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 8, 8),
      child: base60Clock(context),
    )
  ]
);