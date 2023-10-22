class ContatosModel {
  List<ContatoModel> _contatoModel = [];

  ContatosModel(this._contatoModel);

  List<ContatoModel> get contatoModel => _contatoModel;
  set contatoModel(List<ContatoModel> contatoModel) =>
      _contatoModel = contatoModel;

  ContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _contatoModel = <ContatoModel>[];
      json['results'].forEach((v) {
        _contatoModel!.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this._contatoModel != null) {
      data['results'] = this._contatoModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContatoModel {
  String _objectId = "";
  String _createdAt = "";
  String _updatedAt = "";
  String _nome = "";
  String _imagem = "";
  String _telefone = "";
  String _email = "";
  String _cidade = "";
  String _bairro = "";

  ContatoModel(this._objectId, this._createdAt, this._updatedAt, this._nome,
      this._imagem, this._telefone, this._email, this._cidade, this._bairro);

  ContatoModel.create(this._nome, this._imagem, this._telefone, this._email,
      this._cidade, this._bairro);
  String get objectId => _objectId;
  set objectId(String objectId) => _objectId = objectId;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get imagem => _imagem;
  set imagem(String imagem) => _imagem = imagem;
  String get telefone => _telefone;
  set telefone(String telefone) => _telefone = telefone;
  String get email => _email;
  set email(String email) => _email = email;
  String get cidade => _cidade;
  set cidade(String cidade) => _cidade = cidade;
  String get bairro => _bairro;
  set bairro(String bairro) => _bairro = bairro;

  ContatoModel.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _nome = json['nome'];
    _imagem = json['imagem'];
    _telefone = json['telefone'];
    _email = json['email'];
    _cidade = json['cidade'];
    _bairro = json['bairro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this._nome;
    data['imagem'] = this._imagem;
    data['telefone'] = this._telefone;
    data['email'] = this._email;
    data['cidade'] = this._cidade;
    data['bairro'] = this._bairro;
    return data;
  }
}
