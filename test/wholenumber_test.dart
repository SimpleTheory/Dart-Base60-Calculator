def test_wholenumberizer():
AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
List<intb = a.wholenumberize()
expect(b.number, [4, 16, 54, 8]
expect(b.seximals, 2


def test_wholenumberizer_reverse():
AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
WholeNumberBase60 b = a.wholenumberize(true)
expect(b.number, reverse([4, 16, 54, 8]) and b.reversed is true


def test_wholenumber_self_reverse():
AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
b = a.wholenumberize(true)

b.toggle_reverse()
expect(b.number, [4, 16, 54, 8] and b.reversed is false


def test_wholenumber_int():
a = base_60_math.WholeBase60Number([1, 1, 6], 0)
b = base_60_math.WholeBase60Number([1, 1, 6], 0)
expect(int(a), 3666
expect(int(b), 3666


def test_wholenumber_to_abs():
a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
b = a.wholenumberize().to_Abs60()
expect(b, a