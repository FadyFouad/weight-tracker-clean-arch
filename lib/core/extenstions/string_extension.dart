import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension StringExtenstion on String{
  toDateTime() => DateFormat('yyy MMM DD HH:mm').format(DateTime.parse(this));
}