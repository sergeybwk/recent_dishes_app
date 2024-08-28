import 'dart:async';

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(Duration(seconds: 1), (_) => 1);
  }
  // Stream test = Stream.periodic(const Duration(seconds: 1));
}