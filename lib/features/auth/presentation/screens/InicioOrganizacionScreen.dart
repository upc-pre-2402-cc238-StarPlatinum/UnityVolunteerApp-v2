import 'package:flutter/material.dart';
import '../../data/models/NoticiaModel.dart';
import '../../data/repositories/NoticiaRepository.dart';

class InicioOrganizacionScreen extends StatefulWidget {
  final String nombre;
  final int usuarioId;

  InicioOrganizacionScreen({required this.nombre, required this.usuarioId});

  @override
  _InicioOrganizacionScreenState createState() => _InicioOrganizacionScreenState();
}

class _InicioOrganizacionScreenState extends State<InicioOrganizacionScreen> {
  final _noticiaRepository = NoticiaRepository();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaController = TextEditingController();

  bool _isLoading = false;
  bool _isFormVisible = false;
  List<NoticiaModel> _noticias = [];
  late int _organizacionId;

  @override
  void initState() {
    super.initState();
    _loadOrganizacionId();
  }

  Future<void> _loadOrganizacionId() async {
    try {
      _organizacionId = await _noticiaRepository.obtenerOrganizacionId(widget.usuarioId);
      _fetchNoticias();
    } catch (e) {
      print('Error al obtener el id de la organizacion: $e');
    }
  }

  Future<void> _fetchNoticias() async {
    try {
      final noticias = await _noticiaRepository.listarTodasLasNoticias();
      setState(() {
        _noticias = noticias;
      });
    } catch (e) {
      print('Error las listar las noticias: $e');
    }
  }

  Future<void> _crearNoticia() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final noticia = NoticiaModel(
        id: 0,
        titulo: _tituloController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        fechaPublicacion: _fechaController.text.trim(),
        organizacionId: _organizacionId,
      );

      await _noticiaRepository.crearNoticia(noticia);
      _fetchNoticias();
      _limpiarFormulario();
      setState(() {
        _isFormVisible = false;
      });
    } catch (e) {
      print('Error al publicar la noticia: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _limpiarFormulario() {
    _tituloController.clear();
    _descripcionController.clear();
    _fechaController.clear();
  }

  Widget _buildNoticiasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_isFormVisible) _buildForm(),
        const SizedBox(height: 16.0),
        _noticias.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _noticias.length,
          itemBuilder: (context, index) {
            final noticia = _noticias[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text("Fecha de publicación: ${noticia.fechaPublicacion}", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            );
          },
        )
            : Center(
          child: Text(
            'Nada nuevo por aquí',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _tituloController,
          decoration: InputDecoration(labelText: 'Título de la noticia'),
        ),
        TextField(
          controller: _descripcionController,
          decoration: InputDecoration(labelText: 'Descripción de la noticia'),
        ),
        TextField(
          controller: _fechaController,
          decoration: InputDecoration(labelText: 'Fecha de publicación'),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _isLoading ? null : _crearNoticia,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3894B6),
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text('Publicar Noticia', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Organización',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // InicioOrganizacionScreen content
            SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Bienvenido ${widget.nombre}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3894B6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Conecta, organiza y gestiona tus actividades de voluntariado de manera fácil y eficiente.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/images/img.png',
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
                      '¿Qué puedes hacer aquí?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3894B6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- Crear actividades para tu organización.\n'
                          '- Inscribir y gestionar voluntarios.\n'
                          '- Llevar un seguimiento de las actividades realizadas.\n'
                          '- Publicar noticias para promocionar tus eventos.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enterate de las ultimas noticias!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3894B6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Noticias content
            _buildNoticiasSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _isFormVisible = !_isFormVisible);
        },
        backgroundColor: Color(0xFFFF6A00),
        child: Icon(_isFormVisible ? Icons.close : Icons.add, color: Colors.white),
      ),
    );
  }
}
