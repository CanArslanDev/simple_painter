import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:simple_painter/src/controllers/drawables/background/painter_background.dart';
import 'package:simple_painter/src/controllers/items/painter_item.dart';
import 'package:simple_painter/src/controllers/paint_actions/main/add_item_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/main/background_image_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/main/draw_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/main/erase_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/main/import_paint_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/main/remove_item_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/paint_action.dart';
import 'package:simple_painter/src/controllers/paint_actions/paint_actions.dart';
import 'package:simple_painter/src/controllers/settings/brush_settings.dart';
import 'package:simple_painter/src/controllers/settings/erase_settings.dart';
import 'package:simple_painter/src/controllers/settings/layer_settings.dart';
import 'package:simple_painter/src/helpers/action_service/actions_service.dart';
import 'package:simple_painter/src/helpers/change_item_values_service.dart';
import 'package:simple_painter/src/helpers/layer_service.dart';
import 'package:simple_painter/src/models/brush_model.dart';
import 'package:simple_painter/src/models/import_painter_snapshot_model.dart';
import 'package:simple_painter/src/models/render_item_model.dart';

part 'painter_controller_actions.dart';
part 'painter_controller_items/painter_controller_item_image.dart';
part 'painter_controller_items/painter_controller_item_shape.dart';
part 'painter_controller_items/painter_controller_item_text.dart';
part 'painter_controller_items/painter_controller_items.dart';
part 'painter_controller_items/values/painter_controller_item_image_values.dart';
part 'painter_controller_items/values/painter_controller_item_shape_values.dart';
part 'painter_controller_items/values/painter_controller_item_text_values.dart';
part 'painter_controller_items/values/painter_controller_item_values.dart';
part 'painter_controller_items/values/painter_controller_item_properties.dart';
part 'painter_controller_items/values/painter_controller_paint_values.dart';
part 'painter_controller_items/values/painter_controller_item_custom_widget_values.dart';
part 'painter_controller_items/painter_controller_item_custom_widget.dart';
part 'painter_controller_layer.dart';
part 'painter_controller_main.dart';
part 'painter_controller_paint.dart';
part 'painter_controller_render.dart';
part 'painter_controller_import_export.dart';
part 'painter_controller_value.dart';

/// Controller class for managing painter-related functionalities.
/// This class handles state management, drawing operations, erasing,
/// adding text or images, and other actions for a painting application.
class PainterController extends ValueNotifier<PainterControllerValue> {
  /// Constructor to initialize the controller with default or custom settings.
  PainterController({
    PainterSettings settings = const PainterSettings(),
    Uint8List? backgroundImage,
  }) : this.fromValue(
          PainterControllerValue(
            settings: settings,
            brushColor:
                settings.brush?.color ?? Colors.blue, // Default brush color
            brushSize: settings.brush?.size ?? 5, // Default brush size
            eraseSize: settings.erase?.size ?? 5, // Default erase size
          ),
          backgroundImage: backgroundImage,
        );

  /// Alternate constructor that initializes
  /// the controller with a specific value
  /// and optional background image.
  PainterController.fromValue(super.value, {Uint8List? backgroundImage})
      : background = PainterBackground(
          image: backgroundImage,
          height: value.settings.size.height, // Height scaling for background
          width: value.settings.size.width, // Width scaling for background
        );

  /// GlobalKey used to identify the repaint boundary for rendering images.
  final GlobalKey repaintBoundaryKey = GlobalKey();

  /// Stream controller for broadcasting events related to the painter.
  final StreamController<ControllerEvent> _eventController =
      StreamController<ControllerEvent>.broadcast();

  /// Background object for handling the painting canvas background.
  PainterBackground background = PainterBackground();

  /// Cached image of the background for performance improvements.
  ui.Image? cacheBackgroundImage;

  /// ValueNotifier to track changes in paint actions.
  ValueNotifier<PaintActions> changeActions =
      ValueNotifier<PaintActions>(PaintActions());

  /// Flags to determine the current state of the painter
  /// (drawing, erasing, etc.).
  bool isErasing = false;
  bool isDrawing = false;
  bool editingText = false;
  bool addingText = false;

  /// Rendered image of the painter content.
  RenderItem itemRender = RenderItem();
}
