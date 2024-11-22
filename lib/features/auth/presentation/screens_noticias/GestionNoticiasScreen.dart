import 'package:flutter/material.dart';
import '../../data/models/NoticiaModel.dart';
import '../../data/repositories/NoticiaRepository.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GestionNoticiasScreen extends StatefulWidget {
  final int usuarioId;

  GestionNoticiasScreen({required this.usuarioId});

  @override
  _GestionNoticiasScreenState createState() => _GestionNoticiasScreenState();
}

class _GestionNoticiasScreenState extends State<GestionNoticiasScreen> {
  final _noticiaRepository = NoticiaRepository();

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
      print('Error al obtener organizacionId: $e');
    }
  }

  Future<void> _fetchNoticias() async {
    try {
      final noticias = await _noticiaRepository.listarNoticiasPorOrganizacion(_organizacionId);
      setState(() {
        _noticias = noticias;
      });
    } catch (e) {
      print('Error al listar noticias: $e');
    }
  }

  Future<void> _eliminarNoticia(int noticiaId) async {
    try {
      await _noticiaRepository.eliminarNoticia(noticiaId);
      _fetchNoticias();
    } catch (e) {
      print('Error al eliminar noticia: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Administrar noticias publicadas',
            style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _noticias.isNotEmpty
                  ? ListView.builder(
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
                              CachedNetworkImage(
                                imageUrl: noticia.imagenPortada!,
                                width: 80,
                                height: 80,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            Text(
                              noticia.titulo,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("${noticia.descripcion}", style: TextStyle(fontSize: 15)),
                            Text("${noticia.fechaPublicacion}", style: TextStyle(fontSize: 15)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _eliminarNoticia(noticia.id),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  })
                  :Center(
                child: Text(
                  'No se han realizado publicaciones',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}