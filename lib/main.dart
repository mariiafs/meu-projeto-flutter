import 'package:flutter/material.dart';

void main() {
  runApp(const PlanoEstudosApp());
}

class PlanoEstudosApp extends StatelessWidget {
  const PlanoEstudosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaEstudos(),
    );
  }
}

class TelaEstudos extends StatefulWidget {
  const TelaEstudos({super.key});

  @override
  State<TelaEstudos> createState() => _TelaEstudosState();
}

class _TelaEstudosState extends State<TelaEstudos> {
  int sessoes = 0;
  bool focoAtivo = false;
  String nome = '';

  void concluirSessao() {
    setState(() {
      sessoes = sessoes + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plano de estudos'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.menu_book,
                size: 64,
                color: focoAtivo ? Colors.teal : Colors.indigo,
              ),
              const SizedBox(height: 16),
              Text(
                nome.isEmpty ? 'Olá, estudante!' : 'Olá, $nome!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Uma sessão por vez.'),

              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sessões concluídas'),
                      SizedBox(height: 8),
                      Text('$sessoes', style: TextStyle(fontSize: 36)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: concluirSessao,
                child: const Text('Concluir sessão'),
              ),
              OutlinedButton(
                onPressed: () {
                  if (sessoes > 0) {
                    setState(() {
                      sessoes = sessoes - 1;
                    });
                  }
                },
                child: const Text('Desfazer uma sessão'),
              ),
              SwitchListTile(
                title: const Text('Modo foco'),
                subtitle: Text(focoAtivo ? 'Ativado' : 'Desativado'),
                value: focoAtivo,
                onChanged: (bool novoValor) {
                  setState(() {
                    focoAtivo = novoValor;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (String valor) {
                  setState(() {
                    nome = valor.trim();
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Seu nome',
                  hintText: 'Digite como quer ser chamado',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => TelaResumo(
                        nome: nome.isEmpty ? 'Estudante' : nome,
                        sessoes: sessoes,
                        focoAtivo: focoAtivo,
                      ),
                    ),
                  );
                },
                child: const Text('Ver resumo'),
              ),
              OutlinedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (modalContext) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Icon(Icons.info_outline, size: 40),
                              Text('Você concluiu $sessoes sessões.'),
                              const Text('Faça uma pausa entre as sessões.'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(modalContext);
                                },
                                child: const Text('Fechar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Ver orientação'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    sessoes = 0;
                    focoAtivo = false;
                  });
                },
                child: const Text('Reiniciar sessões e foco'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaResumo extends StatelessWidget {
  const TelaResumo({
    super.key,
    required this.nome,
    required this.sessoes,
    required this.focoAtivo,
  });

  final String nome;
  final int sessoes;
  final bool focoAtivo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo de estudos')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.assignment, size: 64, color: Colors.indigo),
              const SizedBox(height: 16),
              Text('Estudante: $nome', style: const TextStyle(fontSize: 24)),
              Text('Sessões concluídas: $sessoes'),
              Text(focoAtivo ? 'Foco ativado' : 'Foco desativado'),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar aos estudos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
