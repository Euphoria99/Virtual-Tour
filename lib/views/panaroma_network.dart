import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/blocs/theta/theta_bloc.dart';
import 'package:take_save_display_12/data/urls.dart';
import 'package:take_save_display_12/views/hotspot_button.dart';

class PanoramaNetwork extends StatelessWidget {
  const PanoramaNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThetaBloc, ThetaState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Panorama(
              animSpeed: 1.0,
              sensorControl: SensorControl.Orientation,
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
                            if (state.urlIndex < urls.length - 2)
                              {
                                context
                                    .read<ThetaBloc>()
                                    .add(IncrementUrlIndexEvent())
                              }
                            else
                              {
                                context
                                    .read<ThetaBloc>()
                                    .add(ZeroUrlIndexEvent())
                              },
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PanoramaNetwork(),
                              ),
                            )
                          }),
                ),
              ],
              child: Image(
                  image: CachedNetworkImageProvider(urls[state.urlIndex])),
            ),
          ),
        );
      },
    );
  }
}
