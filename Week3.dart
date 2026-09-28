// Week3.dart  -  Library Desk Assistant
// Name:Muhammad Ali Shah  Roll no:04072313023

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

double lateFee(int daysLate, double ratePerDay) => (daysLate * ratePerDay);

String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  } else {
    return '$title by $author';
  }
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  var myBookMap = <String, dynamic>{
    'title': title,
    'author': author,
    'year': year,
    'copies': copies,
  };
  return myBookMap;
}

bool isClassic(int year) => year < 2000;

List<String> transformAll(List<String> items, String Function(String) fn) {
  List<String> results = [];
  for (var item in items) {
    results.add(fn(item));
  }
  return results;
}

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) {
    double total = days * rate;
    return total;
  };
}

int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return (n % 10) + sumDigits(n ~/ 10);
}

Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

class Box<T> {
  T value;
  Box(this.value);
}

T firstor<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }
  return items.first;
}

class Pair<A, B> {
  A first;
  B second;
  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}

class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

void part1() {
  print('Part 1');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('Part 2');
  var listToTransform = ['Dart in Action', 'Clean Code'];
  print(transformAll(listToTransform, (s) => s.toUpperCase()));
  print(transformAll(listToTransform, (s) => '$s!'));

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');
  print('Sum of digits: ${sumDigits(35)}');
}

void part3() {
  print('Part 3');
  var titlesList = books.map((b) => b['title'] as String).toList();
  print('Titles: $titlesList');

  var availableBooks = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Available: $availableBooks');

  var totalCopies = books.fold(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');

  var yearsList = books.map((b) => b['year'] as int).toList();
  var oldestYear = yearsList.reduce((min, y) => y < min ? y : min);
  print('Oldest year: $oldestYear');

  var copiedBooks = List.of(books);
  copiedBooks.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  var sortedTitles = copiedBooks.map((b) => b['title'] as String).toList();
  print('By year: $sortedTitles');

  var stockMap = buildStock();
  print('Stock: $stockMap');

  stockMap.forEach((key, val) {
    if (val == 0) {
      print('Out of stock: $key');
    }
  });

  print('Copies of Unknown: ${stockMap['Unknown'] ?? 0}');

  var allTagsSet = {for (var b in books) ...b['tags'] as List<String>};
  print('All tags: $allTagsSet');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('Part 4');
  var myIntBox = Box<int>(5);
  var myStrBox = Box<String>('dart');
  print('Box<int>: ${myIntBox.value}');
  print('Box<String>: ${myStrBox.value}');

  print(firstor(['Dart in Action', 'Clean Code'], 'none'));
  print(firstor<String>([], 'Z'));
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('Part 5');
  var currentStock = buildStock();
  var testTitles = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];

  for (var t in testTitles) {
    try {
      checkOut(currentStock, t);
      print('Checked out: $t');
    } on BookNotAvailableException {
      print('Sorry: "$t" has no copies left');
    } on BookNotFoundException {
      print('Not found: "$t"');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${currentStock['Dart in Action']}');

  try {
    findBook('Missing');
  } catch (e) {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('Part 6');
  print('Fetching...');
  var bookOfDay = await fetchBookOfTheDay();
  print('Book of the day: $bookOfDay');

  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// 1 We choose fold over reduce when we need a starting value, especially if the list might be empty or if we want to return a different type than what's in the list.
// 2 It means the inner function remembers and holds onto a variable from outside its scope. The variable captured in makeCounter was count.
// 3 Dart checks catch blocks from top to bottom, so a general catch (e) would grab everything first and block the specific exception handler from running.
// 4 It compiles because the syntax is correct and returns a Future, but it gives the wrong result because it prints the Future object instead of waiting for the actual data.
