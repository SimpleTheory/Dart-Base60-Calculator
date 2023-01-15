import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/explanation_bloc/explanation_bloc.dart';
// import 'package:pdfx/pdfx.dart';
import '../global_bloc/global_bloc.dart';
import '../number_typing/cross_page_widgets.dart';

Column img_list = Column(
    children: [
  'assets/explanation_pdfs/WhatisBase60/0001.jpg',
  'assets/explanation_pdfs/WhatisBase60/0002.jpg',
  'assets/explanation_pdfs/WhatisBase60/0003.jpg',
  'assets/explanation_pdfs/WhatisBase60/0004.jpg',
  'assets/explanation_pdfs/WhatisBase60/0005.jpg',
    ].map((e) => Image.asset(e)).toList());
Column dark_img_list = Column(
    children: [
      'assets/explanation_pdfs/WhatisBase60/0001_inversion.jpg',
      'assets/explanation_pdfs/WhatisBase60/0002_inversion.jpg',
      'assets/explanation_pdfs/WhatisBase60/0003_inversion.jpg',
      'assets/explanation_pdfs/WhatisBase60/0004_inversion.jpg',
      'assets/explanation_pdfs/WhatisBase60/0005_inversion.jpg',
    ].map((e) => Image.asset(e)).toList());

bool isMobile(){
  try {
    return Platform.isAndroid || Platform.isIOS;
  }
  catch(e){
    return false;
  }
}
bool platform = isMobile();
final ScrollController scrollController = ScrollController();
// TextStyle? eleven_style(context) => Theme.of(context).textTheme.displayMedium?.copyWith(fontStyle: FontStyle.italic, fontSize: Theme.of(context).textTheme.displayMedium!.fontSize! * 1.5, decoration: TextDecoration.underline);


// class WhatIsBase60Page extends StatelessWidget {
//   const WhatIsBase60Page({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: ariAppBar(context, 'What is base 60 and why use it?'),
//         drawer: aridrawer,
//         body: BlocBuilder<ExplanationBloc, ExplanationState>(
//         builder: (context, state){
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(40.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AutoSizeText('What is Base 60?',
//                     style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400), maxLines: 1,
//                     minFontSize: 40,
//                   ),
//                   AutoSizeText.rich(
//                       TextSpan(
//                           text: 'In short Base 60 is a counting system that uses 60 as'
//                           ' a base around which the numbers revolve. In order to '
//                           'understand this, it’d be best to see how we currently '
//                           'count in base 10. Take this number for instance: \n',
//                       ),
//                     maxLines: 6,
//                     style: Theme.of(context).textTheme.displaySmall,
//                     overflow: TextOverflow.visible,
//                   ),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AutoSizeText('1', style: eleven_style(context), minFontSize: 30),
//                         SizedBox(width: 6),
//                         AutoSizeText('1', style: eleven_style(context), minFontSize: 30)]
//               ),
//                   AutoSizeText.rich(
//                     TextSpan(
//                       children: [
//                     TextSpan(text: 'We understand that this is eleven because there is a ', style: Theme.of(context).textTheme.displaySmall),
//                     TextSpan(text: '1', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontStyle: FontStyle.italic)),
//                     TextSpan(text: ' in the ', style: Theme.of(context).textTheme.displaySmall),
//                     TextSpan(text: '1s', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
//                     TextSpan(text: ' place, and a ', style: Theme.of(context).textTheme.displaySmall),
//                     TextSpan(text: '1', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontStyle: FontStyle.italic)),
//                     TextSpan(text: ' in the ', style: Theme.of(context).textTheme.displaySmall),
//                     TextSpan(text: '10s', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
//                     TextSpan(text: ' place.', style: Theme.of(context).textTheme.displaySmall),
//                   ]),
//                     maxLines: 2,
//                   ),
//                   // Placeholder(),
//
//
//             ]
//           )
//         )
//       );
//
//     }),
//     );
//   }
// }
//TODO CROP IMAGES SYSTEMATICALLY
class WhatIsBase60Page extends StatelessWidget {
  WhatIsBase60Page({Key? key}) : super(key: key);

  // final pdfPinchController = PdfController(document: PdfDocument.openAsset('/explanation_pdfs/WhatisBase60.pdf'));

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: ariAppBar(context, 'What is base 60 and why use it?'),
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
              Row(children: [
                Text('What does 2,1 in Base60 represent?'), // 121
                BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
              Row(children: [
                Text('Try translate "183.2" to base 60'), // 3,3;12
                BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
              Row(children: [
                Text('Try translate "6,6;20" to base 10'),
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
                    Row(children: [
                      Text('What does 2,1 in Base60 represent?'), // 121
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('Try translate "183.2" to base 60'), // 3,3;12
                      BlocBuilder<ExplanationBloc, ExplanationState>(builder: (context, state)=>Placeholder())],),
                    Row(children: [
                      Text('Try translate "6,6;20" to base 10'),
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
// class WhatIsBase60Page extends StatelessWidget {
//   WhatIsBase60Page({Key? key}) : super(key: key);
//
//   final pdfPinchController = PdfController(document: PdfDocument.openAsset('/explanation_pdfs/WhatisBase60.pdf'));
//
//   @override
//   Widget build(BuildContext context) {
//       return Scaffold(
//       appBar: ariAppBar(context, 'What is base 60 and why use it?'),
//       drawer: aridrawer,
//       body: PdfView(controller: pdfPinchController, pageSnapping: false, scrollDirection: Axis.vertical)
//       );
//   }
// }

/*

Thus yielding one 10 and one 1, so that is 10 + 1 which is 11.
The 10 in this case is the base number used to count all number so 111 would be

Likewise Base60 just means that if you had the number 11 that would be 61, because you have a 1 in the 60s place and a 1 in the ones place

Pop Quiz: Given this same logic tell me what 21 is in Base60 => 121 (2 in the 60s place and 1 in the 1s place)

In base 10 you have ten digits {0 1 2 3 4 5 6 7 8 9} that you use to count up to 10 which is 1 in the tens place and 0 in the 1s place, thus restarting the cycle.
However in Base60 you would need {0…59} for a total of 60 digits to do this, yet you will notice that 59 takes up two places so it can’t be a digit by itself,
otherwise you will get a number like (10)(30) which together looks like 1030. To get around this the modern way of counting base60 uses some kind of delimiter to separate
when one digit begins and another one ends.
Kind of like this:
2,14 this means (2) in the 60s place and (14) in the ones place yielding 134 (in this system , is used as a digit delimiter and a ; is used as a decimal place which is explained further below)
I find this way of writing Base60 numbers very hard to read, thus I created this numeric system.

Decimals in Base60 work much in the same way they do in Base10 for instance
1.123 is the same as saying 1 + 123/1000. How it works is that fractions are represented over the nearest multiple of 10 in the denominator.
So the fraction ¼ is represented as .25 because ¼’s nearest fractional representation as a multiple of 10 is 25/100. You can do something like this 0.250 and it will be the same because in the end you get 250/1000 which reduces to 25/100 which reduces to ¼ .
Base10:  1 / 4  = 0.25 = 25/100
In that same vein decimals in Base60 are just a numeric representation of a fraction where the fraction is represented over the nearest multiple of 60
So if we have the fraction 1/10 that would be 6/60 so that would yield 0.6
Base60:  1 / 10  = 0;6 =  6/60
And if we have the fraction 1/2 that would be 30/60 so that would yield 0;30
Base60: 1 / 2 = 0;30 = 30/60

Issue with having 60 different numerals:
You the clever reader might have found an issue with the method of counting already, how do you represent 1/2?
Well given this logic 1 / 2 = 30 / 60 = .30, but .30 can’t be a single number because it takes up two spaces .3 0, this is absolutely true and this is one of the problems I have with the current method of using Base60. Given this problem the current way of spacing out numbers is to put some sort of separator. For example
666.5 in base10 = 11,6;30 in base60 (the commas separate the 60s places and the semicolon is like the decimal so this is saying (11)(6).(30) )
I find this very hard to read, thus I created this numeric system.
Pop Quiz: Translate this to base60 (tap to reveal answer)
183.2 => 3,3;12  (3 in the 60s place (for 180) 3 in the 1s place – the fraction 2/10 -> 12/60)
Pop Quiz: Translate this to base10
6,6;20 => 366.3333…

Why Base 60?
Base 60 is incredibly useful because of the number of factors it has
{1, 2, 3, 4, 5, 6, 10, 12, 15, 30, 60}.
This allows for high divisibility and an increased range with regard to the ease and possibility of decimal usages. As such Base60 is wonderful to use for a system of measurement, imagine for a second that 1 meter was 60cm. In that case if I needed a tool to be 1/3 of a meter that would be easy (20cm) whereas with a regular meter that would 33.3333cm. Which bleeds into the second issue. 33.3333 can not be represented in decimal, even if the 3 is repeating because you are just saying 3…/10… (an infinite number of 3s over 10 with an infinite number of trailing 0s) and not 1/3. There is a lot of mathematical debate around this idea, however the simplest answer is to use a counting system that can properly represent fractions like 1/3 or 1/6 or 1/9 etc., instead of using a counting system that can’t because of its lack of factors {1,2,5,10}.
For these reasons there is already a historical precedent to Base60. Base60 was used in Sumeria and regions surrounding the fertile crescent thousands of years ago because of this same utility. As such many of the legacies passed down from Sumeria or legacy passed down from other cultures that borrowed from Sumeria are already in Base60 the most prominent example is time (60 seconds -> 60 minutes -> 24 hours). The time 1:43 is just a base60 number a 1 in the 60’s place and a 43 in the 1s place, therefore all time signatures tell you how many minutes have passed in the day as a base 60 number (103 minutes in this case). Aside from time there are several other examples where base60 or some form of base60 is in use today.
Why build this app?
Given the utility and prevalence of Base60 I find all the current ways to read and calculate it a little bit confusing and disappointing. Thus I created a numeral system for Base60 and a calculator to go along with it. In addition to this I thought this project would be a fun learning experience for creating my first app which it certainly was and something I can share to whomever is interested in using this.
*/
