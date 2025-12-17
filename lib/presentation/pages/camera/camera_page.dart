import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  final CameraDescription cameraDescription;

  const CameraPage({super.key, required this.cameraDescription});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.cameraDescription,
      ResolutionPreset.medium
    );

    _initializeControllerFuture = _cameraController.initialize();
  }


  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Take a Picture"),),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _cameraController.takePicture();
            if (!context.mounted) return;

            print('image result: ${image.path}');
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}