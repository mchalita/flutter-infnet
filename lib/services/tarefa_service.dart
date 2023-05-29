import 'dart:convert';
import 'package:http/http.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/repositories/products_repository.dart';

class TarefaService {
  final TarefaRepository _tarefaRepository = TarefaRepository();

  Future<List<Tarefa>> getAll() async {
    try {
      Response response = await _tarefaRepository.getAll();

      if(response.body != "null"){
        Map<String, dynamic> json = jsonDecode(response.body);

        return Tarefa.listFromJson(json);
      }

      return [];
    } catch (err) {
      throw Exception("Problema ao buscar a lista.");
    }
  }

  Future<Response> save(Tarefa tarefa) async {
    try {
      String json = jsonEncode(tarefa.toJson());

      return await _tarefaRepository.save(json);
    } catch (err) {
      throw Exception("Problema ao salvar uma tarefa.");
    }
  }

  Future<Response> update(Tarefa tarefa, String? id) async {
    try {
      return await _tarefaRepository.update(tarefa, id);
    } catch (err) {
      throw Exception("Problema ao atualizar uma tarefa.");
    }
  }

  Future<bool> delete(Tarefa tarefa) async {
    try {
      Response response = await _tarefaRepository.delete(tarefa);

      return response.statusCode == 200;
    } catch (err) {
      throw Exception("Problema ao deletar uma tarefa.");
    }
  }
}