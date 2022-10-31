import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

class NumberTypingPage extends StatelessWidget {
  const NumberTypingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Typing')),
      body: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.add)),
              IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.minus_circle)),
              IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.multiply_circle)),
              IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.divide_circle)),
              ElevatedButton(onPressed: (){}, child: Text('Convert'))

            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text('Hi'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[0].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[1].character,
                        style: characterStyle
                    )),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[2].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[3].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[4].character,
                        style: characterStyle
                    )),
                ElevatedButton(
                    onPressed: (){},
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
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[6].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[10].character,
                        style: characterStyle
                    )),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[12].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[15].character,
                        style: characterStyle
                    )
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        listOfCharacters[30].character,
                        style: characterStyle
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back)),
                ElevatedButton(onPressed: (){}, child: const Text('1')),
                ElevatedButton(onPressed: (){}, child: const Text('2')),
                ElevatedButton(onPressed: (){}, child: const Text('3')),
                ElevatedButton(onPressed: (){}, child: const Text('4')),
                IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward))


              ],
            )
          ],)

        ],
      ),
    );
  }
}

TextStyle characterStyle = const TextStyle(
                          fontFamily: 'ari_numbers',
                          fontSize:   28);