import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/data/models/pokemon_response.dart';
import 'mappers.dart';

class PokemonMapper {
  static Pokemon toEntity(PokemonResponse pokemonResponse) {
    return Pokemon(
        id: pokemonResponse.id,
        name: pokemonResponse.name,
        height: pokemonResponse.height,
        weight: pokemonResponse.weight,
        stats: pokemonResponse.stats
            .map((stat) => StatMapper.toEntity(stat))
            .toList(),
        sprite: pokemonResponse.sprites.frontDefault);
  }
}
