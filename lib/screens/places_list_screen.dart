import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: const Text('No places yet. You can add some!'),
                    ),
                    builder: (context, value, child) => value.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(value.items[index].image),
                              ),
                              title: Text(value.items[index].title),
                              onTap: () {},
                            ),
                          ),
                  ),
      ),
    );
  }
}
