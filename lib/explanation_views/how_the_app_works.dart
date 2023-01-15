import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/explanation_bloc/explanation_bloc.dart';
import 'package:sexigesimal_alpha/explanation_views/what_is_base60.dart';
import 'package:url_launcher/link.dart';
import '../global_bloc/global_bloc.dart';
import '../number_typing/cross_page_widgets.dart';

Column img_list = Column(children: [
  'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0001.jpg',
  'assets/imgs/calc_labeled.png',
  'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0002.jpg',
  'assets/imgs/keyboard_use_example.gif',
  'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0003.jpg',
  'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0004.jpg',
].map((e) => Image.asset(e)).toList(),);

Column dark_img_list = Column(children: [
      'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0001_inversion.jpg',
      'assets/imgs/calc_labeled.png',
      'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0002_inversion.jpg',
      'assets/imgs/keyboard_use_example.gif',
      'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0003_inversion.jpg',
      'assets/explanation_pdfs/HowtheAppWork/how the app works_page-0004_inversion.jpg',
].map((e) => Image.asset(e)).toList(),);

class HowTheAppWorksPage extends StatelessWidget {
  const HowTheAppWorksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ariAppBar(context, 'How the App Works'),
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
                Text('Resources:'),
                Link(
                    uri: Uri.parse('https://github.com/SimpleTheory/Dart-Base60-Calculator'),
                    target: LinkTarget.blank,
                    builder: (BuildContext context, FollowLink? followLink) =>
                        ElevatedButton(
                            onPressed: followLink, child: Text('GitHub'))
                ),]

      )) :
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
                    Text('Resources:'),
                    Text('Windows Download: '),
                    Text('Android Download: '),
                    Link(
                        uri: Uri.parse('https://github.com/SimpleTheory/Dart-Base60-Calculator'),
                        target: LinkTarget.blank,
                        builder: (BuildContext context, FollowLink? followLink) =>
                            ElevatedButton(
                                onPressed: followLink, child: Text('GitHub'))
                    ),
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
