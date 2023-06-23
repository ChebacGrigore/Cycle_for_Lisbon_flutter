import 'dart:async';
import 'dart:math';
import 'package:cfl/shared/global/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/trip/bloc/trip_bloc.dart';
import '../../../bloc/trip/bloc/trip_state.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> _markers = const <Marker>{};
  static double zoomLevel =  14.4746;
  static double deviation = 360 / (256 * pow(2, zoomLevel));
  double maxLat = currentLocation.latitude + deviation;
  double maxLng = currentLocation.longitude + deviation;
  double minLat = currentLocation.latitude - deviation;
  double minLng = currentLocation.longitude - deviation;

  @override
  void initState() {
    super.initState();
    context.read<TripBloc>().add(AppListOfPOI(token: accessToken, maxLat: maxLat, maxLon: maxLng , minLat: maxLat, minLon: minLng));
    // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(maxLat, maxLng),
      southwest: LatLng(minLat, minLng),
    );
    return BlocConsumer<TripBloc, TripState>(
      listener: (context, state) {
        if (state.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      state.exception.toString(),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<TripBloc, TripState>(
          builder: (context, state) {
            print(state.status);
            if (state.status.isAllPoi) {
              print(state.pois!.length);
              _markers = state.pois!
                  .map(
                    (point) => Marker(
                      markerId: MarkerId('Merker ${Random().nextInt(100)}'),
                      position: LatLng(point.lat, point.lon),
                      infoWindow: InfoWindow(title: point.name),
                    ),
                  )
                  .toSet();
              return SizedBox(
                width: double.infinity,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
                    zoom: zoomLevel,
                  ),
                  myLocationEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 0));
                  },
                  markers: _markers,
                ),
              );
            }
            return SizedBox(
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            );
          },
        );
      },
    );
  }
}
