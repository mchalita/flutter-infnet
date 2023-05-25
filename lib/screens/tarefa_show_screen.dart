import 'package:flutter/material.dart';
import 'package:projeto_disciplina/models/tarefa.dart';

class TarefaShowScreen extends StatelessWidget {
  const TarefaShowScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Tarefa tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(
        title: Text(tarefa.nome),
      ),
      body: Column(
        children: [
          Text(tarefa.nome,
            style: TextStyle(
              fontSize: 30.0
            ),
          ),
          Text(tarefa.data,
            style: TextStyle(
              fontSize: 30.0
            ),),
          Text(tarefa.geolocalizacao,
            style: TextStyle(
              fontSize: 30.0
            ),)
        ],
      ),
    );
  }
}
