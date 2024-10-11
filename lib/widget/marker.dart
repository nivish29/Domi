import 'dart:ui' as ui;
import 'dart:ui';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkers {
  static Future<BitmapDescriptor> createCustomMarkerBitmap(
      String imagePath) async {
    final int size = 100;
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = AppPallete.whiteColor;

    final Uint8List imageUint8List = await _getBytesFromAsset(imagePath, size);
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo fi = await codec.getNextFrame();

    final double circleRadius = size / 2;
    final double pointerHeight = size / 4;

    final Path path = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleRadius, circleRadius), radius: circleRadius))
      ..moveTo(circleRadius - 15, circleRadius * 2 - 5)
      ..lineTo(circleRadius, size.toDouble())
      ..lineTo(circleRadius + 15, circleRadius * 2 - 5)
      ..close();

    canvas.drawPath(path, paint);

    final Path clipPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleRadius, circleRadius),
          radius: circleRadius - 4));
    canvas.clipPath(clipPath);

    final double scaleFactor = (circleRadius * 2) / fi.image.width;
    final double imageSize = fi.image.width * scaleFactor;
    final double imageOffset = (imageSize - size) / 2;

    canvas.drawImageRect(
        fi.image,
        Rect.fromLTWH(
            0, 0, fi.image.width.toDouble(), fi.image.height.toDouble()),
        Rect.fromLTWH(-imageOffset, -imageOffset, imageSize, imageSize),
        Paint());
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size, size + pointerHeight.toInt());
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
