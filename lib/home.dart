import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const apiKey = "dd0c3606";
const baseUrl = "https://api.hgbrasil.com/finance/stock_price?key=$apiKey";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final symbolController = TextEditingController();
  double stockPrice = 0;

  Future<void> getStockPrice(String symbol) async {
    final response = await http.get(Uri.parse('$baseUrl&symbol=$symbol'));
    final data = json.decode(response.body);
    setState(() {
      stockPrice = data['results'][symbol]['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Consultar Ação na Bolsa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: symbolController,
              decoration: InputDecoration(
                labelText: "Digite o símbolo da ação",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final symbol = symbolController.text;
                if (symbol.isNotEmpty) {
                  getStockPrice(symbol);
                }
              },
              child: Text("Consultar"),
            ),
            SizedBox(height: 16),
            Text(
              "Preço da Ação: ${stockPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
