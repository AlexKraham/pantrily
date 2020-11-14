import 'package:flutter/material.dart';
import 'package:pantrily/shared/constants.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key key,
    @required TextEditingController searchController,
    this.press,
  })  : _searchController = searchController,
        super(key: key);

  final TextEditingController _searchController;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xffc96d59),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffc96d59),
                  width: 1.8,
                ),
              ),
              hintText: "Enter search",
            ),
          ),
          SizedBox(height: 5.0),
          FlatButton(
            color: kPrimaryColor,
            onPressed: press,
            child: Text(
              "SEARCH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
