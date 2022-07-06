import 'package:flutter/material.dart';
import 'Parking.dart';
import 'num_of_parking.dart';

class CitySearch extends SearchDelegate<String> {
  final cities = [
    'Cairo',
    'Alexandria',
    'Sharqia',
    'Giza',
    'Aswan',
    'Gharbia',
    'Suez',
    'Dakahlia',
    'Ismailia',
    'Faiyum',
  ];


  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context,'');
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    )
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => Center(
    child: Parking(model: cities.toString(),),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? cities
        : cities.where((city) {
      final cityLower = city.toLowerCase();
      final queryLower = query.toLowerCase();

      return cityLower.startsWith(queryLower);
    }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      var suggestion = suggestions[index];
      final queryText = suggestion.substring(0, query.length);
      final remainingText = suggestion.substring(query.length);

      return ListTile(
        onTap: () {
          query = suggestion;
          showResults(context);
          close(context, suggestion);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NumOfParking(city: suggestion,),
            ),
          );
        },
        leading: Icon(Icons.location_city),
        // title: Text(suggestion),
        title: RichText(
          text: TextSpan(
            text: queryText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: remainingText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}