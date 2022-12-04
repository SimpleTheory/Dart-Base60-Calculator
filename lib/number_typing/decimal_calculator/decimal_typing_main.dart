// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
// import 'decimal_typing_page.dart';
//
// class DecimalTyping extends StatelessWidget {
//   const DecimalTyping({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: globalBloc,
//       child: BlocBuilder<GlobalBloc, GlobalState>(
//         builder: (context, state) {
//           return MaterialApp(
//             title: 'Base60',
//             debugShowCheckedModeBanner: false,
//             themeMode: ThemeMode.system,
//             darkTheme: ThemeData.dark(),
//             theme: ThemeData(
//               primaryTextTheme: Typography().black,
//               textTheme: TextTheme(
//                   bodyText2: TextStyle(color: Colors.black)
//               ),
//               primaryColor: Colors.black,
//               primarySwatch: Colors.blue,
//             ),
//             // Wrap page with correct bloc provider
//             home: BlocProvider.value(
//                 value: state.decimalBloc,
//                 child: DecimalTypingPage()), //TODO
//           );
//         },
//       ),
//     );
//   }
// }
