import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/domain/entities/entities.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';
part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  final PokemonRepository pokemonRepository;

  PokemonsBloc({required this.pokemonRepository})
      : super(const PokemonsState()) {
    on<StatusLoadingPokemons>(_onStatusLoadingPokemons);
    on<LoadPokemons>(_onLoadPokemons);
    on<TogglePokemonSelection>(_onTogglePokemonSelection);
    on<ResetPokemonSelection>(_onResetPokemonSelection);
  }

  void _onStatusLoadingPokemons(
      StatusLoadingPokemons event, Emitter<PokemonsState> emit) {
    emit(state.copyWith(statusPokemon: event.statusLoad));
  }

  void _onLoadPokemons(LoadPokemons event, Emitter<PokemonsState> emit) {
    emit(
      state.copyWith(
        pokemons: [
          ...state.pokemons,
          ...event.pokemons,
        ],
      ),
    );
  }

  Future<void> loadPokemons(int page) async {
    try {
      add(StatusLoadingPokemons(StatusPokemon.loading));

      final newPokemons = await pokemonRepository.getPokemon(page: page);
      add(LoadPokemons(newPokemons));
      add(StatusLoadingPokemons(StatusPokemon.loaded));
    } catch (_) {
      add(StatusLoadingPokemons(StatusPokemon.error));
    }
  }

  void _onTogglePokemonSelection(
      TogglePokemonSelection event, Emitter<PokemonsState> emit) {
    if (state.selectedPokemons.contains(event.pokemon)) {
      List<Pokemon> updatedList = List.from(state.selectedPokemons);
      updatedList.remove(event.pokemon);
      emit(state.copyWith(selectedPokemons: updatedList));
    } else {
      List<Pokemon> updatedList = List.from(state.selectedPokemons);
      updatedList.add(event.pokemon);
      emit(state.copyWith(selectedPokemons: updatedList));
    }
  }

  void _onResetPokemonSelection(
      ResetPokemonSelection event, Emitter<PokemonsState> emit) {
    emit(state.copyWith(selectedPokemons: []));
  }
}
