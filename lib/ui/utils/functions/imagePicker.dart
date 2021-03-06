import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:urawai_pos/core/Provider/general_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

Future<bool> uploadAndSavetoFirebase({
  GeneralProvider appState,
  @required String shopName,
  File imageFile,
  String id,
  String productName,
  double productPrice,
  double discount,
  String productCategory,
  bool isPopular,
}) async {
  try {
    File compressedImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      imageFile.path + '.jpg',
      quality: 70,
    );

    if (compressedImage != null) {
      appState.isLoading = true;

      String filename = path.basename(imageFile.path);

      //upload image to firebase stroage
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = storageReference.putFile(compressedImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      if (uploadTask.isComplete) {
        //update photo url
        String photoUrl = await storageReference.getDownloadURL();
        String uuid = Uuid().v1();
        Firestore.instance
            .collection(shopName + '_products')
            .document(uuid)
            .setData({
          'id': uuid,
          'productName': productName,
          'price': productPrice,
          'discount': discount ?? 0,
          'isPopuler': isPopular,
          'category': productCategory,
          'photo_url': photoUrl
        }).whenComplete(() {
          print(
              ' Total file size : ${((taskSnapshot.bytesTransferred) / 1024).toStringAsFixed(0)} KB');
          appState.isLoading = false;
        });
      }
    }
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> uploadAndEditDocument({
  GeneralProvider appState,
  @required String shopName,
  File imageFile,
  String id,
  String productName,
  double productPrice,
  double discount,
  String productCategory,
  bool isPopular,
}) async {
  if (imageFile == null) {
    try {
      Firestore.instance
          .collection(shopName + '_products')
          .document(id)
          .updateData({
        'productName': productName,
        'price': productPrice,
        'discount': discount ?? 0,
        'isPopuler': isPopular,
        'category': productCategory,
      }).whenComplete(() {
        appState.isLoading = false;
      });
    } catch (e) {
      return false;
    }
  } else if (imageFile != null) {
    //only update the other column not the image

    print('produk id: $id');

    try {
      File compressedImage = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        imageFile.path + '.jpg',
        quality: 70,
      );

      if (compressedImage != null) {
        appState.isLoading = true;

        String filename = path.basename(imageFile.path);

        //upload image to firebase stroage
        StorageReference storageReference =
            FirebaseStorage.instance.ref().child(filename);
        StorageUploadTask uploadTask =
            storageReference.putFile(compressedImage);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

        if (uploadTask.isComplete) {
          //update photo url
          String photoUrl = await storageReference.getDownloadURL();
          Firestore.instance
              .collection(shopName + '_products')
              .document(id)
              .updateData({
            'productName': productName,
            'price': productPrice,
            'discount': discount ?? 0,
            'isPopuler': isPopular,
            'category': productCategory,
            'photo_url': photoUrl
          }).whenComplete(() {
            print(
                ' (EDIT MODE) Total file size : ${((taskSnapshot.bytesTransferred) / 1024).toStringAsFixed(0)} KB');
            appState.isLoading = false;
          });
        }
      }
    } catch (e) {
      return false;
    }
  }
  return true;
}
