import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';
import 'bloc/number_typing_bloc.dart';

class NumberTypingPage extends StatelessWidget {
  const NumberTypingPage({Key? key}) : super(key: key);
  // Add event with add method to block
  void addSymboltoEvent(BuildContext context, String symbol){
    context.read<NumberTypingBloc>().add(
        NumberTypingInProgress(symbol: symbol));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Typing')),
      body: BlocBuilder<NumberTypingBloc, NumberTypingState>(
      builder: (context, state) {
       return Column(
        children: <Widget>[
          ColoredBox(
            color: Colors.green,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.userInput, style: characterStyle,)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: Colors.orange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.add)),
                        IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.minus_circle)),
                        IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.multiply_circle)),
                        IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.divide_circle)),
                        ElevatedButton(onPressed: null, child: Text('Convert'))

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

TextStyle characterStyle = const TextStyle(
                          fontFamily: 'ari_numbers',
                          fontSize:   100);