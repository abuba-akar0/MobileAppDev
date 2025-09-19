import 'dart:io';

void main() {
  List<int> numbers = [];

  // Taking 6 integers as input
  for (int i = 0; i < 6; i++) {
    stdout.write("Enter integer ${i + 1}: ");

    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  // Calculating sum of odd numbers and finding the smallest number
  int sumOdd = 0;
  int smallest = numbers[0];

  for (int num in numbers) {
    if (num % 2 != 0) {
      sumOdd += num; // Sum of odd numbers
    }
    if (num < smallest) {
      smallest = num; // Finding smallest number
    }
  }

  // Printing results
  print("Sum of odd numbers: $sumOdd");
  print("Smallest number: $smallest");
}
