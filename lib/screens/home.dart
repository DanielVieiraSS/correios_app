import 'dart:math';

import 'package:correios_app/screens/senha_criada.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nomeCliente = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    nomeCliente.text = "";
    super.initState();
  }

  @override
  void dispose() {
    nomeCliente.text = "";
    super.dispose();
  }

  insertSupabase(String name) async {
    var rng = Random();
    var number;
    for (var i = 0001; i < 9999; i++) {
      number = rng.nextInt(100);
    }
    await supabase.from('senhas').insert(
      {
        'nome': name,
        'senha': number,
      },
    ).then(
      (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SenhaCriada(
              number: number,
              name: name,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nomeCliente,
          ),
          TextButton(
            onPressed: () {
              insertSupabase(nomeCliente.text);
            },
            child: const Text("Gere sua senha"),
          ),
        ],
      ),
    );
  }
}
