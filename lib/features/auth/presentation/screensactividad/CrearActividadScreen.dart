import 'package:flutter/material.dart';
import '../../data/models/actividades/ActividadModel.dart';
import '../../data/repositories/ActividadRepository.dart';

class CrearActividadScreen extends StatefulWidget {
  final int usuarioId;

  CrearActividadScreen({required this.usuarioId});

  @override
  _CrearActividadScreenState createState() => _CrearActividadScreenState();
}

class _CrearActividadScreenState extends State<CrearActividadScreen> {
  final _actividadRepository = ActividadRepository();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _tipoController = TextEditingController();
  final _lugarController = TextEditingController();
  final _duracionController = TextEditingController();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  final _personasMinimoController = TextEditingController();
  final _personasMaximoController = TextEditingController();

  bool _isLoading = false;
  bool _isFormVisible = false;
  List<ActividadModel> _actividades = [];
  late int _organizacionId;

  //***************************************************************
  bool _isEditing = false;
  int? _actividadIdEnEdicion;
  //***************************************************************

  @override
  void initState() {
    super.initState();
    _loadOrganizacionId();
  }

  Future<void> _loadOrganizacionId() async {
    try {
      _organizacionId = await _actividadRepository.obtenerOrganizacionId(widget.usuarioId);
      _fetchActividades();
    } catch (e) {
      print('Error al obtener organizacionId: $e');
    }
  }

  Future<void> _fetchActividades() async {
    try {
      final actividades = await _actividadRepository.listarActividadesPorOrganizacion(_organizacionId);
      setState(() {
        _actividades = actividades;
      });
    } catch (e) {
      print('Error al listar actividades: $e');
    }
  }

  Future<void> _crearActividad() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final actividad = ActividadModel(
        id: 0,
        nombre: _nombreController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        tipo: _tipoController.text.trim(),
        lugar: _lugarController.text.trim(),
        duracion: _duracionController.text.trim(),
        fecha: _fechaController.text.trim(),
        hora: _horaController.text.trim(),
        personasMinimo: int.tryParse(_personasMinimoController.text) ?? 0,
        personasMaximo: int.tryParse(_personasMaximoController.text) ?? 0,
        totalPersonasInscritas: 0,
        organizacionId: _organizacionId,
      );

      await _actividadRepository.crearActividad(actividad);
      _fetchActividades();
      _limpiarFormulario();
      setState(() {
        _isFormVisible = false;
      });
    } catch (e) {
      print('Error al crear actividad: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //*************************************************************************************************************************
  Future<void> _actualizarActividad() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final actividad = ActividadModel(
        id: _actividadIdEnEdicion!,
        nombre: _nombreController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        tipo: _tipoController.text.trim(),
        lugar: _lugarController.text.trim(),
        duracion: _duracionController.text.trim(),
        fecha: _fechaController.text.trim(),
        hora: _horaController.text.trim(),
        personasMinimo: int.tryParse(_personasMinimoController.text) ?? 0,
        personasMaximo: int.tryParse(_personasMaximoController.text) ?? 0,
        totalPersonasInscritas: 0,
        organizacionId: _organizacionId,
      );

      await _actividadRepository.actualizarActividad(_actividadIdEnEdicion!, actividad);
      _fetchActividades();
      _limpiarFormulario();
      setState(() {
        _isEditing = false;
        _isFormVisible = false;
      });
    } catch (e) {
      print('Error al actualizar actividad: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _editarActividad(ActividadModel actividad) {
    setState(() {
      _isEditing = true;
      _actividadIdEnEdicion = actividad.id;
      _nombreController.text = actividad.nombre;
      _descripcionController.text = actividad.descripcion;
      _tipoController.text = actividad.tipo;
      _lugarController.text = actividad.lugar;
      _duracionController.text = actividad.duracion;
      _fechaController.text = actividad.fecha;
      _horaController.text = actividad.hora;
      _personasMinimoController.text = actividad.personasMinimo.toString();
      _personasMaximoController.text = actividad.personasMaximo.toString();
      _isFormVisible = true;
    });
  }
  //****************************************************************************************************************

  Future<void> _eliminarActividad(int actividadId) async {
    try {
      await _actividadRepository.eliminarActividad(actividadId);
      _fetchActividades();
    } catch (e) {
      print('Error al eliminar actividad: $e');
    }
  }

  void _limpiarFormulario() {
    _nombreController.clear();
    _descripcionController.clear();
    _tipoController.clear();
    _lugarController.clear();
    _duracionController.clear();
    _fechaController.clear();
    _horaController.clear();
    _personasMinimoController.clear();
    _personasMaximoController.clear();
    _isEditing = false;
    _actividadIdEnEdicion = null;
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() => _isFormVisible = !_isFormVisible);
      },
      backgroundColor: Color(0xFFFF6A00),
      child: Icon(_isFormVisible ? Icons.close : Icons.add, color: Colors.white),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nombreController,
          decoration: InputDecoration(labelText: 'Nombre de la Actividad'),
        ),
        TextField(
          controller: _descripcionController,
          decoration: InputDecoration(labelText: 'Descripción'),
        ),
        TextField(
          controller: _tipoController,
          decoration: InputDecoration(labelText: 'Tipo'),
        ),
        TextField(
          controller: _lugarController,
          decoration: InputDecoration(labelText: 'Lugar'),
        ),
        TextField(
          controller: _duracionController,
          decoration: InputDecoration(labelText: 'Duración'),
        ),
        TextField(
          controller: _fechaController,
          decoration: InputDecoration(labelText: 'Fecha'),
        ),
        TextField(
          controller: _horaController,
          decoration: InputDecoration(labelText: 'Hora'),
        ),
        TextField(
          controller: _personasMinimoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Personas Mínimo'),
        ),
        TextField(
          controller: _personasMaximoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Personas Máximo'),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _isLoading ? null : (_isEditing ? _actualizarActividad : _crearActividad),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3894B6),
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(_isEditing ? 'Actualizar Actividad' : 'Crear Actividad', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear Actividad',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isFormVisible) _buildForm(),
            const SizedBox(height: 16.0),
            Expanded(
              child: _actividades.isNotEmpty
                  ? ListView.builder(
                itemCount: _actividades.length,
                itemBuilder: (context, index) {
                  final actividad = _actividades[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            actividad.nombre,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Descripción: ${actividad.descripcion}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text("Tipo: ${actividad.tipo}", style: TextStyle(fontSize: 15)),
                          Text("Lugar: ${actividad.lugar}", style: TextStyle(fontSize: 15)),
                          Text("Duración: ${actividad.duracion} horas", style: TextStyle(fontSize: 15)),
                          Text("Fecha: ${actividad.fecha}", style: TextStyle(fontSize: 15)),
                          Text("Hora: ${actividad.hora}", style: TextStyle(fontSize: 15)),
                          Text("Personas: ${actividad.personasMinimo} - ${actividad.personasMaximo}", style: TextStyle(fontSize: 15)),
                          Text("Inscritos: ${actividad.totalPersonasInscritas}", style: TextStyle(fontSize: 15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _editarActividad(actividad);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _eliminarActividad(actividad.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  'No hay actividades creadas',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }
}
