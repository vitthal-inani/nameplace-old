import 'dart:math';
import 'package:flutter/animation.dart';

AnimationController letter;
String randomLetter() => String.fromCharCode(Random().nextInt(26) + 65);
bool admin = false;
String name;
