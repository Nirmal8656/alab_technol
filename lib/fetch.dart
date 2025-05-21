import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class fetch extends StatefulWidget {
  const fetch({super.key});

  @override
  _fetchState createState() => _fetchState();
}

class _fetchState extends State<fetch> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Data')),
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(data[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(data[index]['body']),
            ),
          );
        },
      ),
    );
  }
}