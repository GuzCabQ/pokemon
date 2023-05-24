import 'package:dio/dio.dart';
import 'package:pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokemon/data/models/pokemon_response.dart';
import 'package:pokemon/data/models/pokemons_response.dart';
import 'package:pokemon/data/services/network_service.dart';
import 'package:pokemon/domain/datasource/pokemon_datasource.dart';
import 'package:pokemon/domain/entities/pokemon.dart';

import '../../../domain/exceptions/exceptions.dart';

class PokemonDatasourcePokeapi implements PokemonDatasource {
  final NetworkService networkService;

  PokemonDatasourcePokeapi(this.networkService);

  @override
  Future<List<Pokemon>> getPokemon({int limit = 30, int page = 0}) async {
    List<Pokemon> pokemons = [];
    try {
      var response = await networkService.getData(
        'https://pokeapi.co/api/v2/pokemon',
        queryParameters: {'limit': limit, 'offset': page * limit},
      );

      final pokemonsResponse = PokemonsResponse.fromJson(response.data);
      final pokemonsFutures = <Future<Response>>[];
      for (var element in pokemonsResponse.pokemons) {
        pokemonsFutures.add(networkService.getData(element.url));
      }

      final pokemonResponse = await Future.wait(pokemonsFutures);

      for (var pokemonResponse in pokemonResponse) {
        pokemons.add(PokemonMapper.toEntity(
            PokemonResponse.fromJson(pokemonResponse.data)));
      }

      return pokemons;
    } on ServerFailure {
      throw ServerFailure();
    } on NetworkFailure {
      throw NetworkFailure();
    } on UnknownFailure {
      throw UnknownFailure();
    }
  }
}
