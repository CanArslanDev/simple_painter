part of '../../painter_controller.dart';

extension PainterControllerItemTextValues on PainterController {
  // updates text-related properties for a TextItem
  void changeTextValues(
    TextItem item, {
    TextStyle? textStyle,
    TextAlign? textAlign,
    bool? enableGradientColor,
    Color? gradientStartColor,
    Color? gradientEndColor,
    AlignmentGeometry? gradientBegin,
    AlignmentGeometry? gradientEnd,
    PositionModel? position,
  }) {
    final newItem = item.copyWith(
      textStyle: textStyle ?? item.textStyle,
      textAlign: textAlign ?? item.textAlign,
      enableGradientColor: enableGradientColor ?? item.enableGradientColor,
      gradientStartColor: gradientStartColor ?? item.gradientStartColor,
      gradientEndColor: gradientEndColor ?? item.gradientEndColor,
      gradientBegin: gradientBegin ?? item.gradientBegin,
      gradientEnd: gradientEnd ?? item.gradientEnd,
      position: position ?? item.position,
    );
    _changeItemValues(newItem);
  }
}
