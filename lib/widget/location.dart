import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  double? userLatitude;
  double? userLongitude;
  LatLng? pinLocation;
  final MapController _mapController = MapController();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error(
            'GPS is disabled. Please enable it for accurate location.');
      }

      // Request location permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }

      // Get accurate location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 10),
      );

      if (!mounted) return;

      setState(() {
        userLatitude = position.latitude;
        userLongitude = position.longitude;
      });
    } on Exception catch (e) {
      debugPrint('error: $e');
    }
  }

  Future<LatLng?> getCoordinatesFromPlace(String placeName) async {
    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$placeName&format=json&limit=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> result = json.decode(response.body);
        if (result.isNotEmpty) {
          final latitude = double.parse(result[0]['lat']);
          final longitude = double.parse(result[0]['lon']);
          debugPrint('location: $latitude, $longitude');
          return LatLng(latitude, longitude);
        }
      }
      return null;
    } catch (e) {
      print('Error in geocoding: $e');
      return null;
    }
  }

  void _moveToLocation(LatLng newLocation) {
    // Use addPostFrameCallback to ensure the map has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(newLocation, 13); // Move to the searched location
    });

    setState(() {
      pinLocation = newLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 350, // or a specific height
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Enter place name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      final placeName = searchController.text;
                      if (placeName.isNotEmpty) {
                        LatLng? newLocation =
                            await getCoordinatesFromPlace(placeName);
                        if (newLocation != null) {
                          _moveToLocation(
                              newLocation); // Move to the searched location
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Location not found'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: userLatitude != null && userLongitude != null
                  ? FlutterMap(
                      mapController: _mapController, // Pass the controller here
                      options: MapOptions(
                        initialCenter: pinLocation ??
                            LatLng(userLatitude!, userLongitude!),
                        initialZoom: 13,
                        onTap: (tapPosition, point) {
                          setState(() {
                            pinLocation = point;
                            //
                          });
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        if (pinLocation != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: pinLocation!,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
