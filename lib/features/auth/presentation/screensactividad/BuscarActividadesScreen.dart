import 'package:flutter/material.dart';
import '../../data/models/actividades/ActividadModel.dart';
import '../../data/repositories/ActividadRepository.dart';

class BuscarActividadesScreen extends StatefulWidget {
  final int usuarioId;

  BuscarActividadesScreen({required this.usuarioId});

  @override
  _BuscarActividadesScreenState createState() => _BuscarActividadesScreenState();
}

class _BuscarActividadesScreenState extends State<BuscarActividadesScreen> {
  final _actividadRepository = ActividadRepository();
  final TextEditingController _searchController = TextEditingController();
  List<ActividadModel> _actividades = [];
  List<ActividadModel> _filteredActividades = [];
  bool _isLoading = false;
  List<int> _actividadesInscritas = [];

  @override
  void initState() {
    super.initState();
    _fetchActividades();
    _fetchActividadesInscritas();
  }

  Future<void> _fetchActividades() async {
    setState(() => _isLoading = true);
    try {
      final actividades = await _actividadRepository.listarTodasLasActividades();
      setState(() {
        _actividades = actividades;
        _filteredActividades = actividades;
      });
    } catch (e) {
      print('Error al listar actividades: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchActividadesInscritas() async {
    try {
      final voluntarioId = await _actividadRepository.obtenerVoluntarioId(widget.usuarioId);
      setState(() {
      });
    } catch (e) {
      print('Error al obtener actividades inscritas: $e');
    }
  }

  void _filterActividades(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredActividades = _actividades;
      } else {
        _filteredActividades = _actividades
            .where((actividad) => actividad.lugar.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _participarEnActividad(int actividadId) async {
    if (_actividadesInscritas.contains(actividadId)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ya estás inscrito en esta actividad'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    final shouldParticipate = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar inscripción'),
        content: Text('¿Deseas inscribirte en esta actividad?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          TextButton(
            child: Text('Confirmar'),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );

    if (shouldParticipate == true) {
      try {
        final voluntarioId = await _actividadRepository.obtenerVoluntarioId(widget.usuarioId);
        await _actividadRepository.participarEnActividad(actividadId, voluntarioId);

        setState(() {
          _actividadesInscritas.add(actividadId);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Participación registrada con éxito')));
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Hubo un problema al inscribirse. Inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buscar Actividades',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar actividades por lugar',
                prefixIcon: Icon(Icons.search, color: Color(0xFF3894B6)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterActividades,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredActividades.length,
              itemBuilder: (context, index) {
                final actividad = _filteredActividades[index];
                final estaInscrito = _actividadesInscritas.contains(actividad.id);

                return Card(
                  margin: EdgeInsets.only(bottom: 16.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          actividad.nombre,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3894B6),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        _buildInfoRow(Icons.description, 'Descripción', actividad.descripcion),
                        _buildInfoRow(Icons.calendar_today, 'Fecha y Hora', '${actividad.fecha} - ${actividad.hora}'),
                        _buildInfoRow(Icons.location_on, 'Lugar', actividad.lugar),
                        _buildInfoRow(Icons.access_time, 'Duración', '${actividad.duracion} horas'),
                        _buildInfoRow(Icons.people, 'Personas Mínimo', '${actividad.personasMinimo}'),
                        _buildInfoRow(Icons.people_alt, 'Personas Máximo', '${actividad.personasMaximo}'),
                        _buildInfoRow(Icons.group, 'Total Inscritos', '${actividad.totalPersonasInscritas}'),
                        _buildInfoRow(Icons.category, 'Tipo', actividad.tipo),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: estaInscrito ? null : () => _participarEnActividad(actividad.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: estaInscrito ? Colors.grey[400] : Color(0xFF3894B6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: Text(
                              estaInscrito ? 'Inscrito' : 'Participar',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFF3894B6), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
