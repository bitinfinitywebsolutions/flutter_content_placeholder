library flutter_content_placeholder;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContentPlaceholder extends StatelessWidget {
  /// Single block for group of shapes. `block` should be used only inside a `ContentPlaceholder`.
  static Widget block({
    double? width,
    double? height,
    required BuildContext context,
    double topSpacing = 0,
    double leftSpacing = 0,
    double rightSpacing = 0,
    double bottomSpacing = _Styles.defaultSpacingSingle,
    double borderRadius = _Styles.defaultBorderRadius,
  }) {
    return Container(
      width: width,
      height: height ?? _Styles.defaultHeight,
      margin: EdgeInsets.fromLTRB(
        leftSpacing,
        topSpacing,
        rightSpacing,
        bottomSpacing,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: _Styles.defaultBlockColor,
      ),
    );
  }

  /// If child is `null` you will get one block. If child contains some widget, the widget will be covered with placeholder.
  final Widget? child;

  /// Default width will be 100%.
  final double? width;
  final double? height;
  final double borderRadius;
  final BuildContext? context;
  final EdgeInsets spacing;

  /// Blocks background color
  final Color bgColor;

  /// Is shimmer animation needed. Default is `true`.
  final bool isAnimationEnabled;

  /// Shimmer animation gradient color.
  final Color highlightColor;

  const ContentPlaceholder({super.key,
    this.width,
    this.height,
    this.context,
    this.spacing = _Styles.defaultSpacing,
    this.bgColor = _Styles.defaultPlaceholderColor,
    this.highlightColor = _Styles.defaultPlaceholderHighlight,
    this.isAnimationEnabled = true,
    this.borderRadius = _Styles.defaultBorderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveContext = this.context ?? context;
    if (child != null) {
      return Padding(
        padding: spacing,
        child: Shimmer.fromColors(
          baseColor: bgColor,
          highlightColor: highlightColor,
          enabled: isAnimationEnabled,
          child: child!,
        ),
      );
    } else {
      return ContentPlaceholder(
        context: effectiveContext,
        bgColor: bgColor,
        highlightColor: highlightColor,
        isAnimationEnabled: isAnimationEnabled,
        child: ContentPlaceholder.block(
          width: width ?? MediaQuery.of(effectiveContext).size.width,
          height: height,
          context: effectiveContext,
          topSpacing: spacing.top,
          leftSpacing: spacing.left,
          rightSpacing: spacing.right,
          bottomSpacing: spacing.bottom,
          borderRadius: borderRadius,
        ),
      );
    }
  }
}

class _Styles {
  static const double defaultSpacingSingle = 10;
  static const EdgeInsets defaultSpacing =
      EdgeInsets.fromLTRB(0, 0, 0, _Styles.defaultSpacingSingle);
  static const double defaultBorderRadius = 8;
  static const double defaultHeight = 100;
  static const Color defaultBlockColor = Colors.white;
  static const Color defaultPlaceholderColor = Color(0xFFf1f3f4);
  static const Color defaultPlaceholderHighlight = Color(0xFFe4e7e8);
}
