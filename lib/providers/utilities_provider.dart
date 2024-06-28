import 'package:flutter_riverpod/flutter_riverpod.dart';

final toNormalTextProvider = Provider((ref) => convertCamelCaseToNormalText);

String convertCamelCaseToNormalText(String camelCase) {
  final buffer = StringBuffer();
  for (int i = 0; i < camelCase.length; i++) {
    if (i == 0) {
      // Convert the first character to uppercase
      buffer.write(camelCase[i].toUpperCase());
    } else if (camelCase[i].toUpperCase() == camelCase[i] && camelCase[i] != '_') {
      // Insert space before uppercase letters and convert the letter to lowercase
      buffer.write(' ');
      buffer.write(camelCase[i]);
    } else {
      buffer.write(camelCase[i]);
    }
  }
  return buffer.toString();
}
