import 'dart:io';

void main() {
  // Step 1: Take input from user
  stdout.write("Enter the number of rows (n): ");
  int n = int.parse(stdin.readLineSync()!);

  // Step 2: Outer loop controls rows
  for (int i = 1; i <= n; i++) {
    // Step 3: Inner loop prints numbers from 1 to i
    for (int j = 1; j <= i; j++) {
      stdout.write("$j "); // print without newline
    }
    print(""); // move to next line after each row
  }
}
