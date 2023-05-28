import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/providers/tarefa_provider.dart';
import 'package:provider/provider.dart';

class TarefaInsertScreen extends StatefulWidget {
  const TarefaInsertScreen({super.key});

  @override
  State<TarefaInsertScreen> createState() => _TarefaInsertScreenState();
}

class _TarefaInsertScreenState extends State<TarefaInsertScreen> {
  final _nome = TextEditingController();
  DateTime _data = DateTime.now();
  final _geolocalizacao = TextEditingController();

  @override
  void initState() {
    super.initState();
    getGeoLocalizacao().then((geolocalizacao) {
      _geolocalizacao.text = geolocalizacao;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tarefaProvider = Provider.of<TarefaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
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

                await tarefaProvider.save(tarefa);

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getGeoLocalizacao() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) Future.value("");
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted){
        Future.value("");
      }
    }

    locationData = await location.getLocation();

    return "${locationData.latitude} : ${locationData.longitude}";
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
          _data = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
