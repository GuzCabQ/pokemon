import 'package:pokemon/domain/entities/stat.dart';

class Pokemon {
  final int id;
  final String name;
  final double height;
  final double weight;
  final List<Stat> stats;
  final String sprite;

  Pokemon(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.sprite,
      required this.stats});
}
