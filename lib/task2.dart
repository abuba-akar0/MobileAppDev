import 'dart:io';

void main() {
  // Step 1: Take name input
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!; // ! means value will not be null

  // Step 2: Take age input
  stdout.write("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!);

  // Step 3: Check eligibility
  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return; // Exit program if under 18
  }

  // Step 4: Ask how many numbers to input
  stdout.write("How many numbers do you want to enter? ");
  int n = int.parse(stdin.readLineSync()!);

  // Step 5: Take N numbers as input and store in list
  List<int> numbers = [];
  for (int i = 0; i < n; i++) {
    stdout.write("Enter number ${i + 1}: ");
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  // Step 6: Process numbers
  int sumEven = 0, sumOdd = 0;
  int largest = numbers[0];
  int smallest = numbers[0];

  for (int num in numbers) {
    // Even / Odd check
    if (num % 2 == 0) {
      sumEven += num;
    } else {
      sumOdd += num;
    }

    // Largest / Smallest check
    if (num > largest) largest = num;
    if (num < smallest) smallest = num;
  }

  print("\n--- Results ---");
  print("Sum of Even Numbers: $sumEven");
  print("Sum of Odd Numbers: $sumOdd");
  print("Largest Number: $largest");
  print("Smallest Number: $smallest");
}
