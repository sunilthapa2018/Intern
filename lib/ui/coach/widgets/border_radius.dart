import 'package:flutter/material.dart';

BorderRadius borderRadius() {
  return const BorderRadius.only(
    topLeft: Radius.circular(5.0),
    topRight: Radius.circular(20.0),
    bottomLeft: Radius.circular(20.0),
    bottomRight: Radius.circular(5.0),
  );
}
