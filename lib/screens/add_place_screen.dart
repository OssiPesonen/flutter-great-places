import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titlecontroller = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    print("Selecting image..");
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titlecontroller.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titlecontroller.text, _pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add a new Place')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titlecontroller,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput()
                  ],
                ),
              ),
            )),
            ElevatedButton.icon(
                label: Text(
                  'Add Place',
                  style: TextStyle(fontSize: 16),
                ),
                icon: Icon(Icons.add),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor,
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(8),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                onPressed: () {
                  _savePlace();
                }),
          ],
        ));
  }
}
