import 'package:flutter/material.dart';
import 'package:projeto_disciplina/providers/tarefa_provider.dart';
import 'package:projeto_disciplina/routes/route_paths.dart';
import 'package:provider/provider.dart';

import '../components/tarefa_list.dart';

class TarefaListScreen extends StatefulWidget {
  TarefaListScreen({super.key});

  @override
  State<TarefaListScreen> createState() => _TarefaListScreenState();
}

class _TarefaListScreenState extends State<TarefaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de tarefas"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TarefaProvider(),
        child: Column(
          children: const [
            TarefaList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            RoutePaths.TAREFA_INSERT_SCREEN
          );
        },
      ),
    );
  }
}
