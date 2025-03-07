extension PrimeExtension on int {
  bool get isPrime =>
      this > 1 &&
      Iterable.generate(this - 2, (i) => i + 2).every((i) => this % i != 0);
}
