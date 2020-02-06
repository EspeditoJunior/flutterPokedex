import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  

  @observable
  PokeApi pokeAPI;

  @action
  getPokemon(int index) {
    return pokeAPI.pokemon[index];
  }

  @action
  setPokemonAtual(int index) {
    return pokeAPI.pokemon[index];
  }

  @action
  getPokemonAtual(int index) {
    return pokeAPI.pokemon[index];
  }

  @action
  fectchPokemonList() {
    pokeAPI = null;
    loadPokeApi().then((pokeList){
      pokeAPI = pokeList;
    });
  }

  @action
  Widget getImage(String numero) {
    return CachedNetworkImage (
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  @action
  

  Future<PokeApi> loadPokeApi() async {
    try {
      final response = await http.get(ConstsApi.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } catch (error) {
      print ("Erro ao carregar lista");

      print ("////////////////////////");
      print (error);
      print ("///////////////////////");

      return null;
    }
  }

}