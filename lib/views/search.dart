import 'package:flutter/material.dart';
import 'package:nightplayer/module/extention.dart';

class Search extends SearchDelegate<String> {
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.back();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw Container(
      color: Colors.black,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
