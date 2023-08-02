import 'package:flutter/material.dart';

Widget loader() {
  return const Center(
    child: SizedBox.square(dimension: 500, child: Center(child: CircularProgressIndicator())),
  );
}
