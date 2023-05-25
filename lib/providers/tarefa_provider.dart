import 'package:flutter/material.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/services/tarefa_service.dart';


class TarefaProvider with ChangeNotifier {
  List<Tarefa> listTarefa = [];

  Future<List<Tarefa>> getAll() async {
    if (listTarefa.isEmpty) {
      listTarefa = await TarefaService().getAll();
    }

    return listTarefa;
  }

  Future<String> save(Tarefa tarefa) async {
    return await TarefaService().save(tarefa);
  }

  void delete(Tarefa tarefa) async {
    // bool isDeleted = await ProductsService.delete(product.id);
    // if (isDeleted) {
      // itens.remove(product);
      // notifyListeners();
    // }
  }
}