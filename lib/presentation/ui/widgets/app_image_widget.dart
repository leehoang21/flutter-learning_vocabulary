// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/theme_color.dart';

// ignore: must_be_immutable
class AppImageWidget extends StatelessWidget {
  final String path;
  bool isRemote = false;
  Widget? placeholder;
  Widget? errorWidget;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;
  double? loadingSize;

  AppImageWidget({
    Key? key,
    required this.path,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.loadingSize,
    this.color,
  }) : super(key: key);

  Widget get _placeholder {
    return Center(
        child: SizedBox(
      width: loadingSize ?? 20.sp,
      height: loadingSize ?? 20.sp,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        strokeWidth: 2,
      ),
    ));
  }

  Widget get _errorWidget {
    return const Center(child: Icon(Icons.error));
  }

  Widget _buildLottieImageWidget() {
    return Image.file(
      File(path),
      fit: fit,
      width: width,
      height: height,
      color: color,
      errorBuilder: (context, error, stackTrace) => errorWidget ?? _errorWidget,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: frame != null ? child : placeholder ?? _placeholder,
        );
      },
    );
  }

  Widget _buildSvgImageWidget() {
    if (isRemote) {
      return SvgPicture.network(
        path,
        fit: fit,
        width: width,
        height: height,
        color: color,
        placeholderBuilder: (context) => placeholder ?? _placeholder,
      );
    }

    return SvgPicture.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      color: color,
      placeholderBuilder: (context) => placeholder ?? _placeholder,
    );
  }

  Widget _buildNormalImageWidget() {
    if (isRemote) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => placeholder ?? _placeholder,
        errorWidget: (context, url, error) => errorWidget ?? _errorWidget,
      );
    }
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      color: color,
      errorBuilder: (context, error, stackTrace) => errorWidget ?? _errorWidget,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: frame != null ? child : placeholder ?? _placeholder,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isRemote = checkRemote();
    if (path.isEmpty) {
      return _errorWidget;
    }
    switch (imageType) {
      case ImageType.file:
        return _buildLottieImageWidget();
      case ImageType.svg:
        return _buildSvgImageWidget();
      default:
        return _buildNormalImageWidget();
    }
  }

  ImageType get imageType {
    int length = path.length;
    String firstString = path.substring(0, 5).toUpperCase();
    String lastString = path.substring(length - 5).toUpperCase();
    if (lastString.contains('.svg'.toUpperCase())) {
      return ImageType.svg;
    } else if (firstString.contains('asset'.toUpperCase())) {
      return ImageType.image;
    } else {
      return ImageType.file;
    }
  }

  bool checkRemote() {
    if (path.contains('http://') || path.contains('https://')) {
      return true;
    }
    return false;
  }
}

enum ImageType { svg, image, file }
