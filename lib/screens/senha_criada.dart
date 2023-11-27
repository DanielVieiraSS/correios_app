import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SenhaCriada extends StatelessWidget {
  const SenhaCriada({
    super.key,
    required this.number,
    required this.name,
  });

  final int number;
  final String name;

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    changeUsedToTrueSupabase(int senha) async {
      await supabase.from('senhas').update(
        {'used': true},
      ).eq(
        'senha',
        senha,
      );
    }

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
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$name, aguarde o seu atendimento, sua senha é",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
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
                changeUsedToTrueSupabase(number).then(
                  (value) => Navigator.pop(context),
                );
              },
              child: const Text(
                "Ja fui atendido",
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
