import 'package:flutter/material.dart';
import 'package:odee_front/src/utils/utils.dart';

// ignore: slash_for_doc_comments
/**
  desktop >= 1200
  tablet => 600 && <= 1199
  phone => 300 && <= 599
  whatch >= 0 && <= 299
*/
enum _GridTier { xs, sm, md, lg, xl }

class GridResponsive extends StatelessWidget {
  const GridResponsive({
    super.key,
    required this.children,
    this.xl = 4,
    this.lg = 3,
    this.md = 2,
    this.sm = 1,
    this.xs = 1,
    this.xlPorc,
    this.lgPorc,
    this.mdPorc,
    this.smPorc,
    this.xsPorc,
    this.border = false,
    this.colorBorder = Colors.black,
    this.paddingBottom = 5.0,
    this.paddingLeft = 5.0,
    this.paddingRight = 5.0,
    this.paddingTop = 5.0,
    this.tallaAll,
    this.porcAll,
    this.columMainAxisAlignment = MainAxisAlignment.start,
    this.columCrossAxisAlignment = CrossAxisAlignment.start,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.isExternal = true,
  });

  final List<Widget> children;
  final int xl;
  final int lg;
  final int md;
  final int sm;
  final int xs;
  final List<double>? xlPorc;
  final List<double>? lgPorc;
  final List<double>? mdPorc;
  final List<double>? smPorc;
  final List<double>? xsPorc;
  final int? tallaAll;
  final List<double>? porcAll;
  final bool border;
  final Color colorBorder;  
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final MainAxisAlignment columMainAxisAlignment;
  final CrossAxisAlignment columCrossAxisAlignment;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final bool isExternal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => parent(
        context,
        constraints.maxWidth,
      ),
    );
  }

  Widget parent(BuildContext context, double maxWidth) {
    final w = isExternal ? PageUtils.width(context) : maxWidth;
    double screenWidth = w > PageUtils.xlMin ? PageUtils.xlMin : w;
    /* double screenWidth = PageUtils.width(context) > PageUtils.xlMin ? PageUtils.xlMin : PageUtils.width(context);
    double screenWidth = maxWidth                 > PageUtils.xlMin ? PageUtils.xlMin : maxWidth; */

    _GridTier talla = _getGridTier(screenWidth);
    int rowSegments;

    int fxl = xl;
    int flg = lg;
    int fmd = md;
    int fsm = sm;
    int fxs = xs;
    List<double>? listWidth;
    if (tallaAll != null) {
      fxl = tallaAll!;
      flg = tallaAll!;
      fmd = tallaAll!;
      fsm = tallaAll!;
      fxs = tallaAll!;
    }
    List<double>? fxlPorc = xlPorc;
    List<double>? flgPorc = lgPorc;
    List<double>? fmdPorc = mdPorc;
    List<double>? fsmPorc = smPorc;
    List<double>? fxsPorc = xsPorc;
    if (porcAll != null) {
      fxlPorc = porcAll;
      flgPorc = porcAll;
      fmdPorc = porcAll;
      fsmPorc = porcAll;
      fxsPorc = porcAll;
    }
    switch (talla) {
      case _GridTier.xl:
        rowSegments = fxl;
        listWidth = fxlPorc ?? listWidth;
        break;
      case _GridTier.lg:
        rowSegments = flg;
        listWidth = flgPorc ?? listWidth;
        break;
      case _GridTier.md:
        rowSegments = fmd;
        listWidth = fmdPorc ?? listWidth;
        break;
      case _GridTier.sm:
        rowSegments = fsm;
        listWidth = fsmPorc ?? listWidth;
        break;
      case _GridTier.xs:
        rowSegments = fxs;
        listWidth = fxsPorc ?? listWidth;
        break;
    }
    double width = (screenWidth - 25) / rowSegments;
    int cantColumn = (children.length ~/ rowSegments).toInt();
    int restoColumn = (children.length % rowSegments).toInt();
    cantColumn = (cantColumn < 1 ? 1 : cantColumn) + (restoColumn == 0 ? 0 : 1);
    return Column(
      mainAxisAlignment: columMainAxisAlignment,
      crossAxisAlignment: columCrossAxisAlignment,
      children: List.generate(
        cantColumn,
        (indexC) => Row(
          mainAxisAlignment: rowMainAxisAlignment,
          crossAxisAlignment: rowCrossAxisAlignment,
          children: List.generate(
            rowSegments,
            (indexR) => Container(
              decoration: border
                  ? BoxDecoration(border: Border.all(color: colorBorder))
                  : const BoxDecoration(),
              padding: EdgeInsets.only(
                bottom: paddingBottom,
                left: paddingLeft,
                right: paddingRight,
                top: paddingTop,
              ),
              width: listWidth == null
                  ? width
                  : ((screenWidth - 25) * listWidth[indexR] / 100),
              child: child(children, ((indexC * rowSegments) + indexR)),
            ),
          ),
        ),
      ),
    );
  }

  Widget child(List<Widget> child, int index) {
    bool existe = index < child.length;
    return existe ? child[index] : Container();
  }

  _GridTier _getGridTier(double width) {
    if (width <= PageUtils.xsMax) {
      return _GridTier.xs;
    } else if (width <= PageUtils.smMax) {
      return _GridTier.sm;
    } else if (width <= PageUtils.mdMax) {
      return _GridTier.md;
    } else if (width <= PageUtils.lgMax) {
      return _GridTier.lg;
    } else {
      // width >= 1200
      return _GridTier.xl;
    }
  }
}
