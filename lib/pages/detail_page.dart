import 'dart:io';

import 'package:contatos_app/models/contato_model.dart';
import 'package:contatos_app/pages/contact_page.dart';
import 'package:contatos_app/repositories/contato/contato.repository.dart';
import 'package:contatos_app/shared/Custom_buttom.dart';
import 'package:contatos_app/shared/custom_appbar.dart';
import 'package:contatos_app/shared/custom_text.dart';
import 'package:contatos_app/shared/show-dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  ContatoModel contatoModel;
  DetailPage({super.key, required this.contatoModel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ContatoRepository contatoRepository = ContatoRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: widget.contatoModel.objectId,
        child: Scaffold(
          appBar: CustomAppBar(title: widget.contatoModel.nome),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Expanded(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /*IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.update_rounded,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),*/
                    IconButton(
                        onPressed: () {
                          contatoRepository
                              .deleteContact(widget.contatoModel.objectId);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ContactPage()));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(
                            File(widget.contatoModel.imagem),
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomText.buildTitle("Nome: "),
                    CustomText.buildSubTitle(widget.contatoModel.nome),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    ShowAlertDialog.buildDialog(context,
                        "Tem certeza que deseja ligar para ${widget.contatoModel.nome} ?",
                        () {
                      String? encodeQueryParameters(
                          Map<String, String> params) {
                        return params.entries
                            .map((MapEntry<String, String> e) =>
                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                      }

// ···
                      final Uri emailLaunchUri = Uri(
                        scheme: 'tel',
                        path: widget.contatoModel.telefone,
                      );

                      launchUrl(emailLaunchUri);
                      Navigator.pop(context);
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.green),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText.buildTitle("Telefone: "),
                      CustomText.buildSubTitle(widget.contatoModel.telefone),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    ShowAlertDialog.buildDialog(context,
                        "Tem certeza que deseja eviar um email para ${widget.contatoModel.nome} ?",
                        () {
                      String? encodeQueryParameters(
                          Map<String, String> params) {
                        return params.entries
                            .map((MapEntry<String, String> e) =>
                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                      }

                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: widget.contatoModel.email,
                      );

                      launchUrl(emailLaunchUri);
                      Navigator.pop(context);
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText.buildTitle("Email: "),
                      Expanded(
                          child: CustomText.buildSubTitle(
                              widget.contatoModel.email)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    ShowAlertDialog.buildDialog(context,
                        "Tem certeza que deseja ver a cidade ${widget.contatoModel.cidade} ?",
                        () async {
                      String encodedCityName =
                          Uri.encodeComponent(widget.contatoModel.cidade);

                      String url =
                          'https://www.google.com/maps?q=$encodedCityName';

                      if (await launchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(
                            url)); // Abra o aplicativo de mapas com a cidade especificada
                      } else {
                        throw 'Não é possível abrir o mapa.';
                      }
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText.buildTitle("Cidade: "),
                      CustomText.buildSubTitle(
                        widget.contatoModel.cidade,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    ShowAlertDialog.buildDialog(context,
                        "Tem certeza que deseja ver o bairo ${widget.contatoModel.bairro} ?",
                        () async {
                      String encodedCityName = Uri.encodeComponent(
                          "${widget.contatoModel.bairro}, ${widget.contatoModel.cidade}");

                      String url =
                          'https://www.google.com/maps?q=$encodedCityName';

                      if (await launchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(
                            url)); // Abra o aplicativo de mapas com a cidade especificada
                      } else {
                        throw 'Não é possível abrir o mapa.';
                      }
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText.buildTitle("Bairro: "),
                      CustomText.buildSubTitle(widget.contatoModel.bairro),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
