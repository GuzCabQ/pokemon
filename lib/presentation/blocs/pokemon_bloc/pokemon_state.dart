part of 'pokemon_bloc.dart';

class PokemonsState extends Equatable {
  final StatusPokemon statusPokemon;
  final List<Pokemon> pokemons;
  final List<Pokemon> selectedPokemons;

  const PokemonsState(
      {this.statusPokemon = StatusPokemon.initialLoading,
      this.pokemons = const [],
      this.selectedPokemons = const []});

  PokemonsState copyWith(
          {StatusPokemon? statusPokemon,
          List<Pokemon>? pokemons,
          List<Pokemon>? selectedPokemons}) =>
      PokemonsState(
          pokemons: pokemons ?? this.pokemons,
          statusPokemon: statusPokemon ?? this.statusPokemon,
          selectedPokemons: selectedPokemons ?? this.selectedPokemons);

  @override
  List<Object?> get props => [statusPokemon, pokemons, selectedPokemons];
}

enum StatusPokemon { initialLoading, loading, loaded, error }
