import 'package:flutter/material.dart';
import 'package:studysphere/Servicios/servicio_proyecto.dart';

// Controlador para crear un proyecto
void crearProyecto(
  BuildContext context,
  String nombreProyecto,
  String materiaProyecto,
  int materiaProyectoId,
  DateTime fechaInicioProyecto,
  DateTime fechaFinalProyecto,
) {
  final ServicioRegistroProyectoBaseDatos servicioBaseDatos =
      ServicioRegistroProyectoBaseDatos();
  // print(nombreProyecto);
  // print(materiaProyecto);
  // print(materiaProyectoId);

  // Convert DateTime to Date
  // String fechaInicioProyectoDate =
  //     fechaInicioProyecto.toLocal().toString().split(' ')[0];
  // String fechaFinalProyectoDate =
  //     fechaFinalProyecto.toLocal().toString().split(' ')[0];

  // print(fechaInicioProyectoDate);
  // print(fechaFinalProyectoDate);

  try {
    servicioBaseDatos.guardarProyectoEnSupabase(
      nombreProyecto,
      fechaInicioProyecto,
      fechaFinalProyecto,
      materiaProyectoId,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proyecto guardado con éxito')),
    );
    Future.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        Navigator.pop(context);
        //Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
      }
    });
  } catch (e) {
    print('Error al guardar el proyecto: $e');
    Future.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        Navigator.pop(context);
        //Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
      }
    });
  }
}

Future<Map<String, int>> getAsignaturas() async {
  final ServicioRegistroProyectoBaseDatos servicioBaseDatosGetAsignaturas =
      ServicioRegistroProyectoBaseDatos();
  return await servicioBaseDatosGetAsignaturas.obtenerAsignaturasPorUsuario();
}
