import 'dart:math';

class RandomData {
  static final Random randomValue = Random();
  
  static double get getRandomPrice {
    Random randomVlaue = Random();
    double randomPrice =
        double.parse((randomVlaue.nextDouble() * 130.55).toStringAsFixed(2));
    return randomPrice;
  }

  static double get getRandomRate {
    double rate = double.parse(
      (randomValue.nextDouble() + 2).toStringAsFixed(2),
    );

    return rate;
  }

  static int get getRandomCalories {
    int randomCalories = randomValue.nextInt(2000);
    return randomCalories;
  }

  static int get getRandomReviewers {
    Random randomValue = Random();
    int randomReviewers = randomValue.nextInt(10000) + 50;
    return randomReviewers;
  }
}
