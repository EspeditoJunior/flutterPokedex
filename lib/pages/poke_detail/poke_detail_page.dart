import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;

  Color _corPokemon;

  PokeDetailPage({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon pokemon = _pokemonStore.pokemonAtual;
    _corPokemon = ConstsApi.getColorType(type: pokemon.type[0]);
    return Observer(builder: (BuildContext context) { 
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Observer(
            builder: (BuildContext context) {
              _corPokemon = ConstsApi.getColorType(type: _pokemonStore.pokemonAtual.type[0]);
              return AppBar(
                title: Opacity(
                  opacity: 0.5,
                  child: Text(
                  pokemon.name, 
                  style: TextStyle(
                      fontFamily: 'Google', 
                      fontWeight: FontWeight.bold,
                      fontSize: 21
                    )
                  ),
                ),
                backgroundColor: _corPokemon,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back), 
                  onPressed: () {Navigator.pop(context);},
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border), 
                    onPressed: () {},
                  ),
                ],
                elevation: 0,
              );
            },
          )
        ),
        body: Stack(
          children: <Widget>[
            Observer(builder: (context) {
              _corPokemon = ConstsApi.getColorType(type: _pokemonStore.pokemonAtual.type[0]);
              return Container(color: _corPokemon);
            }),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            SlidingSheet(
              elevation: 0,
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                snap: true,
                snappings: [0.7, 1.0],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              builder: (context, state) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                );
              },
            ),
            Positioned(
              top: 60,
              child: SizedBox(
                height: 150,
                width: 400,
                child: PageView.builder(
                  onPageChanged: (index) {
                    _pokemonStore.setPokemonAtual(index: index);
                  },
                  itemCount: _pokemonStore.pokeAPI.pokemon.length,
                  itemBuilder: (BuildContext context, int count) {
                    Pokemon _pokeItem = _pokemonStore.getPokemon(index: count);
                    return CachedNetworkImage (
                      height: 60,
                      width: 60,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                    );
                  },
                )
              )
            )
          ],
        ),
      );
    });
  }
}