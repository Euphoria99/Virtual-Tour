import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/blocs/theta/theta_bloc.dart';
import 'package:take_save_display_12/views/image_widget.dart';
import 'package:take_save_display_12/views/panaroma_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThetaBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: BlocBuilder<ThetaBloc, ThetaState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black54,
                  title: const Text("THETA TSD"),
                ),
                body: const HomeScreen());
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThetaBloc, ThetaState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (state.finishedSaving ||
                        state.cameraState == 'initial') {
                      context.read<ThetaBloc>().add(PictureEvent());
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Wait for Process to Complete'),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.amber,
                  ),
                  iconSize: 80,
                ),
              ],
            ),
            state.cameraState == 'inProgress' && state.fileUrl.isEmpty
                ? Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Processing Photo'),
                    ],
                  )
                : state.cameraState == 'done' && state.finishedSaving != true
                    ? Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Saving to Gallery'),
                        ],
                      )
                    : Container(),
            IconButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image == null) return;
                  context.read<ThetaBloc>().add(ImagePickerEvent(image));
                },
                icon: const Icon(Icons.image)),
            state.images != null
                ? ImageWidget(myFile: File(state.images!.path))
                : Container()
          ],
        );
      },
    );
  }
}
