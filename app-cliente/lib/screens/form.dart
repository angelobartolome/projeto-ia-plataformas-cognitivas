import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inadimplencia/ui/button.dart';
import 'package:inadimplencia/viewmodels/form_viemodel.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    FormViewmodel formViewmodel =
        Provider.of<FormViewmodel>(context, listen: true);

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
                "Agora seus dados!",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Para prosseguir, precisamos que você preencha seus dados pessoais.",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    try {
                      formViewmodel.updateAge(int.parse(value));
                    } catch (e) {}
                  }
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Idade',
                  hintText: 'Ex: 18',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Dropdown de sexo
              DropdownButtonFormField(
                items: const [
                  DropdownMenuItem(
                      value: "Masculino", child: Text("Masculino")),
                  DropdownMenuItem(value: "Feminino", child: Text("Feminino")),
                ],
                onChanged: (value) {
                  formViewmodel.updateGender(value.toString());
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Sexo',
                  hintText: 'Ex: Masculino',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  formViewmodel.updateIncome(double.parse(value));
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Renda',
                  hintText: 'Ex: R\$ 2.500,00',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              CustomButton(
                text: "Continuar",
                onPressed: () {
                  Navigator.pushNamed(context, "/loading");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
