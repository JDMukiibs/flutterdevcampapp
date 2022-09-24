import 'package:flutter/material.dart';
import 'package:recipe_app_ui/constants/constants.dart';
import 'package:recipe_app_ui/models/models.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final int colorIndex;

  const RecipePage({
    Key? key,
    required this.recipe,
    required this.colorIndex,
  }) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColorsList[widget.colorIndex % cardColorsList.length],
        actions: [
          IconButton(
            onPressed: () {},
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(
              Icons.notifications_active_rounded,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.recipe.uuid,
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 250,
              ),
              decoration: BoxDecoration(
                color: cardColorsList[widget.colorIndex % cardColorsList.length],
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryIconTheme.color,
        unselectedItemColor: Theme.of(context).primaryIconTheme.color,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
