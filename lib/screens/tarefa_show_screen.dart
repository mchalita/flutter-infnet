import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/providers/tarefa_provider.dart';
import 'package:provider/provider.dart';

class TarefaShowScreen extends StatefulWidget {
  const TarefaShowScreen({super.key});

  @override
  State<TarefaShowScreen> createState() => _TarefaShowScreenState();
}

class _TarefaShowScreenState extends State<TarefaShowScreen> {
  final _nome = TextEditingController();
  DateTime _data = DateTime.now();
  final _geolocalizacao = TextEditingController();
  var tarefaEdit = null;

  @override
  Widget build(BuildContext context) {
    final tarefaProvider = Provider.of<TarefaProvider>(context);

    tarefaEdit = ModalRoute.of(context)?.settings.arguments as Tarefa;

    // Set the initial text values of the TextEditingController instances

    _nome.text = tarefaEdit.nome;
    _data = DateFormat('dd/MM/yyyy HH:mm').parse(tarefaEdit.data);
    _geolocalizacao.text = tarefaEdit.geolocalizacao;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edição"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nome,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data",
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('dd/MM/yyyy HH:mm').format(_data)),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            TextField(
              controller: _geolocalizacao,
              decoration: const InputDecoration(
                labelText: "Localização",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Tarefa tarefa = Tarefa(
                  _nome.text,
                  DateFormat('dd/MM/yyyy HH:mm').format(_data),
                  _geolocalizacao.text,
                );

                await tarefaProvider.update(tarefa, tarefaEdit.id);

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _data,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_data as DateTime),
      );
      if (pickedTime != null) {
        setState(() {
          tarefaEdit.data = DateFormat('dd/MM/yyyy HH:mm').format(DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          ));
        });
      }
    }
  }

}
