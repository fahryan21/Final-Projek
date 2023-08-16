import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> post;

  const Detail({Key? key, required this.post}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            color: Colors.grey,
            child: widget.post['urlToImage'] != null
                ? Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      widget.post['urlToImage'],
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.post['title'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.post['publishedAt'],
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                if (widget.post['description'] != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDescription = !_showDescription;
                      });
                    },
                    child: const Text(
                      'Show Description',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                if (_showDescription) ...[
                  const SizedBox(height: 10),
                  if (widget.post['description'] != null)
                    Text(
                      widget.post['description'],
                    ),
                  if (widget.post['description'] == null)
                    const Text(
                      'No description available.',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
                const Divider(),
                Text('Author: ${widget.post['author'] ?? 'Unknown'}'),
                Text('Source: ${widget.post['source']['name'] ?? 'Unknown'}'),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
