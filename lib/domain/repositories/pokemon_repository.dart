import 'package:pokemon/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemon({int limit = 30, int page = 0});
}
