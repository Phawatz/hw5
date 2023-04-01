import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: List<String>.generate(
          150,
          (i) =>
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${i + 1}.png'), // generate a list of 150 Pokemon
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({
    super.key, 
    required this.items,
    });
  

  @override
  Widget build(BuildContext context) {
    bool _isFavorited = false;
    int _favoriteCount = 0;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('Pokemon List($_favoriteCount)'),
        ),
        body: ListView.builder(
          itemCount: items.length ~/
              3, // 3 items per row so we divide the number of items by 3
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                    child: Stack(
                  // Stack is for overlaying Favorite icon on top of image
                  children: [
                    Image.network(items[index * 3]),
                    const FavoriteWidget(),
                  ],
                )),
                Expanded(
                    child: Stack(
                  children: [
                    Image.network(items[index * 3 + 1]),
                    const FavoriteWidget(),
                  ],
                )),
                Expanded(
                    child: Stack(
                  children: [
                    Image.network(items[index * 3 + 2]),
                    const FavoriteWidget(),
                  ],
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: (_isFavorited
              ? const Icon(
                  Icons.favorite,
                  size: 50,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border,
                  size: 50,
                )),
          
          onPressed: _toggleFavorite,
        ),
      ],
    );
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(children: [Expanded(child: Text('')), const FavoriteWidget()]),
  );

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
  
}
