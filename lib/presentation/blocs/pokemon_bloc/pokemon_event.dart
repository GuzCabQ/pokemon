part of 'pokemon_bloc.dart';

abstract class PokemonsEvent {
  const PokemonsEvent();
}

class StatusLoadingPokemons extends PokemonsEvent {
  final StatusPokemon statusLoad;

  StatusLoadingPokemons(this.statusLoad);
}

class LoadPokemons extends PokemonsEvent {
  final List<Pokemon> pokemons;

  LoadPokemons(this.pokemons);
}

class TogglePokemonSelection extends PokemonsEvent {
  final Pokemon pokemon;

  TogglePokemonSelection(this.pokemon);
}

class ResetPokemonSelection extends PokemonsEvent {
  ResetPokemonSelection();
}
