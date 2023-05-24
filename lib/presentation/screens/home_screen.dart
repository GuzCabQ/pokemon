import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/assets/images/images.dart';
import 'package:pokemon/presentation/blocs/pokemon_bloc/pokemon_bloc.dart';
import 'package:pokemon/presentation/screens/home_screen/views/list_pokemons_view.dart';
import 'package:pokemon/presentation/screens/home_screen/views/selected_pokemons_view.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  final _pageController = PageController();

  void handleScreenChanged(int selectedScreen) {
    screenIndex = selectedScreen;
    _pageController.jumpToPage(selectedScreen);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PokemonsBloc>().add(ResetPokemonSelection());
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Pantallas',
            ),
          ),
          NavigationDrawerDestination(
            label: Text('Pokemon'),
            icon: ImageIcon(AssetImage(ImagesApp.pokeball)),
            selectedIcon: Image(
              image: AssetImage(ImagesApp.pokeball),
              height: 25,
            ),
          ),
          NavigationDrawerDestination(
            label: Text('Selected Pokemons'),
            icon: ImageIcon(AssetImage(ImagesApp.pokemon)),
            selectedIcon: Image(
              image: AssetImage(ImagesApp.pokemon),
              height: 25,
            ),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: const [ListPokemonsView(), SelectedPokemonsScreen()],
      ),
    );
  }
}
