import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/views/hotspot_button.dart';
import 'package:take_save_display_12/views/panaroma_network.dart';

class PanoramaWidget extends StatelessWidget {
  final File myFile;
  const PanoramaWidget({Key? key, required this.myFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Panorama(
              animSpeed: 5.0,
              sensorControl: SensorControl.Orientation,
              child: Image.file(myFile),
              hotspots: [
            Hotspot(
              latitude: -15.0,
              longitude: -129.0,
              width: 300,
              height: 300,
              widget: HotSpotButton(
                  text: "Explore ",
                  icon: Icons.open_in_browser,
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PanoramaNetwork(),
                          ),
                        )
                      }),
            ),
          ])),
    );
  }
}
