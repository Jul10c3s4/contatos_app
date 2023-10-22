import 'package:contatos_app/models/contato_model.dart';
import 'package:contatos_app/repositories/contato/custom_dio.dart';

class ContatoRepository {
  var customDio = CustomDio();

  ContatoRepository();
  Future<ContatosModel> getContacts() async {
    var result = await customDio.dio.get("");
    if (result.statusCode == 200) {
      return ContatosModel.fromJson(result.data);
    }
    return ContatosModel(<ContatoModel>[]);
  }

  void createContact(ContatoModel contatoModel) async {
    print("contato: ${contatoModel.toJson()}");
    await customDio.dio.post("", data: contatoModel.toJson());
  }

  void updateContact(ContatoModel contatoModel) async {
    await customDio.dio
        .put("/${contatoModel.objectId}", data: contatoModel.toJson());
  }

  void deleteContact(String id) async {
    await customDio.dio.delete("/$id");
  }
}
