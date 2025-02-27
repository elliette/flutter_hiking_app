import 'package:flutter/material.dart';

class Hike {
  String title;
  String details;
  DateTime hikeDate;
  HikeDifficulty difficulty;
  String imagePath;

  Hike({
    required this.title,
    required this.hikeDate,
    required this.imagePath,
    this.details = '',
    this.difficulty = HikeDifficulty.easy,
  });
}

enum HikeDifficulty { easy, medium, hard }

(Color, Color) colorsForDifficulty(HikeDifficulty difficulty) {
  switch (difficulty) {
    case HikeDifficulty.easy:
      return (const Color.fromARGB(255, 62, 137, 64), Colors.white60);
    case HikeDifficulty.medium:
      return (const Color.fromARGB(255, 218, 121, 17), Colors.white60);
    case HikeDifficulty.hard:
      return (const Color.fromARGB(255, 218, 30, 17), Colors.white60);
  }
}

String labelTextForDifficulty(
  HikeDifficulty difficulty, {
  bool abbreviated = true,
}) {
  switch (difficulty) {
    case HikeDifficulty.easy:
      return abbreviated ? 'E' : 'EASY';
    case HikeDifficulty.medium:
      return abbreviated ? 'M' : 'MEDIUM';
    case HikeDifficulty.hard:
      return abbreviated ? 'H' : 'HARD';
  }
}

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

final hikeList = [
  Hike(
    title: 'Lost Lake Trail',
    details: 'A beautiful hike around Lost Lake.',
    hikeDate: DateTime.now().add(const Duration(days: 7)),
    difficulty: HikeDifficulty.medium,
    imagePath: 'assets/lake.jpg',
  ),
  Hike(
    title: 'Eagle Peak Summit',
    details: 'A challenging hike to Eagle Peak summit.',
    hikeDate: DateTime(2024, 8, 15),
    difficulty: HikeDifficulty.hard,
    imagePath: 'assets/mountain_summit.jpg',
  ),
  Hike(
    title: "Meadow Walk",
    details: "An easy stroll through meadows of wildflowers.",
    difficulty: HikeDifficulty.easy,
    hikeDate: DateTime(2024, 8, 15),
    imagePath: 'assets/meadow.jpg',
  ),
  Hike(
    title: 'Thousand Island Lake',
    details: 'A hike through Thousand Island Lake nature preserve.',
    hikeDate: DateTime.now().add(const Duration(days: 7)),
    difficulty: HikeDifficulty.medium,
    imagePath: 'assets/thousand_island_lake.jpg',
  ),
  Hike(
    title: 'Peak-to-Peak Trail',
    details: 'A technical scramble up two peaks.',
    hikeDate: DateTime(2024, 8, 15),
    difficulty: HikeDifficulty.hard,
    imagePath: 'assets/mountain_peaks.jpg',
  ),
  Hike(
    title: "Hidden Valley",
    details: "A beautiful hike through a hidden valley.",
    difficulty: HikeDifficulty.easy,
    hikeDate: DateTime(2024, 8, 15),
    imagePath: 'assets/valley.jpg',
  ),
];
