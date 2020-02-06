import 'package:flutter/material.dart';
import 'package:pokedex/pages/home_page/home_page.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<PokeApiStore>(
          create: (_) => PokeApiStore(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}