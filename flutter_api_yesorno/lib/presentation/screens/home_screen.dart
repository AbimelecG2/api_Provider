import 'package:flutter/material.dart';
import 'package:flutter_api_yesorno/providers/respuesta_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController questionController = TextEditingController();

  void showResponse(RespuestaProvider respuestaProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (respuestaProvider.mensaje.answer.isNotEmpty)
                Text(respuestaProvider.mensaje.answer),
              if (respuestaProvider.mensaje.image.isNotEmpty)
                Image.network(respuestaProvider.mensaje.image),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final respuestaProvider = context.watch<RespuestaProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Haz una Pregunta')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'Ingresa tu pregunta',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await respuestaProvider.loadRespuesta();
                showResponse(respuestaProvider);
              },
              child: Text('Obtener Respuesta'),
            ),
          ],
        ),
      ),
    );
  }
}
