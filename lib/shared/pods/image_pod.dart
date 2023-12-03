import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationImagePod =
    FutureProvider.family<String, String>((ref, imageUrl) async {
  final dio = Dio();
  final response = await dio.get(imageUrl);

  if (response.statusCode == 200) {
    List<int> imageBytes = response.data;
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  } else {
    throw Exception('Failed to load image');
  }
});
