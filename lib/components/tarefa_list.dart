import 'package:flutter/material.dart';
import 'package:projeto_disciplina/components/tarefa_list_item.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/providers/tarefa_provider.dart';
import 'package:projeto_disciplina/services/tarefa_service.dart';
import 'package:provider/provider.dart';

class TarefaList extends StatelessWidget {
  const TarefaList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> _generateListTarefa(List<Tarefa> listTarefa) {
      return listTarefa.map((tarefa) => TarefaListItem(tarefa)).toList();
    }

    final tarefaProvider = Provider.of<TarefaProvider>(context);

    return FutureBuilder<List<Tarefa>>(
      future: tarefaProvider.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Erro ao buscar tarefa: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final list = snapshot.data;

          if (list != null && list.isNotEmpty) {
            return Expanded(
              child: ListView(
                children: _generateListTarefa(list),
              ),
            );
          } else {
            return const Center(
              child: Text("Nenhuma tarefa cadastrada."),
            );
          }
        } else {
          return const Center(
            child: Text("Nenhuma tarefa cadastrada."),
          );
        }
      },
    );
  }
}
