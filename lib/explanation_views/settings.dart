import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/explanation_bloc/explanation_bloc.dart';
import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
import '../number_typing/cross_page_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  addEventDarkMode(BuildContext context) => context.read<GlobalBloc>().add(ChangeDarkMode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ariAppBar(context, 'Settings'),
      drawer: aridrawer,
      body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Dark Mode'),
                    BlocBuilder<GlobalBloc, GlobalState>(
                      builder: (context, state) {
                      return Switch(value: state.isDarkMode, onChanged: (a)=> addEventDarkMode(context));
  },
)
                  ],
                )
              ],
            )
      );
    }
  }
