import 'dart:math';

class RandomData {
  static double get getRandomPrice {
    Random randomVlaue = Random();
    double randomPrice =
        double.parse((randomVlaue.nextDouble() * 130.55).toStringAsFixed(2));
    return randomPrice;
  }

  static double get getRandomRate {
    Random randomVlaue = Random();
    double randomRate =
        double.parse((randomVlaue.nextDouble() * 5.0).toStringAsFixed(2));
    return randomRate;
  }

  static int get getRandomCalories {
    Random randomValue = Random();
    int randomCalories = randomValue.nextInt(2000);
    return randomCalories;
  }

  static int get getRandomReviewers {
    Random randomValue = Random();
    int randomReviewers = randomValue.nextInt(10000);
    return randomReviewers;
  }
}
