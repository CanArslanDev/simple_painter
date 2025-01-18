import 'dart:typed_data';

import 'package:fullstack_example/pages/add_edit_text_page.dart';
import 'package:fullstack_example/widgets/select_image.dart';
// ignore: directives_ordering
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class ListenerService {
  late PainterController controller;
  late BuildContext context;
  Future<void> listen(
    PainterController painterController,
    BuildContext buildContext,
  ) async {
    controller = painterController;
    context = buildContext;
    painterController.eventListener((ControllerEvent event) async {
      if (event is ItemPressEvent) {
        if (event.item is TextItem) {
          await changeTextItemValue(event.item as TextItem);
        } else if (event.item is ImageItem) {
          await changeImageItemValue(event.item as ImageItem);
        } else if (event.item is ShapeItem) {
          await changeShapeItemValue(event.item as ShapeItem);
        } else if (event.item is CustomWidgetItem) {
          await changeCustomWidgetValue(event.item as CustomWidgetItem);
        }
      }
    });
  }

  Future<void> changeTextItemValue(TextItem item) async {
    var text = '';
    await Navigator.push(
      context,
      PageRouteBuilder<Object>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddEditTextPage(
          onDone: (String textFunction) {
            text = textFunction;
          },
          defaultText: item.text,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
    final newItem = item.copyWith(text: text);
    controller.changeTextValues(newItem);
  }

  Future<void> changeImageItemValue(ImageItem item) async {
    final imageUint8List = await showDialog<Uint8List>(
      context: context,
      builder: (context) => const SelectImageDialog(
        title: 'Select Image',
      ),
    );
    if (imageUint8List == null) return;
    final newItem = item.copyWith(image: imageUint8List);
    controller.changeImageValues(newItem);
  }

  Future<void> changeShapeItemValue(ShapeItem item) async {
    var newItem = item;
    final type = item.shapeType;
    if (ShapeType.values.length - 1 == type.index) {
      newItem = item.copyWith(shapeType: ShapeType.values[0]);
    } else {
      newItem = item.copyWith(shapeType: ShapeType.values[type.index + 1]);
    }
    controller.changeShapeValues(newItem);
  }

  Future<void> changeCustomWidgetValue(CustomWidgetItem item) async {
    var newItem = item;

    newItem = item.copyWith(
      widget: item.widget,
      position: item.position,
      borderRadius: item.borderRadius,
      borderColor: item.borderColor,
      borderWidth: item.borderWidth,
      enableGradientColor: item.enableGradientColor,
      gradientStartColor: item.gradientStartColor,
      gradientEndColor: item.gradientEndColor,
      enabled: item.enabled,
      gradientBegin: item.gradientBegin,
      gradientEnd: item.gradientEnd,
      gradientOpacity: item.gradientOpacity,
      size: item.size,
      rotation: item.rotation,
      layer: item.layer,
    );

    controller.changeCustomWidgetValues(newItem);
  }
}
