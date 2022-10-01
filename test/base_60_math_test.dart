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
    test('Abs60<, 2', () {
        expect(a<c, isTrue);
      });
    test('Abs60< Falsey', () {
        expect(b<a, isFalse);



  def test_abs_lt():
  assert a < b

  assert (a < c) is False
  assert not (b < a)


  def test_abs_add():
  a = base_60_math.AbsBase60.from_integer(437)
  b = base_60_math.AbsBase60.zero()
  assert a + b == a
  c = base_60_math.AbsBase60.from_integer(6)
  d = 6 + 437
  assert c + a == base_60_math.AbsBase60.from_integer(d)


  def test_abs_to_float():
  assert float(base_60_math.AbsBase60.from_commas('1,16;15')) == 76.25


  def test_abs_round():
  assert base_60_math.AbsBase60.from_commas('2;59,59,59,59,30').round() \
  == base_60_math.AbsBase60.from_integer(3)


  def test_abs_from_float():
  assert base_60_math.AbsBase60.from_float(76.25) == base_60_math.AbsBase60.from_commas('1,16;15')


  def test_abs_from_float_thirds():
  assert base_60_math.AbsBase60.from_float(1 / 3) == base_60_math.AbsBase60.from_commas(';20
  '
  });

}