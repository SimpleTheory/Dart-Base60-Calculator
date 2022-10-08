import 'package:test/test.dart';
import '';

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
    test('from double to abs', () {
      expect(base_60_math.AbsBase60.from_double(76.25),
          equals(base_60_math.AbsBase60.from_commas('1,16;15')));
    });
    test('from double to abs 1/3', () {
      expect(base_60_math.AbsBase60.from_double(1/3),
          equals(base_60_math.AbsBase60.from_commas(';20')));
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
}