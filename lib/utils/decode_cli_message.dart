import 'dart:io';
import 'package:charset/charset.dart';

String decodeCLIMessage(ProcessResult result) {
  if (Platform.isWindows) {
    return cp866.decode(windows1251.encode(result.stdout));
  }
  return result.stdout.toString();
}