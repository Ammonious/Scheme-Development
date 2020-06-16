import 'package:flutter/material.dart';
import 'package:scheme_components/src/sheets/models/sheet_menu_item.dart';
import 'package:scheme_icons/scheme_icons.dart';
import 'package:scheme_theme/scheme_theme.dart';

class MenuSheetItem extends StatelessWidget {
	final MenuItem menuItem;
	final int index;
	final Function onSelection;
	MenuSheetItem({Key key,@required this.menuItem,@required this.index, this.onSelection}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		// TODO: implement build
		return Container(
			margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
			decoration: BoxDecoration(
					color: Picaso.paint.card,
					boxShadow: liftedShadow,
					borderRadius: BorderRadius.all(Radius.circular(12))),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					borderRadius: BorderRadius.all(Radius.circular(12)),
					onTap: () {
						onSelection();
					},
					child: Container(
							padding: EdgeInsets.symmetric(
									vertical: menuItem.subtitle == '' ? 22 : 16, horizontal: 16),
							child: Row(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: <Widget>[
									menuItem.icon == null
											? Text(
										'${index + 1}',
										style: Picaso.jot.headline6,
									)
											: menuItem.icon,
									SizedBox(
										width: 16,
									),
									Expanded(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Text(
													menuItem.title,
													style: Picaso.jot.subtitle1,
												),
												Visibility(
														visible: menuItem.subtitle != null && menuItem.subtitle != '',
														child: Padding(
															padding: const EdgeInsets.only(top: 4.0),
															child: Text(menuItem.subtitle ?? '',
																	style: Picaso.jot.caption),
														)),
											],
										),
									),
									menuItem.trailing ?? Icon(
										BoxIcon.bxChevronrightcircle,
										size: 24,
										color: Picaso.paint.iconColor.withOpacity(0.75),
									),
								],
							)),
				),
			),
		);
	}
}
