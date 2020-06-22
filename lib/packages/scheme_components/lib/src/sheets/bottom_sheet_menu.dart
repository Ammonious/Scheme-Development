import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheme_components/src/dialogs/models/dialog_model.dart';
import 'package:scheme_components/src/text_views/auto_size_text.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_utilities/scheme_utilities.dart';
import 'models/sheet_menu_item.dart';
import 'views/sheet_menu_item.dart';

enum SheetType { draggable, normal }

class BottomSheetMenu extends StatelessWidget {
	final String title;
	final List<MenuItem> menuItems;
	final DialogType dialogType;
	final Function(int index) onSelection;

	BottomSheetMenu(
			{Key key,
				this.title,
				@required this.menuItems,
				@required this.onSelection, this.dialogType = DialogType.sheet, })
			: super(key: key);

	@override
	Widget build(BuildContext context) {
		final height = Get.height;
		return DraggableScrollableSheet(
				expand: true,
				initialChildSize:  menuItems.length <= 3 ? smallPhone(height) ? 0.85 : 0.55 : 0.85,
				minChildSize: 0.5,
				builder: (context, scrollController) => Column(
					children: <Widget>[
						Expanded(
							child: AnimatedContainer(
								duration: normalDuration,
								constraints: BoxConstraints(maxWidth: 400),
								decoration: BoxDecoration(
									color: Picaso.paint.canvas,
									borderRadius: topCardRadius,
								),
								child: Column(
									mainAxisSize: MainAxisSize.min,
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										AnimatedContainer(
											duration: normalDuration,
											padding: EdgeInsets.only(left: 16.0, top: topPadding),
											height: appbarWithPadding,
											child: Row(
												children: <Widget>[
													Expanded(
															child: AutoSizeText(
																title,
																style: Picaso.jot.headline6,
															)),
													IconButton(
														icon: Icon(
															Icons.close,
															color: Picaso.paint.canvas.textColor,
														),
														onPressed: () => Get.back(),
													)
												],
											),
										),
										Expanded(
											child: ListView.builder(
												padding: EdgeInsets.only(top: 24, bottom: 24),
												shrinkWrap: true,
												controller: scrollController,
												itemCount: menuItems.length,
												itemBuilder: (context, index) => MenuSheetItem(
													menuItem: menuItems[index],
													index: index,
													onSelection: () => onSelection != null ? onSelection(index) : null,
												),
											),
										),
									],
								),
							),
						),
					],
				));
	}


}
