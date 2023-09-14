

import 'dart:io';

import 'package:get/get.dart';

import '../../../constants/api/api.dart';
import 'package:http/http.dart' as http;
class ProfileController extends GetxController{



   Future<void> updateUserPhoto(String userId, File? imagePath) async {
  final url = '${Api.url.toString()}user/updateUserPhoto/$userId'; // Replace with your API URL

  var request = http.MultipartRequest('PUT', Uri.parse(url));
  ///request.fields['userId'] = userId;
  
  final photo = await http.MultipartFile.fromPath('photo', imagePath!.path); // Adjust MediaType if needed
  request.files.add(photo);

  var response = await request.send();

  if (response.statusCode == 200) {
    print('User photo updated successfully');
  } else {
    print('Failed to update user photo ${response.statusCode}');
  }
}
}