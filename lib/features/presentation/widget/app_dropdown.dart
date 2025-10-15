import 'package:academeet/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/theme_data.dart';
class AppDropdown<T> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemToString;
  final ValueChanged<T> onChanged;
  // final double width;
  final double height;
  final double? maxDropdownHeight;

  const AppDropdown({
    super.key,
    required this.items,
    required this.labelText,
    required this.hintText,
    required this.itemToString,
    required this.onChanged,
    this.selectedItem,
    this.maxDropdownHeight,
    // this.width = 200,
    this.height = 50,
  });

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }


  void _showDropdown() {
    FocusManager.instance.primaryFocus
        ?.unfocus();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Tap barrier
            GestureDetector(
              onTap: _removeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            // Dropdown
            Positioned(
              left: offset.dx,
              top: offset.dy + renderBox.size.height,
              width: renderBox.size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, widget.height),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: widget.maxDropdownHeight ?? 200,
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: widget.items.map((item) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(widget.itemToString(item),style: size16weight700.copyWith(color: colors(context).blackColor),),
                              onTap: () {
                                widget.onChanged(item);
                                _removeDropdown();
                              },
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Theme.of(context).dividerColor,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }


  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        behavior: HitTestBehavior.translucent,
        child: InputDecorator(
          isEmpty: widget.selectedItem == null,
          isFocused: _isOpen,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: colors(context).darkGreen!)),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color:  colors(context).darkGreen,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: colors(context).darkGreen!)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedItem != null
                    ? widget.itemToString(widget.selectedItem as T)
                    : '',
                style: TextStyle(
                  color: widget.selectedItem != null
                      ? colors(context).whiteColor
                      : Theme.of(context).hintColor,
                  fontWeight: widget.selectedItem != null
                      ? FontWeight.w700
                      : FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.keyboard_arrow_down,size: 24,color: colors(context).blackColor,),
            ],
          ),
        ),
      ),
    );
  }

}
