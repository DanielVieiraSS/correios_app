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

    deleteFromSupabase() async {
      await supabase.from('senhas').delete().match(
        {
          'nome': name,
        },
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$name, aguarde o seu atendimento, sua senha é"),
          Text(
            number.toString(),
          ),
          TextButton(
            onPressed: () {
              deleteFromSupabase().then(
                (value) => Navigator.pop(context),
              );
            },
            child: const Text("Ja fui atendido"),
          ),
        ],
      ),
    );
  }
}
