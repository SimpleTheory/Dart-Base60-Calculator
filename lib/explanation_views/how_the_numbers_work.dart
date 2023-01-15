import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/explanation_bloc/explanation_bloc.dart';
import 'package:sexigesimal_alpha/explanation_views/what_is_base60.dart';
import '../global_bloc/global_bloc.dart';
import '../number_typing/cross_page_widgets.dart';

Column img_list = Column(children: [
  'assets/explanation_pdfs/HowtheNumbersWork/0001.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0002.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0003.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0004.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0005.jpg'
].map((e) => Image.asset(e)).toList());

Column dark_img_list = Column(children: [
  'assets/explanation_pdfs/HowtheNumbersWork/0001_inversion.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0002_inversion.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0003_inversion.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0004_inversion.jpg',
  'assets/explanation_pdfs/HowtheNumbersWork/0005_inversion.jpg'
].map((e) => Image.asset(e)).toList());

class HowTheNumbersWork extends StatelessWidget {
  const HowTheNumbersWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ariAppBar(context, 'How the Numbers Work'),
      drawer: aridrawer,
      body: platform ?
      SingleChildScrollView(
          controller: scrollController,
          child: Column(
              children: [
                BlocBuilder<GlobalBloc, GlobalState>(
                    builder: (context, state) {
                      return state.isDarkMode ? dark_img_list : img_list;
                    }
                ),
                Text('Pop quizzes:'),
                Text('What are each of the numbers below? (use the bases and rules as reference)'),
                Row(children: [
                  Text('20'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('-3'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('45'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('17;30'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('-19;21'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('43,32;0,58,1'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
               Text('Writing Quiz'),
                Row(children: [
                  Text('How would you write this number 45 in this numeric system: (base 15 with 2 lines)'), // 3,3;12
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('How would you write this number 7 in this numeric system: (base 6 with dot)'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                Row(children: [
                  Text('How would you write 61.5 in this numeric system'), // 121
                  BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
              ])

      ) :
      Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                  children: [
                    BlocBuilder<GlobalBloc, GlobalState>(
                      builder: (context, state) {
                        return LayoutBuilder(
                          builder: (buildcon, constraints)=> Padding(
                            padding: MediaQuery.of(context).size.width > 1050 ? EdgeInsets.fromLTRB(250, 10, 250, 10) : EdgeInsets.fromLTRB(36, 10, 36, 10),
                            child: !state.isDarkMode ? img_list : dark_img_list,
                          ),
                        );},
                    ),
                    Text('Pop quizzes:'),
                    Text('What are each of the numbers below? (use the bases and rules as reference)'),
                    Row(children: [
                      Text('20'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('-3'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('45'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('17;30'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('-19;21'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('43,32;0,58,1'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Text('Writing Quiz'),
                    Row(children: [
                      Text('How would you write this number 45 in this numeric system: (base 15 with 2 lines)'), // 3,3;12
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('How would you write this number 7 in this numeric system: (base 6 with dot)'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('How would you write 61.5 in this numeric system'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                  ])

          ),
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 12,
          hoverThickness: 20
      )
    );
  }
}
