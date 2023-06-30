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
   // GoogleMapController? _controller;
  Set<Marker> _markers = const <Marker>{};
  static double zoomLevel =  14.4746;
  static double deviation = 360 / (256 * pow(2, zoomLevel));
  // double maxLat = currentLocation.latitude + deviation;
  // double maxLng = currentLocation.longitude + deviation;
  // double minLat = currentLocation.latitude - deviation;
  // double minLng = currentLocation.longitude - deviation;

  double _maxLat = 0.0;
  double _maxLon = 0.0;
  double _minLat = 0.0;
  double _minLon = 0.0;

  @override
  void initState() {
    super.initState();
    // context.read<TripBloc>().add(AppListOfPOI(token: accessToken, maxLat: _maxLat, maxLon: _maxLon , minLat: _minLat, minLon: _minLon));
    // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // LatLngBounds bounds = LatLngBounds(
    //   northeast: LatLng(maxLat, maxLng),
    //   southwest: LatLng(minLat, minLng),
    // );
    return SafeArea(
      child: BlocConsumer<TripBloc, TripState>(
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
              if (state.status.isAllPoi) {
                _markers = state.pois!
                    .map(
                      (point) => Marker(
                        markerId: MarkerId('Marker ${Random().nextInt(100)}'),
                        position: LatLng(point.lat, point.lon),
                        infoWindow: InfoWindow(title: point.name),
                      ),
                    )
                    .toSet();
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 55),
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
                      _controller.complete(controller);

                    },
                    onCameraMoveStarted: () async{
                      final controller = await _controller!.future;
                      final visibleRegion = await controller.getVisibleRegion();
                      _maxLat =  visibleRegion.northeast.latitude;
                      _maxLon = visibleRegion.northeast.longitude;
                      _minLat = visibleRegion.southwest.latitude;
                      _minLon = visibleRegion.southwest.longitude;
                      context.read<TripBloc>().add(AppListOfPOI(token: accessToken, maxLat: _maxLat, maxLon: _maxLon , minLat: _minLat, minLon: _minLon));
                      },
                    markers: _markers,
                  ),
                );
              }
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 55),
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
                  onCameraMoveStarted: () async{
                    final controller = await _controller!.future;
                    final visibleRegion = await controller.getVisibleRegion();
                    _maxLat =  visibleRegion.northeast.latitude;
                    _maxLon = visibleRegion.northeast.longitude;
                    _minLat = visibleRegion.southwest.latitude;
                    _minLon = visibleRegion.southwest.longitude;
                    context.read<TripBloc>().add(AppListOfPOI(token: accessToken, maxLat: _maxLat, maxLon: _maxLon , minLat: _minLat, minLon: _minLon));
                    // _controller!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 0));
                  },
                  markers: _markers,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
