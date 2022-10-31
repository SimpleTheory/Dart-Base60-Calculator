part of 'number_typing_bloc.dart';

@immutable
abstract class NumberTypingState {}

class NumberTypingInitial extends NumberTypingState {}

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