// Imports
import 'package:collection/collection.dart';
import 'dart:math';
// Meta-Utility ----------------------------------------------------------------
List<int> range(int stop, {int? start, int? step}){
  step ??= 1;
  start ??= 0;
  List<int> range = [];
  for (int i = start; i < stop; i+=step){
    range.add(i);
  }
  return range;
}
List<T> reverse<T>(List<T> x) => List<T>.from(x.reversed);
List<T> sorted<T>(List<T> x){List<T> y = List.from(x); y.sort(); return y;}
extension NumExtensions on num {bool get isInt => (this % 1) == 0;}

// generate tab  --->  ctrl + shift + g
// KMS--------------------------------------------------------------------------
AbsBase60 absolute(val){
  if (val is AbsBase60){return val;}
  else if(val is int){return AbsBase60.from_int(val);}
  else if(val is double){return AbsBase60.from_double(val);}
  else if(val is Base60){return val.abs();}
  else {throw TypeError();}
}
// Copy args got snapped because lack of primitives reeeeeeeee
// ------------------------------------------------------------------------------
class AbsBase60{
  late List<int> number;
  late List<int> fraction;

  //<editor-fold desc="Data Methods">
  AbsBase60({required this.number, required this.fraction,});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is AbsBase60 &&
              runtimeType == other.runtimeType &&
              number == other.number &&
              fraction == other.fraction
          );
  @override
  int get hashCode =>
      number.hashCode ^
      fraction.hashCode;
  String debug() {
    return 'AbsBase60{number: $number, fraction: $fraction,}';
  }
  AbsBase60 copyWith({List<int>? number, List<int>? fraction,}) {
    return AbsBase60(
      number: number ?? this.number,
      fraction: fraction ?? this.fraction,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'number': this.number,
      'fraction': this.fraction,
    };
  }
  factory AbsBase60.fromMap(Map<String, dynamic> map) {
    return AbsBase60(
      number: map['number'] as List<int>,
      fraction: map['fraction'] as List<int>,
    );
  }
//</editor-fold>

  //<editor-fold desc="Constructors">
  AbsBase60.from_commas(String commas){
    commas.trim();
    if (commas.contains(';')){
      List<String> commasSplit = commas.split(';');
      number = commasSplit.isEmpty ? [] :
               commasSplit[0].split(',').map((e) => int.parse(e)).toList();

      fraction = commasSplit[1].split(',').map((e) => int.parse(e)).toList();
      for (int i in number+fraction)
        {if (i>=60)
          {throw ArgumentError('OverbaseError $commas');}}

    }
    else{
      number = commas.split(',').map((e) => int.parse(e)).toList();
      fraction = [];
    }
  }
  AbsBase60.zero(){number=[0]; fraction=[];}
  AbsBase60.from_integer(int int){number = int_to_base(int, 60); fraction=[];}
  AbsBase60.from_double(double double){
    for (num i in range(101)){
      num currentAnswer = double * pow(60, i);
      if (currentAnswer.isInt){
        WholeBase60Number(
            AbsBase60.from_integer(currentAnswer.toInt()).number, i, true).to_Abs60();
      }

    }
  }

//</editor-fold>

  //<editor-fold desc="Methods">
// toInt toFloat isInt isFloat round wholenumberize
  bool isInt(){
    if (fraction.isEmpty){return true;}
    else{
      fraction = remove0sFromEnd(fraction);
      if (fraction.isEmpty){return true;}
      return false;
    }
  }
  bool isFloat()=> !isInt();
  int toInt()=>
      reverse(number).mapIndexed(
              (index, element) => element * pow(60, index)
      ).toList().sum.toInt();
  double toDouble(){
    WholeBase60Number wholeNumber = wholenumberizer();
    return wholeNumber.toInt() / pow(60, wholeNumber.seximals);
  }
  @override
  String toString(){
    String n = number.join(',');
    if (fraction.isNotEmpty){
      String f = fraction.join(',');
      return '$n;$f';}
    return n;
  }
  WholeBase60Number wholenumberizer({reverse_ = false}){
    List<int> frac = remove0sFromEnd(fraction);
    return WholeBase60Number(number + frac, frac.length, reverse: reverse_);
  }

//</editor-fold>

  //<editor-fold desc="Operators">
//TODO: I'll get to this when I have implemented the rest

//</editor-fold>

}
class Base60 extends AbsBase60{
  Base60({required super.number, required super.fraction, required negative});
  //@TODO rewrite operators and constructors to fit negativity and positivity
  //<editor-fold desc="Methods">
  AbsBase60 abs()=>AbsBase60(number: number, fraction: fraction);
  //</editor-fold>
}
class WholeBase60Number{
  List<int> number;
  int seximals;
  bool reversed;

  //<editor-fold desc="Data Methods">

  WholeBase60Number({
    required this.number,
    required this.seximals,
    this.reversed=false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WholeBase60Number &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          seximals == other.seximals &&
          reversed == other.reversed);

  @override
  int get hashCode => number.hashCode ^ seximals.hashCode ^ reversed.hashCode;

  @override
  String toString() {
    return 'WholeBase60Number{ number: $number, seximals: $seximals, reversed: $reversed,}';
  }

  WholeBase60Number copyWith({List<int>? number, int? seximals, bool? reversed,})
  {
    return WholeBase60Number(
      number: number ?? this.number,
      seximals: seximals ?? this.seximals,
      reversed: reversed ?? this.reversed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': this.number,
      'seximals': this.seximals,
      'reversed': this.reversed,
    };
  }

  factory WholeBase60Number.fromMap(Map<String, dynamic> map) {
    return WholeBase60Number(
      number: map['number'] as List<int>,
      seximals: map['seximals'] as int,
      reversed: map['reversed'] as bool,
    );
  }

//</editor-fold>
  //<editor-fold desc="Methods">
  void toggleReverse(){
    number = reverse(number);
    reversed = !reversed;
  }
  void reverseSelf(){
    if (!reversed){toggleReverse();}
  }
  void unReverse(){
    if (reversed){toggleReverse();}
  }
  AbsBase60 toAbs60(){
    WholeBase60Number self = copyWith();
    self.unReverse();

    if(self.seximals==self.number.length)
      {return AbsBase60(number: [], fraction: reverse(self.number));}
    else if(self.seximals==0){
      return AbsBase60(number: reverse(self.number), fraction: []);}
    else {
      List<int> frac = self.number.sublist(0, seximals + 1);
      frac = remove0sFromEnd(frac);
      frac = reverse(frac);
      List<int> num = self.number.sublist(seximals);
      num = reverse(num);
      return AbsBase60(number: num, fraction: frac);
    }

  }
//</editor-fold>


}



remove0sFromEnd(List<int>? val, {bool end=true}){
  if (val==null){return [];}
  if (val.isEmpty){return [];}
  List<int> newList = List.from(val);
  while(newList[0]==)


}

