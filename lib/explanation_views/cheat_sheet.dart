import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/explanation_bloc/explanation_bloc.dart';
import '../number_typing/cross_page_widgets.dart';

class CheatSheetPage extends StatelessWidget {
  const CheatSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ariAppBar(context, 'Cheat Sheet'),
      drawer: aridrawer,
      body: BlocBuilder<ExplanationBloc, ExplanationState>(
          builder: (context, state){
            return const Placeholder();
          }),
    );
  }
}
