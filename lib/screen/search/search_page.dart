import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:izelakkas/services/webView_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchSearchResults(String query) async {
    final apiKey = '90cf76a29a9447898b12aacf778e1001';
    final url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['articles'];
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  void _performSearch() async {
    final query = _searchController.text;
    final results = await fetchSearchResults(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write what you want see news results'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
            ),
            onSubmitted: (_) => _performSearch(),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final article = _searchResults[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(url: article['url']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
