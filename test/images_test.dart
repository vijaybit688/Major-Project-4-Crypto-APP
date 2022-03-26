import 'dart:io';

import 'package:cryptocurrency/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.btc).existsSync(), true);
    expect(File(Images.curve).existsSync(), true);
    expect(File(Images.usd).existsSync(), true);
  });
}
