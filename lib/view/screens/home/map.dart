import 'dart:async';
import 'dart:math';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/trip/bloc/trip_bloc.dart';
import '../../../bloc/trip/bloc/trip_state.dart';
import '../../styles/assets.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> _markers = const <Marker>{};
  late BitmapDescriptor iconPickup;
  static double zoomLevel = 14.4746;
  // static double deviation = 360 / (256 * pow(2, zoomLevel));

  // double maxLat = currentLocation.latitude + deviation;
  // double maxLng = currentLocation.longitude + deviation;
  // double minLat = currentLocation.latitude - deviation;
  // double minLng = currentLocation.longitude - deviation;

  double _maxLat = 38.795179;
  double _maxLon = -9.094789;
  double _minLat = 38.691640;
  double _minLon = -9.223544;

  Future<void> locationMarkerIcon() async {
    iconPickup = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.2, size: Size(10, 10)),
      AppAssets.location,
    );
  }

  Future<void> getMarkers() async {
    // final controller = await _controller!.future;
    // final visibleRegion = await controller.getVisibleRegion();
    // _maxLat = visibleRegion.northeast.latitude;
    // _maxLon = visibleRegion.northeast.longitude;
    // _minLat = visibleRegion.southwest.latitude;
    // _minLon = visibleRegion.southwest.longitude;
    context.read<TripBloc>().add(AppListOfPOI(
        token: accessToken,
        maxLat: _maxLat,
        maxLon: _maxLon,
        minLat: _minLat,
        minLon: _minLon));
  }

  @override
  void initState() {
    super.initState();
    // getMarkers();

    context.read<TripBloc>().add(AppListOfPOI(token: accessToken, maxLat: _maxLat, maxLon: _maxLon , minLat: _minLat, minLon: _minLon));
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

              if(state.status.isLoading){
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state.status.isAllPoi) {
                locationMarkerIcon().then((value){
                  _markers = state.pois!
                      .map(
                        (point) => Marker(
                      markerId: MarkerId('Marker ${Random().nextInt(100)}'),
                      position: LatLng(point.lat, point.lon),
                      infoWindow: InfoWindow(title: point.name),
                      icon: iconPickup,
                    ),
                  )
                      .toSet();
                });

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 55),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: const LatLng(38.7223, -9.1393),
                      zoom: zoomLevel,
                    ),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      if(!_controller.isCompleted){
                        _controller.complete(controller);
                      }
                      // getMarkers();
                    },
                    markers: _markers,
                  ),
                );
              }
              locationMarkerIcon().then((value){
                _markers = state.pois!
                    .map(
                      (point) => Marker(
                    markerId: MarkerId('Marker ${Random().nextInt(100)}'),
                    position: LatLng(point.lat, point.lon),
                    infoWindow: InfoWindow(title: point.name),
                    icon: iconPickup,
                  ),
                )
                    .toSet();
              });
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 55),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(38.7223, -9.1393),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    // getMarkers();
                  },
                  // onCameraMoveStarted: () async {},
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
