import 'dart:math';

import 'package:test/test.dart';
import '';
List<T> reverse<T>(List<T> x) => List<T>.from(x.reversed);


AbsBase60 a = base_60_math.AbsBase60.from_integer(346);
AbsBase60 b = base_60_math.AbsBase60.from_integer(643);
AbsBase60 c = base_60_math.AbsBase60.from_integer(346);

void main() {
  group('AbsBase60 methods', (){
    test('Abs60>=', () {
      expect(b>=a, isTrue);
    });
    test('Abs60>=, 2', () {
      expect(a>=c, isTrue);
    });
    test('Abs60>= Falsey', () {
      expect(a>=b, isFalse);
    });

    test('Abs60<=', () {
      expect(a<=b, isTrue);
    });
    test('Abs60<=, 2', () {
      expect(a<=c, isTrue);
    });
    test('Abs60<= Falsey', () {
      expect(b<=a, isFalse);
    });

    test('Abs60=', () {
      expect(a==c, isTrue);
    });
    test('Abs60= falsey', (){
      expect(b==a, isFalse);
    });

    test('Abs60>', () {
      expect(b>a, isTrue);
    });
    test('Abs60> Falsey', () {
      expect(a>c, isFalse);
    });
    test('Abs60> Falsey, 2', () {
      expect(a > b, isFalse);
    });

    test('Abs60<', () {
      expect(a<b, isTrue);
    });
    test('Abs60< Falsey', () {
      expect(a<c, isFalse);
    });
    test('Abs60< Falsey, 2', () {
      expect(b<a, isFalse);
    });

    test('abs+0', () {
      Abs60 a1 = base_60_math.AbsBase60.from_integer(437);
      Abs60 b1 = base_60_math.AbsBase60.zero();
      expect(a1+b1, equals(Abs60 a1));
    });
    test('abs +6', () {
      Abs60 a1 = base_60_math.AbsBase60.from_integer(437);
      Abs60 c1 = base_60_math.AbsBase60.from_integer(6);
      expect(a+c, equals(base_60_math.AbsBase60.from_integer(443));
    });

    test('abs to double', () {
      expect(base_60_math.AbsBase60.from_commas('1,16;15').toDouble(),
          equals(76.25));
    });


    test('abs round', (){
      Abs60 c1 = base_60_math.AbsBase60.from_commas('2;59,59,59,59,30').round();
      expect(c1, equals(base_60_math.AbsBase60.from_integer(3)));
    });
    test('abs toString()', (){
      AbsBase60 a = base_60_math.Base60.from_commas('3,4;12');
      expect(a.toString(), equals('3,4;12'));
    });
  });
  group('Abs60 constructors', (){
    test('from commas', (){
      expect(base_60_math.AbsBase60.from_commas('1,11').number, [1,11]);
      expect(base_60_math.AbsBase60.from_commas('1,11').fraction, []);
    });
    test('from commas frac', (){
      AbsBase60 a = base_60_math.AbsBase60.from_commas('1,1;11');
      expect(a.number, [1,1] );
      expect(a.fraction, [11]);
    });
    test('from commas only frac', (){
      AbsBase60 a = base_60_math.AbsBase60.from_commas(';11');
      expect(a.number_, []);
      expect(a.fraction, [11]);
    });
    test('from_int', (){
      expect(base_60_math.AbsBase60.from_int(71).number, [1, 11]);

    });
    test('from double to abs', () {
      expect(base_60_math.AbsBase60.from_double(76.25),
          equals(base_60_math.AbsBase60.from_commas('1,16;15')));
    });
    test('from double to abs 1/3', () {
      expect(base_60_math.AbsBase60.from_double(1/3),
          equals(base_60_math.AbsBase60.from_commas(';20')));
    });
  });
  group('WholeNumber', (){
    AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0');
    test('wholenumberizer', (){
      WholeNumberBase60 b = a.wholenumberize();
      expect(b.number, [4, 16, 54, 8]);
      expect(b.seximals, 2);
    });
    test('wholenumberizer reverse', (){
      WholeNumberBase60 b = a.wholenumberize(true);
      expect(b.number, reverse([4, 16, 54, 8]));
      expect(b.reversed, true);
    });
    test('wn toggle reverse', (){
      b = a.wholenumberize(true);
      b.toggle_reverse();
      expect(b.number, [4, 16, 54, 8]);
      expect(b.reversed, false);
    });
    test('wn to int', (){
      a = base_60_math.WholeBase60Number([1, 1, 6], 0);
      b = base_60_math.WholeBase60Number([1, 1, 6], 0);
      expect(a.toInt(), 3666);
      expect(b.toInt(), 3666);

    });
    test('wn to Abs60', (){
      b = a.wholenumberize().to_Abs60();
      expect(b, a);
    });

  });
}