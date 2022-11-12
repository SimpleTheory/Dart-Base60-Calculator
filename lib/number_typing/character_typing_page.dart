import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';
import 'bloc/number_typing_bloc.dart';
//TODO: Add snackbar error when integer multiplication or division is too big
class NumberTypingPage extends StatelessWidget {
  const NumberTypingPage({Key? key}) : super(key: key);
  // Add event with add method to block
  void addSymboltoEvent(BuildContext context, String symbol){
    context.read<NumberTypingBloc>().add(
        NumberTypingInProgress(symbol: symbol));
  }
  void addOperatortoEvent(BuildContext context, String operator){
    context.read<NumberTypingBloc>().add(
        OperatorPress(operator: operator));
  }
  void leftArrowPress(BuildContext context){
    print('left');
    context.read<NumberTypingBloc>().add(
        LeftArrowPress());
  }
  void rightArrowPress(BuildContext context){
    context.read<NumberTypingBloc>().add(
        RightArrowPress());
  }
  bool mapOfSymbol(BuildContext context, String symbol){
    return context.read<NumberTypingBloc>().state.buttonEnable[symbol]!;
  }

  bool canPressNegative(String input, Map<String, bool> map){
    if (isInitMap(map)){
      if (input.isEmpty || input.endsWith(' ')){return true;}
      return false;}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Typing')),
      body: BlocConsumer<NumberTypingBloc, NumberTypingState>(
        listener: (context, state){
          if (state is NumberError){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('The numbers in the operation were too big for me :(')
                ));
          }
        },
        builder: (context, state) {
       return Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: userInputWidget(state.userInput)),
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
                                  canPressEquals(state.userInput, state.buttonEnable) ?
                                  ()=> context.read<NumberTypingBloc>().add(EqualsPress()) : null,
                          icon: const Icon(CupertinoIcons.equal_circle), iconSize: 40),
                      ElevatedButton(onPressed: null, child: const Text('Convert'),),
                      ElevatedButton(onPressed: ()=>context.read<NumberTypingBloc>().add(ClearPress()),
                          child: const Text('Clear'))
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (canPressNegative(state.userInput, state.buttonEnable)) ? ()=> context.read<NumberTypingBloc>().add(NegativePress()): null,
                    child: Text('-', style: characterStyle)),
                ElevatedButton(
                    onPressed: (canPressPeriod(state.userInput, state.buttonEnable)) ? ()=> context.read<NumberTypingBloc>().add(PeriodPress()): null,
                    child: Text('·', style: characterStyle))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[0].character)) ?
                    ()=>addSymboltoEvent(context, listOfCharacters[0].character) : null,
                    child: Text(
                        listOfCharacters[0].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[1].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[1].character) : null,
                    child: Text(
                        listOfCharacters[1].character,
                        style: characterStyle
                    )),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[2].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[2].character) : null,
                    child: Text(
                        listOfCharacters[2].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[3].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[3].character) : null,
                    child: Text(
                        listOfCharacters[3].character,
                        style: characterStyle
                    )
                ),

                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[4].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[4].character) : null,
                    child: Text(
                        listOfCharacters[4].character,
                        style: characterStyle
                    )),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[5].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[5].character) : null,
                    child: Text(
                        listOfCharacters[5].character,
                        style: characterStyle
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[6].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[6].character) : null,
                    child: Text(
                        listOfCharacters[6].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[10].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[10].character) : null,
                    child: Text(
                        listOfCharacters[10].character,
                        style: characterStyle
                    )),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[12].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[12].character) : null,
                    child: Text(
                        listOfCharacters[12].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[15].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[15].character) : null,
                    child: Text(
                        listOfCharacters[15].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[20].character)) ? ()=>
                        addSymboltoEvent(context, listOfCharacters[20].character) : null,
                    child: Text(
                        listOfCharacters[20].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed:(mapOfSymbol(context, listOfCharacters[30].character)) ? ()=>
                    addSymboltoEvent(context, listOfCharacters[30].character) : null,
                    child: Text(
                        listOfCharacters[30].character,
                        style: characterStyle
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(onPressed: ()=>leftArrowPress(context), icon: const Icon(Icons.arrow_back)),
                ElevatedButton(onPressed:(mapOfSymbol(context, '1')) ? ()=>
                addSymboltoEvent(context, '1') : null, child: const Text('1')),
                ElevatedButton(onPressed:(mapOfSymbol(context, '2')) ? ()=> addSymboltoEvent(context, '2') : null,
                    child: const Text('2')),
                ElevatedButton(onPressed:(mapOfSymbol(context, '3')) ? ()=> addSymboltoEvent(context, '3') : null,
                    child: const Text('3')),
                ElevatedButton(onPressed:(mapOfSymbol(context, '4')) ? ()=> addSymboltoEvent(context, '4') : null,
                    child: const Text('4')),
                IconButton(onPressed: (mapOfSymbol(context, 'arrow right')) ? ()=> rightArrowPress(context) : null,
                    icon: const Icon(Icons.arrow_forward))
              ],
            )
          ],)
        ],
      );
  },
),
    );
  }
}

TextStyle characterDisplay = const TextStyle(
  fontFamily: 'ari_numbers',
  fontSize: 150,
  color: Colors.black,
  overflow: TextOverflow.ellipsis
);
TextStyle characterStyle = const TextStyle(
                          fontFamily: 'ari_numbers',
                          fontSize: 40); // ratio font size
