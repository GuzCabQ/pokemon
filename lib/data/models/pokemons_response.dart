class PokemonsResponse {
  final int count;
  final String next;
  final dynamic previous;
  final List<PokemonData> pokemons;

  PokemonsResponse({
    required this.count,
    required this.next,
    this.previous,
    required this.pokemons,
  });

  factory PokemonsResponse.fromJson(Map<String, dynamic> json) =>
      PokemonsResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        pokemons: List<PokemonData>.from(
            json["results"].map((x) => PokemonData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(pokemons.map((x) => x.toJson())),
      };
}

class PokemonData {
  final String name;
  final String url;

  PokemonData({
    required this.name,
    required this.url,
  });

  factory PokemonData.fromJson(Map<String, dynamic> json) => PokemonData(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
