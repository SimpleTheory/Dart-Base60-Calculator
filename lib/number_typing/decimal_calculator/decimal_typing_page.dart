import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
import 'package:sexigesimal_alpha/main.dart';
import 'package:sexigesimal_alpha/math/index.dart';
import 'package:sexigesimal_alpha/number_typing/base60clock.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_calculator_bloc.dart';
import '../bloc/number_typing_bloc.dart';
import '../cross_page_widgets.dart';

class DecimalTypingPage extends StatelessWidget {
  const DecimalTypingPage({Key? key}) : super(key: key);
  void addSymboltoEvent(BuildContext context, String symbol){
    context.read<DecimalCalculatorBloc>().add(
        DecimalTypingInProgress(numberOrNegOrPeriod: symbol));
  }
  void addOperatortoEvent(BuildContext context, String operator){
    context.read<DecimalCalculatorBloc>().add(
        DecimalOperatorPress(operator: operator));
  }
  void leftArrowPress(BuildContext context){
    context.read<DecimalCalculatorBloc>().add(
        DecimalLeftArrowPress());
  }
  bool canPressNegativeDecimal(String input){
    List<String>? opSplit = operatorSplit(input);
    if (opSplit == null){
      if (input.isEmpty){return true;}
      return false;
    }
    else{
      if (opSplit[2].isEmpty){return true;}
      return false;
    }
  }
  bool canPressPeriodDecimal(String input){
    List<String>? opSplit = operatorSplit(input);
    if (opSplit == null){
      if (!input.contains('.')){return true;}
      return false;
    }
    else{
      if (!opSplit[2].contains('.')){return true;}
      return false;
    }
  }
  bool canPressEqualsDecimal(String input){
    List<String>? opSplit = operatorSplit(input);
    if (opSplit != null){
      if (opSplit[2].isNotEmpty && !RegExp(r'^[-.]+$').hasMatch(input)){
        return true;
      }
    }
    return false;
  }
  bool canConvertDecimal(String input){
    if (input.isEmpty){return true;}
    List<String>? opSplit = operatorSplit(input);
    if (opSplit == null && input.isNotEmpty && !RegExp(r'^[·-]+$').hasMatch(input)){
        return true;
      }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Decimal Typing'), actions: [Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: base60Clock(context),
      // )],),
      appBar: ariAppBar(context, 'Decimal Typing'),
      drawer: aridrawer,
      body: BlocConsumer<DecimalCalculatorBloc, DecimalCalculatorState>(
        listener: (context, state){
          if (state is DecimalConvertListen){
              String preanswer = state.userInput.trim();
              if (preanswer.isEmpty) {
                context.read<NumberTypingBloc>().add(ClearPress());
                context.read<GlobalBloc>().add(
                    CalculatorConversionEvent(viewMap['NumberTypingPage']!));
                return;
              }
              if (RegExp(r'^[-0.]+$').hasMatch(preanswer)) {
                preanswer = '0';
              }

              String answer = !preanswer.contains('.')
                  ? Base60.from_integer(int.parse(preanswer)).toSymbols()
                  : Base60.from_double(double.parse(preanswer)).toSymbols();

              context
                  .read<NumberTypingBloc>()
                  .add(OnConvertTo(conversionInput: answer));
              context
                  .read<GlobalBloc>()
                  .add(CalculatorConversionEvent(viewMap['NumberTypingPage']!));
            }
          },
        builder: (context, state)=>
            Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: AutoSizeText(
                        state.userInput,
                        style: TextStyle(
                          fontFamily: 'Arial Rounded MT Bold',
                          fontSize: MediaQuery.of(context).size.width < 700 ? MediaQuery.of(context).size.width/6
                          : 110,
                          // color: NumberTypingState.textColor,
                        ),
                        maxLines: 2,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(onPressed: ()=> addOperatortoEvent(context, '+'),
                            icon: const Icon(CupertinoIcons.add_circled), iconSize: 40,),
                          IconButton(onPressed: ()=> addOperatortoEvent(context, '-'),
                              icon: const Icon(CupertinoIcons.minus_circle), iconSize: 40),
                          IconButton(onPressed: ()=> addOperatortoEvent(context, '*'),
                              icon: const Icon(CupertinoIcons.multiply_circle), iconSize: 40),
                          IconButton(onPressed: ()=> addOperatortoEvent(context, '÷'),
                              icon: const Icon(CupertinoIcons.divide_circle), iconSize: 40),
                          IconButton(onPressed:
                          canPressEqualsDecimal(state.userInput) ?
                              ()=> context.read<DecimalCalculatorBloc>().add(DecimalEquals()) : null,
                              icon: const Icon(CupertinoIcons.equal_circle), iconSize: 40),
                          ElevatedButton(
                            onPressed:
                              canConvertDecimal(state.userInput) ? ()=>context.read<DecimalCalculatorBloc>
                                ().add(DecimalConvert(context: context)) : null,
                            child: const Text('Convert'),),
                          ElevatedButton(onPressed: ()=>context.read<DecimalCalculatorBloc>().add(DecimalClear()),
                              child: const Text('Clear'))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height/3,
                child: LayoutBuilder(
                  builder: (layoutContext, constraints){
                    if (MediaQuery.of(context).size.width <= 800){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: canPressNegativeDecimal(state.userInput) ? ()=> addSymboltoEvent(context, '-'): null,
                                    child: buttonText(('-'))),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: canPressPeriodDecimal(state.userInput) ? ()=> addSymboltoEvent(context, '.'): null,
                                    child: buttonText('·')),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '1'),
                                    child: buttonText('1')),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '2'),
                                    child: buttonText('2')),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '3'),
                                    child: buttonText('3')),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '4'),
                                    child: buttonText('4')),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '5'),
                                    child: buttonText('5')),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '6'),
                                    child: buttonText('6')),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '7'),
                                    child: buttonText('7')),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '8'),
                                    child: buttonText('8')),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: ()=> addSymboltoEvent(context, '9'),
                                    child: buttonText('9')),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: ()=> addSymboltoEvent(context, '0'),
                                      child: buttonText('0')),
                                ),
                                Expanded(child: IconButton(onPressed: ()=>leftArrowPress(context), icon: const Icon(Icons.arrow_back))),
                              ],
                            ),
                          )
                        ],
                      );}
                    else if (800 < MediaQuery.of(context).size.width && MediaQuery.of(context).size.width <= 1200){
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width/8,
                              vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: canPressNegativeDecimal(state.userInput) ? ()=> addSymboltoEvent(context, '-'): null,
                                        child: buttonText(('-'))),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: canPressPeriodDecimal(state.userInput) ? ()=> addSymboltoEvent(context, '.'): null,
                                        child: buttonText('·')),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '1'),
                                        child: buttonText('1')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '2'),
                                        child: buttonText('2')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '3'),
                                        child: buttonText('3')),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '4'),
                                        child: buttonText('4')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '5'),
                                        child: buttonText('5')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '6'),
                                        child: buttonText('6')),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '7'),
                                        child: buttonText('7')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '8'),
                                        child: buttonText('8')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '9'),
                                        child: buttonText('9')),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: ()=> addSymboltoEvent(context, '0'),
                                          child: buttonText('0')),
                                    ),
                                    Expanded(child: IconButton(onPressed: ()=>leftArrowPress(context), icon: const Icon(Icons.arrow_back))),
                                  ],
                                ),
                              )
                            ],
                          )
                      );
                    }
                    else{
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width/6,
                              vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: canPressNegativeDecimal(state.userInput) ? ()=> addSymboltoEvent(context, '-'): null,
                                        child: buttonText(('-'))),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: canPressPeriodDecimal(state.userInput) ? ()=> addSymboltoEvent(context, '.'): null,
                                        child: buttonText('·')),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '1'),
                                        child: buttonText('1')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '2'),
                                        child: buttonText('2')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '3'),
                                        child: buttonText('3')),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '4'),
                                        child: buttonText('4')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '5'),
                                        child: buttonText('5')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '6'),
                                        child: buttonText('6')),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '7'),
                                        child: buttonText('7')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '8'),
                                        child: buttonText('8')),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: ()=> addSymboltoEvent(context, '9'),
                                        child: buttonText('9')),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: ()=> addSymboltoEvent(context, '0'),
                                          child: buttonText('0')),
                                    ),
                                    Expanded(child: IconButton(onPressed: ()=>leftArrowPress(context), icon: const Icon(Icons.arrow_back))),
                                  ],
                                ),
                              )
                            ],
                          )
                      );
                    }
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}

TextStyle characterDisplay = TextStyle(
    fontFamily: 'Arial Rounded MT Bold',
    fontSize: 150,
    color: NumberTypingState.textColor,
);

TextStyle characterStyle = const TextStyle(
    fontFamily: 'Arial Rounded MT Bold',
    fontSize: 40); // ratio font size
AutoSizeText buttonText(String text) => AutoSizeText(text, style: characterStyle, maxLines: 1,);