import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'country_menu.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _posts = [];
  List _searchResults = [];
  Country _selectedCountry = Country.id; // Default country is 'id' (Indonesia)

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BERITA TERKINI'),
        actions: [
          CountryMenu(
            selectedCountry: _selectedCountry,
            onCountrySelected: (Country country) {
              setState(() {
                _selectedCountry = country;
                _getData();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                _searchNews(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search news...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.isEmpty
                  ? _posts.length
                  : _searchResults.length,
              itemBuilder: (context, index) {
                final post = _searchResults.isEmpty
                    ? _posts[index]
                    : _searchResults[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 200,
                      child: post['urlToImage'] != null
                          ? Image.network(
                              post['urlToImage'],
                              fit: BoxFit.cover,
                            )
                          : const Center(),
                    ),
                    ListTile(
                      title: Text("${post['title'] ?? 'No Title'}"),
                      subtitle:
                          Text("${post['description'] ?? 'No Deskripsi'}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(post: post)),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getData() async {
    final countryCode = _selectedCountry.toString().split('.').last;
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=e8a4efee342d4ecb9cd5777d9ba33d2f'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data["articles"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _searchNews(String keyword) {
    setState(() {
      _searchResults = _posts
          .where((post) =>
              post['title'].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }
}
