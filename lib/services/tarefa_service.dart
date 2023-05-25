import 'dart:convert';
import 'package:http/http.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/repositories/products_repository.dart';

class TarefaService {
  final TarefaRepository _tarefaRepository = TarefaRepository();

  Future<List<Tarefa>> getAll() async {
    try {
      Response response = await _tarefaRepository.getAll();

      Map<String, dynamic> json = jsonDecode(response.body);

      return Tarefa.listFromJson(json);
    } catch (err) {
      throw Exception("Problema ao buscar a lista.");
    }
  }

  Future<String> save(Tarefa tarefa) async {
    try {
      String json = jsonEncode(tarefa.toJson());

      Response response = await _tarefaRepository.save(json);

      return jsonDecode(response.body) as String;
    } catch (err) {
      throw Exception("Problema ao salvar uma tarefa.");
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await _tarefaRepository.delete(id);

      return response.statusCode == 200;
    } catch (err) {
      throw Exception("Problema ao deletar uma tarefa.");
    }
  }
}