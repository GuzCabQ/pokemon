import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/config/theme.dart/fonts_app.dart';
import 'package:pokemon/presentation/blocs/pokemon_bloc/pokemon_bloc.dart';
import 'package:pokemon/domain/entities/pokemon.dart';

class SelectedPokemonsScreen extends StatelessWidget {
  const SelectedPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonsBloc = context.watch<PokemonsBloc>();
    final selectedPokemons = pokemonsBloc.state.selectedPokemons;

    return selectedPokemons.isNotEmpty
        ? ListView.separated(
            itemCount: selectedPokemons.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final pokemon = selectedPokemons[index];
              return _ListTilePokemon(
                pokemon: pokemon,
              );
            },
          )
        : Center(
            child: Text(
              "No se ha seleccionado ningún pokémon",
              textScaleFactor: 1,
              style: FontsApp.body1,
            ),
          );
  }
}

class _ListTilePokemon extends StatelessWidget {
  final Pokemon pokemon;

  const _ListTilePokemon({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: randomColor()),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(pokemon.name.toUpperCase(),
                    textScaleFactor: 1, style: FontsApp.h1),
              ),
              Image.network(
                pokemon.sprite,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height / 3,
              ),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 3,
            children: [
              ...pokemon.stats.map(
                (stat) => FadeInRight(
                  child: Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          stat.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: FontsApp.h2,
                        ),
                        Text(
                          stat.baseStat.toString(),
                          textAlign: TextAlign.center,
                          style: FontsApp.body1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Color randomColor() {
    final random = Random();
    final color = Color.fromRGBO(
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
      1, // Opacity
    );
    return color;
  }
}
