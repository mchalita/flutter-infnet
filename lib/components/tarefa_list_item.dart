import 'package:flutter/material.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/providers/tarefa_provider.dart';
import 'package:provider/provider.dart';
import '../routes/route_paths.dart';

class TarefaListItem extends StatelessWidget {
  const TarefaListItem(
    this.tarefa, {
    super.key,
  });

  final Tarefa tarefa;

  @override
  Widget build(BuildContext context) {
    final _tarefaProvider = Provider.of<TarefaProvider>(context);

    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _tarefaProvider.delete(tarefa),
      ),
      title: Text(tarefa.nome),
      subtitle: Text(tarefa.geolocalizacao),
      trailing: Text(tarefa.data),
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutePaths.TAREFA_SHOW_SCREEN, arguments: tarefa);
      },
    );
  }
}
