import 'package:sexigesimal_alpha/math/base_60_math.dart' as base_60_math;
import 'package:test/test.dart';


List<T> reverse<T>(List<T> x) => List<T>.from(x.reversed);


base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_integer(346);
base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_integer(643);
base_60_math.AbsBase60 c = base_60_math.AbsBase60.from_integer(346);

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
    //
    // test('abs+0', () {
    //   base_60_math.AbsBase60  a1 = base_60_math.AbsBase60.from_integer(437);
    //   base_60_math.AbsBase60  b1 = base_60_math.AbsBase60.zero();
    //   expect(a1+b1, equals(a1));
    // });
    // test('abs +6', () {
    //   base_60_math.AbsBase60  a1 = base_60_math.AbsBase60.from_integer(437);
    //   base_60_math.AbsBase60  c1 = base_60_math.AbsBase60.from_integer(6);
    //   expect(a1+c1, equals(base_60_math.AbsBase60.from_integer(443)));
    });

    test('abs to double', () {
      expect(base_60_math.AbsBase60.from_commas('1,16;15').toDouble(),
          equals(76.25));
    });


    test('abs round', (){
      base_60_math.AbsBase60  c1 = base_60_math.AbsBase60.from_commas('2;59,59,59,59,30').round();
      print(c1);
      expect(c1, equals(base_60_math.AbsBase60.from_integer(3)));
    });

    test('abs toString()', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('3,4;12');
      expect(a.toString(), equals('3,4;12'));
    });
  group('Abs60 constructors', (){
    test('from commas', (){
      expect(base_60_math.AbsBase60.from_commas('1,11').number, [1,11]);
      expect(base_60_math.AbsBase60.from_commas('1,11').fraction, []);
    });
    test('from commas frac', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('1,1;11');
      expect(a.number, [1,1] );
      expect(a.fraction, [11]);
    });
    test('from commas only frac', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas(';11');
      expect(a.number, [0]);
      expect(a.fraction, [11]);
    });
    test('from_int', (){
      expect(base_60_math.AbsBase60.from_integer(71).number, [1, 11]);

    });
    test('from double to abs', () {
      expect(base_60_math.AbsBase60.from_double(76.25),
          equals(base_60_math.AbsBase60.from_commas('1,16;15')));
    });
    test('from double to abs 1/3', () {
      expect(base_60_math.AbsBase60.from_double(1/3),
          equals(base_60_math.AbsBase60.from_commas(';20')));
    });
    test('from commas ;0,0,1', () {
      expect(base_60_math.AbsBase60.from_commas(';0,0,1')
          .toString(),'0;0,0,1');
    });
    test('from commas -;0,0,1', () {
      expect(base_60_math.Base60.from_commas('-;0,0,1')
          .toString(),'-0;0,0,1');
    });
    test('from commas ;0,0,1,0,0,0', () {
      expect(base_60_math.AbsBase60.from_commas(';0,0,1,0,0,0')
          .toString(),'0;0,0,1');
    });
    test('from commas 0,0,1', () {
      expect(base_60_math.AbsBase60.from_commas('0,0,1')
          .toString(),'1');
    });
    test('from commas 0,0,0', () {
      expect(base_60_math.AbsBase60.from_commas('0,0,0')
          .toString(),'0');
    });
  });
  group('WholeNumber', () {
    base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas(
        '4,16;54,8,0');
    test('wholenumberizer', () {
      base_60_math.WholeBase60Number b = a.wholenumberizer();
      expect(b.number, [4, 16, 54, 8]);
      expect(b.seximals, 2);
    });
    test('wholenumberizer reverse', () {
      base_60_math.WholeBase60Number b = a.wholenumberizer(reverse_: true);
      expect(b.number, reverse([4, 16, 54, 8]));
      expect(b.reversed, true);
    });
    test('wn toggle reverse', () {
      base_60_math.WholeBase60Number b = a.wholenumberizer(reverse_: true);
      b.toggleReverse();
      expect(b.number, [4, 16, 54, 8]);
      expect(b.reversed, false);
    });
    test('wn to int', () {
      base_60_math.WholeBase60Number a = base_60_math.WholeBase60Number(
          number: [1, 1, 6], seximals: 0);
      base_60_math.WholeBase60Number b = base_60_math.WholeBase60Number(
          number: [1, 1, 6], seximals: 0);
      expect(a.toInt(), 3666);
      expect(b.toInt(), 3666);
    });
  });
  group('to Abs', (){
    test('wn to Abs60', () {
      b = a.wholenumberizer().toAbs60();
      a.fraction = base_60_math.remove0sFromEnd(a.fraction);
      print(a);print(b);
      expect(b, a);
    });
    test('wn to Abs60 2', () {
      expect(base_60_math.AbsBase60.from_commas('1,16;15')
          .wholenumberizer()
          .toAbs60(),
          base_60_math.AbsBase60.from_commas('1,16;15'));
    });
    test('wn to Abs60 3', () {
      expect(base_60_math.AbsBase60.from_commas('2,1,16;15,7,8')
          .wholenumberizer()
          .toAbs60(),
          base_60_math.AbsBase60.from_commas('2,1,16;15,7,8'));
    });
    test('wn to Abs60 4', () {
      expect(base_60_math.AbsBase60.from_commas('1;12')
          .wholenumberizer()
          .toAbs60(),
          base_60_math.AbsBase60.from_commas('1;12'));
    });
    test('wn to Abs60 5', () {
      expect(base_60_math.AbsBase60.from_commas(';0,0,1')
          .wholenumberizer()
          .toAbs60(),
          base_60_math.AbsBase60.from_commas(';0,0,1'));
    });
  });
}