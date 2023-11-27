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
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Center(
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Correios_%282014%29.svg/2560px-Correios_%282014%29.svg.png"),
            ),
          )),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Solicite sua senha para o atendimento!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nomeCliente,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "EX: Daniel",
                labelText: "Digite seu nome",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(10),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xFF00416B),
                ),
              ),
              onPressed: () {
                insertSupabase(nomeCliente.text);
              },
              child: const Text(
                "Gere sua senha",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
