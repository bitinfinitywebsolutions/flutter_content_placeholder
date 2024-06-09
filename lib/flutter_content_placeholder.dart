/// A Flutter library for creating content skeletons or placeholders to be displayed while content is loading.
///
/// The `flutter_content_placeholder` library provides a customizable way to create placeholders for your content
/// while data is being fetched or loaded asynchronously.
///
/// To use this library, simply import `flutter_content_placeholder` and utilize the `ContentPlaceholder` widget
/// to create your content skeletons.
///
/// Example:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_content_placeholder/flutter_content_placeholder.dart';
///
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: ContentPlaceholder(
///         child: MyContentWidget(), // Your content widget
///       ),
///     );
///   }
/// }
/// ```
library flutter_content_placeholder;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A widget that creates a placeholder for content.
///
/// The `ContentPlaceholder` widget can be used to create a placeholder for your content
/// while it is being loaded or fetched asynchronously. It can be used with or without
/// a child widget. If a child widget is provided, the placeholder will overlay the child
/// with a shimmer effect, otherwise, it will create a standalone placeholder block.
class ContentPlaceholder extends StatelessWidget {
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

  /// The child widget that will be overlaid with the placeholder.
  ///
  /// If `child` is `null`, a standalone placeholder block will be created.
  final Widget? child;

  /// The width of the placeholder. If not provided, defaults to `null`.
  final double? width;

  /// The height of the placeholder. If not provided, defaults to `null`.
  final double? height;

  /// The border radius of the placeholder. If not provided, defaults to `_Styles.defaultBorderRadius`.
  final double borderRadius;

  /// The BuildContext for the placeholder. If not provided, defaults to `null`.
  final BuildContext? context;

  /// The spacing around the placeholder.
  ///
  /// If not provided, defaults to `_Styles.defaultSpacing`.
  final EdgeInsets spacing;

  /// The background color of the placeholder block.
  ///
  /// If not provided, defaults to `_Styles.defaultPlaceholderColor`.
  final Color bgColor;

  /// Specifies whether the shimmer animation is enabled.
  ///
  /// If not provided, defaults to `true`.
  final bool isAnimationEnabled;

  /// The color of the shimmer animation highlight.
  ///
  /// If not provided, defaults to `_Styles.defaultPlaceholderHighlight`.
  final Color highlightColor;

  /// Creates a `ContentPlaceholder` widget.
  const ContentPlaceholder({
    super.key,
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

/// Provides default styles used within the `ContentPlaceholder` widget.
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
