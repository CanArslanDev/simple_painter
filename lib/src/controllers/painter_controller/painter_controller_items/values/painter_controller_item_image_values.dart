part of '../../painter_controller.dart';

extension PainterControllerItemImageValues on PainterController {
  // updates properties for an ImageItem
  void changeImageValues(
    ImageItem item, {
    BoxFit? boxFit,
    BorderRadius? borderRadius,
    Color? borderColor,
    double? borderWidth,
    bool? enableGradientColor,
    Color? gradientStartColor,
    Color? gradientEndColor,
    AlignmentGeometry? gradientBegin,
    AlignmentGeometry? gradientEnd,
    double? gradientOpacity,
    PositionModel? position,
  }) {
    final newItem = item.copyWith(
      fit: boxFit ?? item.fit,
      borderRadius: borderRadius ?? item.borderRadius,
      borderColor: borderColor ?? item.borderColor,
      borderWidth: borderWidth ?? item.borderWidth,
      enableGradientColor: enableGradientColor ?? item.enableGradientColor,
      gradientStartColor: gradientStartColor ?? item.gradientStartColor,
      gradientEndColor: gradientEndColor ?? item.gradientEndColor,
      gradientBegin: gradientBegin ?? item.gradientBegin,
      gradientEnd: gradientEnd ?? item.gradientEnd,
      gradientOpacity: gradientOpacity ?? item.gradientOpacity,
      position: position ?? item.position,
    );
    _changeItemValues(newItem);
  }
}
