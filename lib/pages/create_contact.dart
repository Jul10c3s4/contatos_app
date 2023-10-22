import 'dart:io';

import 'package:contatos_app/models/contato_model.dart';
import 'package:contatos_app/pages/contact_page.dart';
import 'package:contatos_app/repositories/contato/contato.repository.dart';
import 'package:contatos_app/shared/Custom_buttom.dart';
import 'package:contatos_app/shared/custom-textField.dart';
import 'package:contatos_app/shared/custom_appbar.dart';
import 'package:contatos_app/shared/custom_text.dart';
import 'package:contatos_app/shared/show-dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  XFile? photo;
  final ImagePicker picker = ImagePicker();
  ContatoRepository contatoRepository = ContatoRepository();

  void cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      photo = XFile(croppedFile.path);
      imageController.text = photo!.path.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Cadastrar Contato"),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.camera),
                              title: CustomText.buildSubTitle("Camera"),
                              onTap: () async {
                                photo = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (photo != null) {
                                  String path = (await path_provider
                                          .getApplicationDocumentsDirectory())
                                      .path;
                                  String name = basename(photo!.path);
                                  await photo!.saveTo("$path/$name");
                                  cropImage(photo!);
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.image),
                              title: CustomText.buildSubTitle("galeria"),
                              onTap: () async {
                                photo = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (photo != null) {
                                  cropImage(photo!);
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: photo == null
                                ? const AssetImage("assets/images/profile.png")
                                    as ImageProvider
                                : FileImage(File(photo!.path.toString())),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: CustomText.buildSubTitlePhoto(
                              photo == null ? "Escolher foto" : "")),
                    )),
              ),
            ),
            CustomTextField(
                controller: nomeController,
                hintText: "Exemplo",
                title: "Nome:"),
            CustomTextField(
              controller: telefoneController,
              hintText: "999999999999",
              title: "Número de telefone:",
              inputType: TextInputType.number,
              maxLength: 11,
            ),
            CustomTextField(
              controller: emailController,
              hintText: "exemplo@gmail.com",
              title: "Email:",
              inputType: TextInputType.emailAddress,
            ),
            CustomTextField(
                controller: cidadeController, hintText: "", title: "Cidade:"),
            CustomTextField(
                controller: bairroController, hintText: "", title: "bairro:"),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButtom(
                  title: CustomText.buildTitleButton("Salvar contato"),
                  color: Colors.blue,
                  onPressed: () {
                    if (nomeController.text != "" &&
                        imageController.text != "" &&
                        telefoneController.text != "" &&
                        emailController.text != "" &&
                        cidadeController.text != "" &&
                        bairroController.text != "") {
                      contatoRepository.createContact(ContatoModel.create(
                          nomeController.text,
                          imageController.text,
                          telefoneController.text,
                          emailController.text,
                          cidadeController.text,
                          bairroController.text));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ContactPage()));
                    } else {
                      ShowAlertDialog.buildDialogOk(context,
                          "Preecha todos os campos para salvar  contato!");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
