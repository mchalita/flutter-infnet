import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_disciplina/models/tarefa.dart';

abstract class Repository {
  final _baseUrl = "https://flutter-chalita-default-rtdb.firebaseio.com/";
  final String _resource;

  Repository(this._resource);

  Future<http.Response> getAll() {
    final uri = Uri.parse("$_baseUrl/$_resource.json");
    return http.get(uri);
  } 

  Future<http.Response> save(String data) async {
    final uri = Uri.parse("$_baseUrl/$_resource.json");

    return await http.post(uri, body: data);
  }

  Future<http.Response> get(String id) {
    final uri = Uri.parse("$_baseUrl/$_resource/$id.json");
    return http.get(uri);
  }

  Future<http.Response> update(Tarefa tarefa, String? id) {
    String data = jsonEncode(tarefa.toJson());

    final uri = Uri.parse("$_baseUrl/$_resource/$id.json");
    return http.put(uri, body: data);
  }

  Future<http.Response> delete(Tarefa tarefa) {
    final uri = Uri.parse("$_baseUrl/$_resource/${tarefa.id}.json");
    return http.delete(uri);
  }
}