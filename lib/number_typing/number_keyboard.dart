import 'package:flutter/cupertino.dart';
import 'package:sexigesimal_alpha/math/base_60_math.dart';

class Character{
  int baseSymbol; // button 6 5
  int? lines, subnotation; // 4
  bool addedOne;
  String character;

  //<editor-fold desc="Data Methods">

  Character({
    required this.baseSymbol,
    required this.character,
    this.lines,
    this.subnotation,
    this.addedOne = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          runtimeType.toString() == other.runtimeType.toString() &&
          baseSymbol.runtimeType == other.baseSymbol.runtimeType &&
          baseSymbol.toString() == other.baseSymbol.toString() &&
          lines.runtimeType == other.lines.runtimeType &&
          lines.toString() == other.lines.toString() &&
          subnotation.runtimeType == other.subnotation.runtimeType &&
          subnotation.toString() == other.subnotation.toString() &&
          addedOne.runtimeType == other.addedOne.runtimeType &&
          addedOne.toString() == other.addedOne.toString() &&
          character.runtimeType == other.character.runtimeType &&
          character.toString() == other.character.toString());

  @override
  int get hashCode =>
      baseSymbol.hashCode ^
      lines.hashCode ^
      subnotation.hashCode ^
      addedOne.hashCode ^
      character.hashCode;

  @override
  String toString() {
    return 'Character{'
        'baseSymbol: $baseSymbol'
        'lines: $lines'
        'subnotation: $subnotation'
        'addedOne: $addedOne'
        'character: $character}';
  }

  Character copyWith({
    int? baseSymbol_,
    int? lines_,
    int? subnotation_,
    bool? addedOne_,
    String? character_,
  }) {
    return Character(
        baseSymbol: baseSymbol_ ?? baseSymbol,
        lines: lines_ ?? lines,
        subnotation: subnotation_ ?? subnotation,
        addedOne: addedOne_ ?? addedOne,
        character: character_ ?? character);
  }

  Map<String, dynamic> toMap() {
    return {
      'baseSymbol': baseSymbol,
      'lines': lines,
      'subnotation': subnotation,
      'addedOne': addedOne,
      'character': character,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      baseSymbol: map['baseSymbol'] as int,
      lines: map['lines'] as int,
      subnotation: map['subnotation'] as int,
      addedOne: map['addedOne'] as bool,
      character: map['character'] as String,
    );
  }

//</editor-fold>
  int get number{
    int currentInt;
    if (lines == null && subnotation == null){currentInt = baseSymbol;}
    else if (baseSymbol == 0 && lines != null){
      currentInt = 60 - lines!;
    }
    else if (lines != null && subnotation == null){
      currentInt = baseSymbol * (lines!+1);
    }
    else if (subnotation != null && lines == null){
      currentInt = baseSymbol * subnotation!;
  }
    else{
      currentInt = baseSymbol * (subnotation! + lines!);
    }
    if (addedOne){currentInt += 1;}
    return currentInt;
  }
}

List<Character>listOfCharacters = [
  Character(baseSymbol: 0, character: '??'),
  Character(baseSymbol: 1, character: '??'),
  Character(baseSymbol: 2, character: '??'),
  Character(baseSymbol: 3, character: '??'),
  Character(baseSymbol: 4, character: '??'),
  Character(baseSymbol: 5, character: '??'),
  Character(baseSymbol: 6, character: '??'),
  Character(baseSymbol: 6, character: '??', addedOne: true),
  Character(baseSymbol: 4, character: '??', lines: 1),
  Character(baseSymbol: 3, character: '??', lines: 2),
  Character(baseSymbol: 10, character: '??'),
  Character(baseSymbol: 10, character: '??', addedOne: true),
  Character(baseSymbol: 12, character: '??'),
  Character(baseSymbol: 12, character: '??', addedOne: true),
  Character(baseSymbol: 2, character: '??', subnotation: 5, lines: 2),
  // 15 ------
  Character(baseSymbol: 15, character: '??'),
  Character(baseSymbol: 4, character: '??', lines: 3),
  Character(baseSymbol: 4, character: '??', lines: 3, addedOne: true),
  Character(baseSymbol: 6, character: '??', lines: 2),
  Character(baseSymbol: 6, character: '??', lines: 2, addedOne: true),
  Character(baseSymbol: 20, character: '??'),
  Character(baseSymbol: 3, character: '??', lines: 2, subnotation: 5),
  Character(baseSymbol: 2, character: '??', lines: 1, subnotation: 10),
  Character(baseSymbol: 2, character: '??', lines: 1, subnotation: 10, addedOne: true),
  Character(baseSymbol: 12, character: '??', lines: 1),
  Character(baseSymbol: 5, character: '??', subnotation: 5),
  Character(baseSymbol: 2, character: '??', lines: 1, subnotation: 12),
  Character(baseSymbol: 3, character: '??', lines: 4, subnotation: 5),
  Character(baseSymbol: 4, character: '??', lines: 2, subnotation: 5),
  Character(baseSymbol: 4, character: '??', lines: 2, subnotation: 5, addedOne: true),
  // 30 -------
  Character(baseSymbol: 30, character: '??'),
  Character(baseSymbol: 30, character: '??', addedOne: true),
  Character(baseSymbol: 4, character: '??', lines: 3, subnotation: 5),
  Character(baseSymbol: 3, character: '??', lines: 1, subnotation: 10),
  Character(baseSymbol: 2, character: '??', lines: 2, subnotation: 15),
  Character(baseSymbol: 5, character: '??', lines: 2, subnotation: 5),
  Character(baseSymbol: 12, character: '??', lines: 2),
  Character(baseSymbol: 12, character: '??', lines: 2, addedOne: true),
  Character(baseSymbol: 2, character: '??', lines: 4, subnotation: 15),
  Character(baseSymbol: 3, character: '??', lines: 1, subnotation: 12),
  Character(baseSymbol: 20, character: '??', lines: 1),
  Character(baseSymbol: 20, character: '??', lines: 1, addedOne: true),
  Character(baseSymbol: 6, character: '??', lines: 2, subnotation: 5),
  Character(baseSymbol: 6, character: '??', lines: 2, subnotation: 5, addedOne: true),
  Character(baseSymbol: 4, character: '??', lines: 1, subnotation: 10),
  // 45 ---------
  Character(baseSymbol: 15, character: '??', lines: 2),
  Character(baseSymbol: 2, character: '??', lines: 3, subnotation: 20),
  Character(baseSymbol: 2, character: '??', lines: 3, subnotation: 20, addedOne: true),
  Character(baseSymbol: 12, character: '??', lines: 3),
  Character(baseSymbol: 12, character: '??', lines: 3, addedOne: true),
  Character(baseSymbol: 10, character: '??', subnotation: 5),
  Character(baseSymbol: 3, character: '??', lines: 2, subnotation: 15),
  Character(baseSymbol: 4, character: '??', lines: 1, subnotation: 12),
  Character(baseSymbol: 4, character: '??', lines: 1, subnotation: 12, addedOne: true),
  Character(baseSymbol: 6, character: '??', lines: 4, subnotation: 5),
  Character(baseSymbol: 5, character: '??', lines: 1, subnotation: 10),
  Character(baseSymbol: 4, character: '??', lines: 2, subnotation: 12),
  Character(baseSymbol: 3, character: '??', lines: 4, subnotation: 15),
  Character(baseSymbol: 0, character: '??', lines: 2),
  Character(baseSymbol: 0, character: '??', lines: 1)
];
Map<String, int> symbolToInt = {for (Character i in listOfCharacters) i.character: i.number};
Map<String, String> symbolToStringInt = {for (MapEntry i in symbolToInt.entries) i.key: i.value.toString()};
Map<int, String> intToSymbol = {for (Character i in listOfCharacters) i.number: i.character};

final List<String> operators = ['+','-','??','*'];
bool containsOperator(String currentInput){
  for (String operator in operators){
    if (currentInput.contains(operator) && currentInput.contains(' '))
    {return true;}
  }
  return false;
}
List<String>? operatorSplit(String currentInput){
  for (String operator in operators){
    if (currentInput.contains(' $operator ')){
      List<String> result = currentInput.split(' $operator ');
      result.insert(1, operator);
      return result;
    }
  }
  return null;
}
String decimalChar = '??';
class CharacterState{
  int baseSymbol;
  int? lines, subnotation;
  bool addedOne = false;

  List<Character> retrieveList(){
    if (lines == null && subnotation == null){
      return listOfCharacters.where((e) =>
      (e.baseSymbol==baseSymbol &&
       e.addedOne == addedOne)).toList();
    }
    else if (lines==null){
      return listOfCharacters.where((e) =>
       e.baseSymbol==baseSymbol &&
       e.addedOne == addedOne &&
       e.subnotation == subnotation).toList();
    }
    else if (subnotation==null){
      return listOfCharacters.where((e) =>
          e.baseSymbol==baseSymbol &&
          e.addedOne == addedOne &&
          e.lines == lines).toList();
    }
    else{
      return listOfCharacters.where((e) =>
          e.baseSymbol==baseSymbol &&
          e.addedOne == addedOne &&
          e.subnotation == subnotation &&
          e.lines == lines).toList();
    }
  }

  //<editor-fold desc="Data Methods">

  CharacterState({
    required this.baseSymbol,
    this.lines,
    this.subnotation,
    this.addedOne = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is CharacterState &&
              runtimeType.toString() == other.runtimeType.toString() &&
              baseSymbol.runtimeType == other.baseSymbol.runtimeType &&
              baseSymbol.toString() == other.baseSymbol.toString() &&
              lines.runtimeType == other.lines.runtimeType &&
              lines.toString() == other.lines.toString() &&
              subnotation.runtimeType == other.subnotation.runtimeType &&
              subnotation.toString() == other.subnotation.toString() &&
              addedOne.runtimeType == other.addedOne.runtimeType &&
              addedOne.toString() == other.addedOne.toString());

  @override
  int get hashCode =>
      baseSymbol.hashCode ^
      lines.hashCode ^
      subnotation.hashCode ^
      addedOne.hashCode;

  @override
  String toString() {
    return 'CharacterState{'
        'baseSymbol: $baseSymbol'
        'lines: $lines'
        'subnotation: $subnotation'
        'addedOne: $addedOne}';
  }

  CharacterState copyWith({
    int? baseSymbol_,
    int? lines_,
    int? subnotation_,
    bool? addedOne_,
  }) {
    return CharacterState(
        baseSymbol: baseSymbol_ ?? baseSymbol,
        lines: lines_ ?? lines,
        subnotation: subnotation_ ?? subnotation,
        addedOne: addedOne_ ?? addedOne);
  }

  Map<String, dynamic> toMap() {
    return {
      'baseSymbol': baseSymbol,
      'lines': lines,
      'subnotation': subnotation,
      'addedOne': addedOne,
    };
  }

  factory CharacterState.fromMap(Map<String, dynamic> map) {
    return CharacterState(
      baseSymbol: map['baseSymbol'] as int,
      lines: map['lines'] as int,
      subnotation: map['subnotation'] as int,
      addedOne: map['addedOne'] as bool,
    );
  }

//</editor-fold>
}

String getChar(int x)=>listOfCharacters[x].character;
String symbolsToCommas(String symbols){
  if (RegExp(r'^[????-]+$').hasMatch(symbols)){return '0';}
  Map<String, String> translate = Map<String, String>.from(symbolToStringInt);
  translate[decimalChar]=';';
  translate['-']='-';
  String commas = '';
  for (String char in symbols.characters){
    String charToAdd = translate[char]!;
    if (RegExp(r'^\d+$').hasMatch(charToAdd)){
      charToAdd += ',';
    }
    commas += charToAdd;
  }
  if (commas.contains(',;')){commas = commas.replaceAll(',;', ';');}
  return commas.substring(0, commas.length-1);

}
extension SymbolTyping on AbsBase60{
  String toSymbols(){
    String symbols = '';
    fraction = remove0sFromEnd(fraction);
    if (this is Base60){
      Base60 x = this as Base60;
      if (x.negative){
        symbols += '-';
      }
    }
    for (int num in number){
      symbols += getChar(num);
    }
    if (fraction.isNotEmpty){
      symbols += decimalChar;
      for (int num in fraction){
        symbols += getChar(num);
      }
    }
    return symbols;
  }
}
String operationService(opSplit_or_userInput){
  if (opSplit_or_userInput is String){
    opSplit_or_userInput = operatorSplit(opSplit_or_userInput);
  }

  Base60 x(String s)=> Base60.from_commas(s);

  String num1 = symbolsToCommas(opSplit_or_userInput[0]);
  String operator = opSplit_or_userInput[1];
  String num2 = symbolsToCommas(opSplit_or_userInput[2]);

  if(operator =='+'){
    return (x(num1)+x(num2)).toSymbols();}

  else if(operator == '-'){
    return (x(num1)-x(num2)).toSymbols();}

  else if(operator == '*'){
    return (x(num1)*x(num2)).toSymbols();}

  else if(operator == '??'){
    return (x(num1)/x(num2)).toSymbols();
  }

  throw ArgumentError('Operation Service Error: Params: $opSplit_or_userInput');
}
// symbols
// lines
// sub-notation
// addOne
// enter

// 15
// 1 2 3 4 5

