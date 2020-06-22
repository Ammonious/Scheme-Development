import 'package:flutter/material.dart';
import 'package:scheme_components/src/navigation/models/scheme_nav_data.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:supercharged/supercharged.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';
 

class NavBtnIcon extends StatelessWidget {
	final SchemeNavData data;
	final bool isSelected;
	final bool animate;
NavBtnIcon({Key key, this.data, this.isSelected = false, this.animate}) : super(key: key);

  @override
  Widget build(BuildContext context) {

	  final colorScheme = isSelected ? data.selectedScheme : data.unSelectedScheme;
	  final iconColor =  isSelected ? data.selectedColor.textColor : data.unSelectedColor;

    switch(data.iconType){
      case SchemeIconType.icon:
        return SchemeIcon.icon(
	        icon: isSelected ? data.selectedIconData : data.iconData,
	        size: data.iconSize,
	        color: iconColor,
        );
      case SchemeIconType.svg:
      	return SchemeIcon.svg(
			      asset: data.iconPath,
			      color: iconColor,
			      size: data.iconSize);
      case SchemeIconType.image:
      	return SchemeIcon.image(asset: data.iconPath,color: iconColor,size: data.iconSize);
      case SchemeIconType.flare:
      	return SchemeIcon.flare(asset: data.iconPath,color: iconColor,colorScheme: colorScheme,size: data.iconSize,);
      case SchemeIconType.lottie:
      	return SchemeIcon.lottie(asset: data.iconPath,size: data.iconSize,color: iconColor);
      case SchemeIconType.color:
        return SchemeIcon.color(asset: data.iconPath,size: data.iconSize,);
      case SchemeIconType.flip:
        return SchemeIcon.flip(asset: data.iconPath, size: data.iconSize,color: iconColor,animate: animate,
        );
	    default: return SizedBox.shrink();
    }
  }



}
