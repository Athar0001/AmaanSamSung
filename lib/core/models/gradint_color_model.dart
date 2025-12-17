import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GradientColorModel extends Equatable {

  const GradientColorModel({required this.color1, required this.color2});
  final Color color1;
  final Color color2;

  @override
  List<Object?> get props => [color2, color1];
}
