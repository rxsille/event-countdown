import 'package:flutter/material.dart';

const Color black = Color(0xff0b032d);
const Color violet = Color(0xff843b62);
const Color pink = Color(0xfff67e7d);
const Color flesh = Color(0xffffb997);

InputDecoration form = InputDecoration(
  isDense: true,
  labelStyle: TextStyle(
    fontSize: 12.0,
    color: black
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(color: violet)
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(color: violet)
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
  )
);