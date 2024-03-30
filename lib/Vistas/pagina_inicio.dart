import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studysphere/Componentes/app_bar.dart';
import 'package:studysphere/Componentes/cards.dart';
import 'package:studysphere/Controladores/controlador_pagina_inicio.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(context, "Study Sphere", menu: true),
      floatingActionButton: menu(colorScheme),
      backgroundColor: colorScheme.background,
      drawer: Drawer(
        width: (size.width * 0.8).clamp(100, 400),
        backgroundColor: colorScheme.primary,
        elevation: 2,
        child: Column(
          children: [
            fotoYConfiguracion(size, context, colorScheme),
            cards(context, Icons.book, 'Asignaturas', irAsignaturas),
            cards(context, Icons.timeline, 'Proyectos', irProyectos),
            cards(context, Icons.view_week, 'Horario', irHorario),
          ],
        ),
      ),
      body: const Center(child: Text('Algo')),
    );
  }

  Padding fotoYConfiguracion(
      Size size, BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: const AssetImage('lib/Assets/no_user.png'),
            width: (size.height * 0.1).clamp(10, 50),
            height: (size.height * 0.1).clamp(10, 50),
          ),
          const Spacer(),
          InkWell(
            onTap: () => irConfiguracion(context),
            child: Icon(
              Icons.settings,
              color: colorScheme.onPrimary,
              size: (size.height * 0.1).clamp(10, 50),
            ),
          ),
        ],
      ),
    );
  }
}

menu(ColorScheme colorScheme) => FloatingActionButton(
      onPressed: () => something(),
      elevation: 2,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      isExtended: true,
      child: const Icon(Icons.add),
    );

something() => print("hace cositas");
