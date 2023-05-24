import 'package:pokemon/domain/datasource/pokemon_datasource.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDatasource datasource;

  PokemonRepositoryImpl(this.datasource);
  @override
  Future<List<Pokemon>> getPokemon({int limit = 30, int page = 0}) {
    return datasource.getPokemon(limit: limit, page: page);
  }
}
