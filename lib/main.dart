import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://192.168.1.4:5000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Manager')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ListPage(type: 'ventes'))),
            child: const Text('Ventes'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ListPage(type: 'achats'))),
            child: const Text('Achats'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ListPage(type: 'stock'))),
            child: const Text('Stock'),
          ),
        ],
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  final String type;
  const ListPage({super.key, required this.type});
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List data = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    final res = await http.get(Uri.parse('$baseUrl/api/${widget.type}'));
    setState(() => data = jsonDecode(res.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.type.toUpperCase())),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(data[i].toString()),
        ),
      ),
    );
  }
}
