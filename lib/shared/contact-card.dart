import 'dart:io';

import 'package:contatos_app/models/contato_model.dart';
import 'package:contatos_app/pages/detail_page.dart';
import 'package:contatos_app/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ContactCard extends StatelessWidget {
  ContatoModel contatoModel;

  ContactCard({
    super.key,
    required this.contatoModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.details,
                        color: Colors.green,
                      ),
                      title: CustomText.buildTitle("Ver detalhes"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DetailPage(contatoModel: contatoModel)));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                      title: CustomText.buildTitle("Compartilhar contato"),
                      onTap: () async {
                        await Share.share(
                            'Nome: ${contatoModel.nome}\nEmail: ${contatoModel.email}\nTelefone: ${contatoModel.telefone}');
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Hero(
          tag: contatoModel.objectId,
          child: Card(
            elevation: 4,
            child: ListTile(
              tileColor: Colors.white70,
              leading: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: contatoModel.imagem.isNotEmpty
                      ? Image.asset(
                          "assets/images/profile.png",
                          // File(
                          //     "/data/user/0/com.juliocesar.bootcamp.secondapp/cache/image_cropper_1697940897359.jpg"),
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.fill,
                        )),
              title: CustomText.buildSubTitle(contatoModel.nome),
              subtitle: CustomText.builddataTitle(contatoModel.telefone),
            ),
          ),
        ));
  }
}
