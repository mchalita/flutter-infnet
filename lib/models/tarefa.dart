class Tarefa {
  String? id;
  String nome;
  String data;
  String geolocalizacao;

  Tarefa(this.nome, this.data, this.geolocalizacao);

  Tarefa.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        data = json['data'],
        geolocalizacao = json['geolocalizacao'];

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'data': data,
    'geolocalizacao': geolocalizacao,
  };

  static List<Tarefa> listFromJson(Map<String, dynamic> json) {
    List<Tarefa> products = [];

    json.forEach((key, value) { 
      Map<String, dynamic> item = { "id": key, ...value };
      products.add(Tarefa.fromJson(item));
    });

    return products;
  }
}
