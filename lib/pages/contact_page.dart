import 'package:contatos_app/models/contato_model.dart';
import 'package:contatos_app/pages/create_contact.dart';
import 'package:contatos_app/repositories/contato/contato.repository.dart';
import 'package:contatos_app/shared/contact-card.dart';
import 'package:contatos_app/shared/custom_appbar.dart';
import 'package:contatos_app/shared/custom_text.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContatosModel contatosModel = ContatosModel(<ContatoModel>[]);
  ContatoRepository contatoRepository = ContatoRepository();
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    load = true;
    setState(() {});
    contatosModel = await contatoRepository.getContacts();
    print("contatos: ${contatosModel.contatoModel}");
    load = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CreateContactPage()));
            }),
        appBar: CustomAppBar(title: "Página de contatos"),
        body: load
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: contatosModel.contatoModel.length,
                itemBuilder: (context, index) {
                  var contato = contatosModel.contatoModel[index];
                  print("contato: $contato");
                  return ContactCard(contatoModel: contato);
                },
              ),
      ),
    );
  }
}
