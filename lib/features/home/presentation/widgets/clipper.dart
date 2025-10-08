

import 'package:flutter/material.dart';

class BackWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    //first point of quadratic bezier curve
    var firstStart = Offset(size.width / 5, size.height);
    //second point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 30);

    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    //third point of quadratic bezier curve
    var secondStart = Offset(size.width - (size.width / 3.5), size.height - 50);

    //fourth point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}


class FrontWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    //first point of quadratic bezier curve
    var firstStart = Offset(size.width / 5, size.height);
    //second point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50);

    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    //third point of quadratic bezier curve
    var secondStart = Offset(size.width - (size.width / 3.5), size.height - 105);

    //fourth point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height);

    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}