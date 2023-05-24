import 'package:pokemon/domain/entities/pokemon.dart';

abstract class PokemonDatasource {
  Future<List<Pokemon>> getPokemon({int limit = 30, int page = 0});
}
