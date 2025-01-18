part of '../../painter_controller.dart';

extension PainterControllerItemCustomWidgetValues on PainterController {
  // updates properties for an ImageItem
  void changeCustomWidgetValues(
    CustomWidgetItem item, {
    Widget? widget,
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
      widget: widget ?? item.widget,
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
