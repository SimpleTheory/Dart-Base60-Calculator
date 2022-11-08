part of 'number_typing_bloc.dart';

@immutable
abstract class NumberTypingState {
  late String userInput;
  late ProxyNumber proxyNumber;
  Map<String, bool> buttonEnable = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
    listOfCharacters[0].character: true,
    listOfCharacters[1].character: true,
    listOfCharacters[2].character: true,
    listOfCharacters[3].character: true,
    listOfCharacters[4].character: true,
    listOfCharacters[5].character: true,
    listOfCharacters[6].character: true,
    listOfCharacters[10].character: true,
    listOfCharacters[12].character: true,
    listOfCharacters[15].character: true,
    listOfCharacters[30].character: true,
    'arrow right': false,
  };

//<editor-fold desc="Data Methods">
  NumberTypingState({
    required this.userInput,
    required this.proxyNumber,
    Map<String, bool>? buttonEnable})
  {this.buttonEnable = buttonEnable ?? this.buttonEnable;}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumberTypingState &&
          runtimeType.toString() == other.runtimeType.toString() &&
          userInput.runtimeType == other.userInput.runtimeType &&
          userInput.toString() == other.userInput.toString() &&
          proxyNumber.runtimeType == other.proxyNumber.runtimeType &&
          proxyNumber.toString() == other.proxyNumber.toString() &&
          buttonEnable.runtimeType == other.buttonEnable.runtimeType &&
          buttonEnable.toString() == other.buttonEnable.toString());

  @override
  int get hashCode =>
      userInput.hashCode ^ proxyNumber.hashCode ^ buttonEnable.hashCode;

  @override
  String toString() {
    return 'NumberTypingState{'
        'userInput: $userInput, '
        'proxyNumber: $proxyNumber, '
        'buttonEnable: $buttonEnable}';
  }

  Map<String, dynamic> toMap() {
    return {
      'userInput': userInput,
      'proxyNumber': proxyNumber,
      'buttonEnable': buttonEnable,
    };
  }

//</editor-fold>
}

class NumberTypingInitial extends NumberTypingState {
  NumberTypingInitial({required super.userInput, required super.proxyNumber, super.buttonEnable});
  factory NumberTypingInitial.initial({String currentString = ''})=>NumberTypingInitial(userInput: currentString, proxyNumber: ProxyNumber());
}


class ProxyNumber{
  int? baseSymbol, lines, subnotation;
  bool? addedOne;

  factory ProxyNumber.reset() => ProxyNumber();
  List<Character> filterList(){
    // Map params = {
    //   'base': base,
    //   'lines': lines,
    //   'subnotation': subnotation,
    //   'addedOne': addedOne};
    List<Character> filter = List.from(listOfCharacters);
    if (baseSymbol != null){
      filter = filter.where((element) => element.baseSymbol == baseSymbol).toList();
    }
    if (lines != null){
      filter = filter.where((element) => element.lines == lines).toList();
    }
    if (subnotation != null){
      filter = filter.where((element) => element.subnotation == subnotation).toList();
    }
    if (addedOne != null){
      filter = filter.where((element) => element.addedOne == addedOne).toList();
    }
    return filter;
    // for (MapEntry e in params.entries) {
    //   filter = filter.where((element) => false).toList()
    // }
  }
  bool isValid(){
    if (baseSymbol == null){return false;}
    bool? addedOne_ = addedOne;
    addedOne_ ??= false;
    for (Character char in listOfCharacters){
      if (
        char.baseSymbol == baseSymbol &&
        char.subnotation == subnotation &&
        char.lines == lines &&
        char.addedOne == addedOne_
      )   {return true;}
    }
    return false;
  }
  Character returnValidCharacter() {
    bool? addedOne_ = addedOne;
    addedOne_ ??= false;
    for (Character char in listOfCharacters) {
      if (
      char.baseSymbol == baseSymbol &&
          char.subnotation == subnotation &&
          char.lines == lines &&
          char.addedOne == addedOne_
      ){return char;}
    }
    throw(ArgumentError('No valid character for $this in listOfCharacters'));
  }


//<editor-fold desc="Data Methods">
  ProxyNumber({
    this.baseSymbol,
    this.lines,
    this.subnotation,
    this.addedOne,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ProxyNumber &&
              runtimeType.toString() == other.runtimeType.toString() &&

              baseSymbol.runtimeType == other.baseSymbol.runtimeType &&
              baseSymbol.toString() == other.baseSymbol.toString() &&

              lines.runtimeType == other.lines.runtimeType &&
              lines.toString() == other.lines.toString() &&

              subnotation.runtimeType == other.subnotation.runtimeType &&
              subnotation.toString() == other.subnotation.toString() &&

              addedOne.runtimeType == other.addedOne.runtimeType &&
              addedOne.toString() == other.addedOne.toString()
          );


  @override
  int get hashCode =>
      baseSymbol.hashCode ^
      lines.hashCode ^
      subnotation.hashCode ^
      addedOne.hashCode;


  @override
  String toString() {
    return 'ProxyNumber{'
        'base: $baseSymbol'
        'lines: $lines'
        'subnotation: $subnotation'
        'addedOne: $addedOne}';
  }


  ProxyNumber copyWith({
    int? base_, int? lines_, int? subnotation_, bool? addedOne_,}) {
    return ProxyNumber(
        baseSymbol: base_ ?? baseSymbol,
        lines: lines_ ?? lines,
        subnotation: subnotation_ ?? subnotation,
        addedOne: addedOne_ ?? addedOne);
  }


  Map<String, dynamic> toMap() {
    return {
      'base': baseSymbol,
      'lines': lines,
      'subnotation': subnotation,
      'addedOne': addedOne,
    };
  }

  factory ProxyNumber.fromMap(Map<String, dynamic> map) {
    return ProxyNumber(
      baseSymbol: map['base'] as int,
      lines: map['lines'] as int,
      subnotation: map['subnotation'] as int,
      addedOne: map['addedOne'] as bool,
    );
  }


//</editor-fold>

}