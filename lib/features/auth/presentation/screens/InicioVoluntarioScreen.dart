import 'package:flutter/material.dart';
import '../../data/models/NoticiaModel.dart';
import '../../data/repositories/NoticiaRepository.dart';

class InicioVoluntarioScreen extends StatefulWidget {
  final String nombre;
  final int usuarioId;

  InicioVoluntarioScreen({
    required this.nombre,
    required this.usuarioId,
  });

  @override
  _InicioVoluntarioScreenState createState() =>
      _InicioVoluntarioScreenState();
}

class _InicioVoluntarioScreenState
    extends State<InicioVoluntarioScreen> {
  final _noticiaRepository = NoticiaRepository();
  List<NoticiaModel> _noticias = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
  }

  Future<void> _fetchNoticias() async {
    setState(() => _isLoading = true);
    try {
      final noticias = await _noticiaRepository.listarTodasLasNoticias();
      setState(() {
        _noticias = noticias;
      });
    } catch (e) {
      print('Error al listar las noticias: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voluntario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    '¡Bienvenido, ${widget.nombre}!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3894B6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Descubre oportunidades para marcar la diferencia en tu comunidad.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/images/img_1.png',
                    height: 200,
                  ),
                  SizedBox(height: 30),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '¿Qué puedes hacer con esta app?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3894B6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '- Explorar actividades de voluntariado.\n'
                                '- Inscribirte y participar en eventos comunitarios.\n'
                                '- Llevar un registro de tus actividades realizadas.',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enterate de las ultimas noticias!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3894B6),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _noticias.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _noticias.length,
                    itemBuilder: (context, index) {
                      final noticia = _noticias[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                noticia.titulo,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                noticia.descripcion,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Fecha de publicación: ${noticia.fechaPublicacion}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : Center(
                    child: Text(
                      'Nada nuevo por aquí',
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
