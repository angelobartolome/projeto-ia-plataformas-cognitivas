import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inadimplencia/services/face.dart';
import 'package:inadimplencia/service.dart';
import 'package:inadimplencia/viewmodels/form_viemodel.dart';
import 'package:provider/provider.dart';

String asPercents(double value) {
  return (value * 100).toStringAsFixed(1) + "%";
}

class LoadingPictureScreen extends StatefulWidget {
  const LoadingPictureScreen({super.key});

  @override
  State<LoadingPictureScreen> createState() => _LoadingPictureScreenState();
}

class _LoadingPictureScreenState extends State<LoadingPictureScreen> {
  GlobalKey imageKey = GlobalKey();

  FormViewmodel formViewmodel = serviceLocator<FormViewmodel>();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formViewmodel.submit();
    });
  }

  List<Widget> buildLandmarks() {
    if (formViewmodel.isProcessingFace ||
        formViewmodel.deniedByPicture == true) {
      return [];
    }

    if (imageKey.currentContext == null ||
        formViewmodel.faceStudy == null ||
        formViewmodel.faceStudy?.data?.face?.faceDetails?.isEmpty == true) {
      return [];
    }

    var renderObj = imageKey.currentContext!.findRenderObject();

    var height = renderObj!.paintBounds.size.height;
    var width = renderObj.paintBounds.size.width;

    var landmarks =
        formViewmodel.faceStudy!.data!.face!.faceDetails![0].landmarks!;

    return landmarks.map((e) {
      return Positioned(
        left: e.x! * width,
        top: e.y! * height,
        child: Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
      );
    }).toList();
  }

  Widget renderPicture() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              formViewmodel.picturePath != ''
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Image.file(
                        File(formViewmodel.picturePath!),
                        key: imageKey,
                        width: 260,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(),
              ...buildLandmarks()
            ],
          ),
        ),
        renderPictureResult()
      ],
    );
  }

  Widget renderPictureResult() {
    if (formViewmodel.isProcessingFace) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "Por favor, aguarde...",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    if (formViewmodel.deniedByPicture == true) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          formViewmodel.deniedError ??
              "Não foi possível identificar o rosto na foto. Tente novamente mais tarde.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Rosto identificado com sucesso!",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget renderFinalResult() {
    if (formViewmodel.showResult == false) {
      return Container();
    }
    Widget buildResultForModel(int model) {
      if (formViewmodel.modelsResult.isEmpty ||
          model > formViewmodel.modelsResult.length) {
        return Container();
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Modelo ${model + 1}: ",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                (formViewmodel.modelsResult[model]) > 0.5
                    ? "Empréstimo concedido! (${asPercents(formViewmodel.modelsResult[model])})"
                    : "Empréstimo negado! (${asPercents(formViewmodel.modelsResult[model])})",
                style: GoogleFonts.inter(
                  color: (formViewmodel.modelsResult[model]) > 0.5
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ]),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          formViewmodel.reset();
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/",
            (Route<dynamic> route) => false,
          );
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              buildResultForModel(0),
              buildResultForModel(1),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: formViewmodel.isApproved ? Colors.green : Colors.red,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Text(
                  formViewmodel.isApproved
                      ? "Empréstimo concedido!"
                      : "Empréstimo negado!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var formViewmodel = Provider.of<FormViewmodel>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tudo certo!",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Estamos analisando a sua foto, aguarde um momento.",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              renderPicture(),
              const Spacer(),
              renderFinalResult(),
            ],
          ),
        ),
      ),
    );
  }
}
