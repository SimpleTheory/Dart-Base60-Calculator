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
extension IntExtensions on int {bool get isPositive => this > 0;}

// generate tab  --->  ctrl + shift + g
// KMS--------------------------------------------------------------------------
AbsBase60 absolute(val){
  if (val is AbsBase60){return val;}
  else if(val is int){return AbsBase60.from_integer(val);}
  else if(val is double){return AbsBase60.from_double(val);}
  else if(val is Base60){return val.abs();}
  else {throw TypeError();}
}
// Copy args got snapped because lack of primitives reeeeeeeee

// Classes ---------------------------------------------------------------------
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
  factory AbsBase60.from_double(double double){
    for (num i in range(101)){
      num currentAnswer = double * pow(60, i);
      if (currentAnswer.isInt){
        return WholeBase60Number(
            number: AbsBase60.from_integer(currentAnswer.toInt()).number,
            seximals: i.toInt(),
            reversed: true).toAbs60();
      }
    }
    int timetoround = (double * pow(60, 101)).round();
    return WholeBase60Number(
        number: AbsBase60.from_integer(timetoround).number,
        seximals: 101,
        reversed: true).toAbs60().round();
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
    return WholeBase60Number(
        number: number + frac,
        seximals: frac.length,
        reversed: reverse_);
  }
  AbsBase60 round(){
    WholeBase60Number x = wholenumberizer(reverse_: true);
    x.number[0] = 60;
    x.number = carry_over_reformat_base(x.number);
    return x.toAbs60();

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
  })
  {if (reversed){number=reverse(number);}}

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
  int toInt(){
    WholeBase60Number self = copyWith();
    self.reverseSelf();
    return self.number.mapIndexed(
            (index, element) => element * pow(60, index)
    ).toList().sum.toInt();
  }
//</editor-fold>


}

// Unit Math -------------------------------------------------------------------
    // <editor-fold desc="add, sub, euclidean division">
List<int> euclidean_division(int dividend, int divisor){
  int quotient = dividend ~/ divisor;
  int mod = dividend % divisor;
  return [quotient, mod];
}
List<int> base60_unit_addition(int n1, int n2){
  int temp = n1 + n2;
  List<int> r = euclidean_division(60, temp);
  return reverse(r);
}
List<int> base60_unit_subtraction(int subtractor, int subtractee){
  int holdover = 0;
  while(subtractee < subtractor){
    subtractee += 60;
    holdover -= 1;}
  return [(subtractee - subtractor), holdover];
}
// </editor-fold>
// Formatting ------------------------------------------------------------------
    // <editor-fold desc="remove0s, carryover reformat, prep compare">
List<int> remove0sFromEnd(List<int>? val, {bool end=true}){
  if (val==null){return [];}
  if (val.isEmpty){return [];}
  List<int> newList = List.from(val);
  if (end){newList = reverse(newList);}
  while(newList[0]==0){
    newList = newList.sublist(1);
    if (newList.isEmpty){return [];}}
  if (end) {return reverse(newList);}
  else{return newList;}
}
List<int> carry_over_reformat_base(List<int> ls){
  if (ls.where((element) => e >= 60).isNotEmpty){
    int carryOver = 0;
    List<int> temp_ls = [];

    for (int v in ls){
      v += carryOver;
      carryOver = 0;
      while (v>=60){
        carryOver += 1;
        v -= 60;
      }
      temp_ls.add(v);
    }
    if (carryOver>0){temp_ls.add(carryOver);}

    return temp_ls;
  }
  return ls;
}
List<List<int>> prep_compare(List<int> l1, List<int> l2, {bool number=true, reversed=false}){
  List<int> rl1 = List.from(l1);
  List<int> rl2 = List.from(l2);
  int lenDiff = rl1.length - rl2.length;
  int absLenDiff = lenDiff.abs();
  if (number){
    if (lenDiff.isPositive){
      rl2 = range(absLenDiff).map((e) => 0).toList() + rl2;
    }
    else if(lenDiff.isNegative){
      rl1 = range(absLenDiff).map((e) => 0).toList() + rl1;
    }
  }
  else{
    if (lenDiff.isPositive){
      rl2 = rl2 + range(absLenDiff).map((e) => 0).toList();
    }
    else if(lenDiff.isNegative){
      rl1 = rl1 + range(absLenDiff).map((e) => 0).toList();
    }
  }
  if (reversed){
    rl1 = reverse(rl1);
    rl2 = reverse(rl2);
  }
  return [rl1, rl2];

}
// </editor-fold>
// Comparison ------------------------------------------------------------------
