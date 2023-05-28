import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/services/tarefa_service.dart';


class TarefaProvider with ChangeNotifier {
  List<Tarefa> listTarefa = [];

  Future<List<Tarefa>> getAll() async {
    return await TarefaService().getAll();
  }

  Future<void> save(Tarefa tarefa) async {
    Response response = await TarefaService().save(tarefa);

    if(response.statusCode == 200){
      await getAll();
      notifyListeners();
    }
  }

  Future<void> update(Tarefa tarefa, String? id) async {
    Response response = await TarefaService().update(tarefa, id);

    if(response.statusCode == 200){
      await getAll();
      notifyListeners();
    }
  }

  void delete(Tarefa tarefa) async {
    bool isDeleted = await TarefaService().delete(tarefa);

    if (isDeleted) {
      await getAll();
      notifyListeners();
    }
  }
}