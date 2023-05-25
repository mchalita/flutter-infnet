import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:projeto_disciplina/models/tarefa.dart';
import 'package:projeto_disciplina/providers/tarefa_provider.dart';

class TarefaInsertScreen extends StatefulWidget {
  const TarefaInsertScreen({super.key});

  @override
  State<TarefaInsertScreen> createState() => _TarefaInsertScreenState();
}

class _TarefaInsertScreenState extends State<TarefaInsertScreen> {
  final _nome = TextEditingController();
  final _data = TextEditingController();
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
    //final _tarefaProvider = Provider.of<TarefaProvider>(context);

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
            TextField(
              controller: _data,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: "Data",
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
                  _data.text,
                  _geolocalizacao.text,
                );

                //await _tarefaProvider.save(tarefa);
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
}
