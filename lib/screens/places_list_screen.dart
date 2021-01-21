import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places!!'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      child: Center(
                        child: Text(
                            'You have not added any place. Go Ahead, add new place!!'),
                      ),
                      builder: (ctx, greatPlaces, ch) =>
                          greatPlaces.places.length == 0
                              ? ch
                              : ListView.builder(
                                  itemCount: greatPlaces.places.length,
                                  itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                        greatPlaces.places[i].image,
                                      ),
                                    ),
                                    title: Text(greatPlaces.places[i].title),
                                    onTap: () {},
                                  ),
                                ),
                    ),
        ));
  }
}
