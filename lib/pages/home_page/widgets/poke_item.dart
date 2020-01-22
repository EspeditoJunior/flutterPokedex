import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem({Key key, this.name, this.index, this.color, this.num, this.types}) : super(key: key);

 Widget setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Stack(
          children: <Widget>[
            Stack (
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    child: Image.asset(
                      ConstsApp.whitePokeball, 
                      height: 100, 
                      width: 100
                    ),
                    opacity: 0.2,
                  ),
                ), 
                Align(
                  alignment: Alignment.bottomRight,
                  child: CachedNetworkImage (
                    height: 80,
                    width: 80,
                    placeholder: (context, url) => new Container(
                      color: Colors.transparent,
                    ),
                    imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 45.0),
                  child: setTipos(),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: ConstsApi.getColorType(type: types[0]),
          borderRadius: BorderRadius.all(
            Radius.circular(30)
          )
        ),
      ),
    );
  }
}