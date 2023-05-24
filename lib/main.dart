import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/config/router.dart/router.dart';
import 'package:pokemon/data/datasource/pokeapi/pokemon_datasource_pokeapi.dart';
import 'package:pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon/data/services/network_service.dart';
import 'package:pokemon/presentation/blocs/pokemon_bloc/pokemon_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PokemonsBloc>(
            create: (context) => PokemonsBloc(
                pokemonRepository: PokemonRepositoryImpl(
                    PokemonDatasourcePokeapi(NetworkService()))),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: appRouter,
        ));
  }
}
