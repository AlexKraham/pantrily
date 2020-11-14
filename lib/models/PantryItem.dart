import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/shared/constants.dart';

class PantryItem {
  final String label;
  final String foodId;
  final String area;
  final String category;
  final DateTime date;
  final String imgSrc;
  final int count;
  final String id;

  PantryItem(
      {this.label,
      this.foodId,
      this.area,
      this.category,
      this.date,
      this.imgSrc,
      this.count,
      this.id});

  factory PantryItem.fromFireStore(DocumentSnapshot doc) {
    // data = data ?? { };
    Map data = doc.data();
    return PantryItem(
      id: doc.id,
      label: data['label'] ?? '',
      foodId: data['foodId'] ?? '',
      area: data['area'] ?? '',
      category: data['category'] ?? '',
      date: data['date'].toDate() ?? '',
      imgSrc: data['imgSrc'] ?? kAnonImgSrc,
      count: data['count'] ?? '1',
    );
  }
}
