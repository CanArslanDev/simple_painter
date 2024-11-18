import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_painter/src/controllers/custom_paint.dart';
import 'package:flutter_painter/src/controllers/items/painter_item.dart';
import 'package:flutter_painter/src/models/brush_model.dart';
import 'package:flutter_painter/src/views/widgets/items/image_item_widget.dart';
import 'package:flutter_painter/src/views/widgets/items/shape_item_widget.dart';
import 'package:flutter_painter/src/views/widgets/items/text_item_widget.dart';
part 'widgets/painter_widget_item_widget.dart';
part 'widgets/painter_widget_drawing_widget.dart';
part 'widgets/painter_widget_main_widget.dart';
part 'widgets/painter_widget_viewer_widget.dart';

// A StatelessWidget that listens to changes in
//the PainterController and rebuilds its child
//widget when the controller's value changes.
class PainterWidget extends StatelessWidget {
  // Constructor for the PainterWidget, which
  //requires a PainterController instance.
  const PainterWidget({required this.controller, super.key});

  // The PainterController that manages the painting logic and state.
  final PainterController controller;

  // Builds the widget tree by listening to
  //changes in the PainterController's value.
  @override
  Widget build(BuildContext context) {
    // A ValueListenableBuilder listens to
    //changes in the controller and rebuilds the widget when the value changes.
    return ValueListenableBuilder<PainterControllerValue>(
      valueListenable: controller, // The controller is the value to listen to.
      builder: (context, value, child) {
        // Builds and returns the _ViewerWidget, which likely
        //renders the painting or drawing based on the controller's state.
        return _ViewerWidget(controller: controller);
      },
    );
  }
}