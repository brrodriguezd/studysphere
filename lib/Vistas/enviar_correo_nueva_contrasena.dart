import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studysphere/Componentes/app_bar.dart';
import 'package:studysphere/Componentes/pop_up_confirm.dart';
import 'package:studysphere/Componentes/text_forms.dart';
import 'package:studysphere/Controladores/controlador_enviar_correo_nueva_contrasena.dart';
import 'package:studysphere/Controladores/controlador_registro.dart';

class CorreoNuevaContrasena extends StatelessWidget {
  const CorreoNuevaContrasena({super.key,});

  void timerPopUp(GlobalKey<MyPopUpState> keyVisibility) {
    Timer _timer;
    int _start = 2;

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          keyVisibility.currentState?.changeAllow();
        } else {
          _start--;
        }
      },
    );
  }

  @override
  Widget build (BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    GlobalKey<MyPopUpState> _keyVisibility = GlobalKey();

    return Scaffold(
      appBar: appBar(context, "Recuperar contraseña", color: 0),
      resizeToAvoidBottomInset: false,
      body: Container(
        //tamaño de la pantalla
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/Assets/background.png"),
            //llenar el fondo sin importar la relacion de aspecto
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Escribe el correo asociado a la cuenta para enviarte un código de recuperación",
              style: TextStyle(
                color: colorScheme.tertiary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textFormulario(context, recoverEmail, "Correo de recuperación"),
                ElevatedButton(
                  onPressed: () {
                    RegExp regExp = RegExp(r"^[a-zA-Z0-9!#$%&'*+-\/=?^_`{|]+@[a-zA-Z0-9]+(.[a-zA-Z0-9]+)+$");

                    if (recoverEmail.text.isEmpty) {
                      _keyVisibility.currentState?.changeAllow();
                      _keyVisibility.currentState?.isCorrect(false, "Llene el campo");
                      timerPopUp(_keyVisibility);
                    } else if (!regExp.hasMatch(recoverEmail.text)) {
                      _keyVisibility.currentState?.changeAllow();
                      _keyVisibility.currentState?.isCorrect(false, "Ingrese un correo válido");
                      timerPopUp(_keyVisibility);
                    } else {
                      _keyVisibility.currentState?.changeAllow();
                      _keyVisibility.currentState?.isCorrect(true, "Se ha enviado un correo con un código de verificación");
                      timerPopUp(_keyVisibility);
                      irIngresarCodigo(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        //el secondary container es verde en el tema que puse
                        Theme.of(context).colorScheme.secondaryContainer,
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Enviar",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondaryContainer),
                    ),
                  ),
                ),
              ],
            ),
            MyPopUp(key: _keyVisibility,),
          ],
        ),
      ),
    );
  }
}