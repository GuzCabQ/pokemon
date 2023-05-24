import 'package:pokemon/domain/entities/stat.dart';
import 'package:pokemon/data/models/pokemon_response.dart';

class StatMapper {
  static Stat toEntity(StatResponse statResponse) {
    return Stat(baseStat: statResponse.baseStat, name: statResponse.stat.name);
  }
}
