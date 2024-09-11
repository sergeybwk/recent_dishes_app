import 'dart:async';

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (_) => 1);
  }
}