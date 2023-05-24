import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/config/theme.dart/fonts_app.dart';
import 'package:pokemon/domain/entities/entities.dart';
import 'package:pokemon/presentation/blocs/pokemon_bloc/pokemon_bloc.dart';
import 'package:pokemon/presentation/widgets/alerts/advice_alert.dart';

class ListPokemonsView extends StatefulWidget {
  const ListPokemonsView({super.key});

  @override
  State<ListPokemonsView> createState() => _ListPokemonsViewState();
}

class _ListPokemonsViewState extends State<ListPokemonsView> {
  final _scrollController = ScrollController();
  int _currentPage = 0;
  late final PokemonsBloc _pokemonBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _pokemonBloc = context.read<PokemonsBloc>();
    if (_pokemonBloc.state.pokemons.isEmpty) {
      _pokemonBloc.loadPokemons(_currentPage);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels + 500 >=
        _scrollController.position.maxScrollExtent) {
      if (_pokemonBloc.state.statusPokemon != StatusPokemon.loading) {
        _currentPage++;
        _pokemonBloc.loadPokemons(_currentPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonBlocState = context.watch<PokemonsBloc>();
    final status = pokemonBlocState.state.statusPokemon;
    final pokemons = pokemonBlocState.state.pokemons;
    final selectedPokemons = pokemonBlocState.state.selectedPokemons;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: pokemons.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];
                    return _ListTilePokemon(
                      isSelected: selectedPokemons.contains(pokemon),
                      pokemon: pokemon,
                    );
                  },
                ),
              ),
            ),
            Visibility(
                visible: status == StatusPokemon.loading,
                child: const CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}

class _ListTilePokemon extends StatelessWidget {
  final Pokemon pokemon;
  final bool isSelected;
  const _ListTilePokemon({
    required this.pokemon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(15),
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                pokemon.sprite,
                fit: BoxFit.fill,
              ),
            ),
            Text(pokemon.name.toUpperCase(),
                textScaleFactor: 1, style: FontsApp.h2),
            const Spacer(),
            Checkbox(
              value: isSelected,
              onChanged: (v) {
                final pokemonBloc = context.read<PokemonsBloc>();
                if (pokemonBloc.state.selectedPokemons.length < 2 ||
                    pokemonBloc.state.selectedPokemons.contains(pokemon)) {
                  pokemonBloc.add(TogglePokemonSelection(pokemon));
                } else {
                  adviceAlert(context,
                      title: 'Aviso',
                      content:
                          'Debes liberar un espacio para seleccionar otro pokemon.');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
