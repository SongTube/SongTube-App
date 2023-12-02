import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/circular_check_box.dart';
import 'package:songtube/ui/text_styles.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.onTap,
    this.enabled = true,
    super.key});
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Function() onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      onTap: () => onTap(),
      leading: SizedBox(
        height: double.infinity,
        child: AppAnimatedIcon(leadingIcon, color: enabled ? null : Colors.grey.withOpacity(0.6)),
      ),
      title: Text(title, style: smallTextStyle(context).copyWith(color: enabled ? null : Colors.grey.withOpacity(0.6))),
      subtitle: Text(subtitle, style: smallTextStyle(context, opacity: 0.6).copyWith(color: enabled ? null : Colors.grey.withOpacity(0.6), fontSize: 12)),
    );
  }
}

class SettingTileCheckbox extends StatelessWidget {
  const SettingTileCheckbox({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.value,
    required this.onChange,
    this.enabled = true,
    this.show = true,
    super.key});
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final bool value;
  final Function(bool) onChange;
  final bool enabled;
  final bool show;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: kAnimationDuration,
      curve: kAnimationCurve,
      child: SizedBox(
        height: show ? null : 0,
        child: AnimatedOpacity(
          opacity: show ? 1 : 0,
          duration: kAnimationShortDuration,
          curve: kAnimationCurve,
          child: ListTile(
            enabled: enabled,
            onTap: () => onChange(!value),
            leading: SizedBox(
              height: double.infinity,
              child: AppAnimatedIcon(leadingIcon, color: enabled ? null : Colors.grey.withOpacity(0.6)),
            ),
            title: Text(title, style: smallTextStyle(context).copyWith(color: enabled ? null : Colors.grey.withOpacity(0.6))),
            subtitle: Text(subtitle, style: smallTextStyle(context, opacity: 0.6).copyWith(color: enabled ? null : Colors.grey.withOpacity(0.6), fontSize: 12)),
            trailing: CircularCheckbox(
              value: value,
              onChange: enabled ? onChange : null
            ),
          ),
        ),
      ),
    );
  }
}

class SettingTileSlider extends StatefulWidget {
  const SettingTileSlider({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.value,
    required this.min,
    required this.max,
    required this.onChange,
    this.valueTrailingString = '',
    super.key});
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final double value;
  final double min;
  final double max;
  final Function(double) onChange;
  final String valueTrailingString;
  @override
  State<SettingTileSlider> createState() => _SettingTileSliderState();
}

class _SettingTileSliderState extends State<SettingTileSlider> {

  // Drag placeholders
  double? dragValue;
  bool dragging = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: SizedBox(
            height: double.infinity,
            child: AppAnimatedIcon(widget.leadingIcon),
          ),
          title: Text(widget.title, style: smallTextStyle(context)),
          subtitle: Text(widget.subtitle, style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _slider(),
        )
      ],
    );
  }

  Widget _slider() {
    MediaProvider mediaProvider = Provider.of(context);
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
        valueIndicatorTextStyle: TextStyle(
          color: mediaProvider.currentColors.vibrant,
        ),
        trackHeight: 2,
      ),
      child: Row(
        children: [
          Text((dragValue ?? widget.value).round().toString()+widget.valueTrailingString, style: tinyTextStyle(context, opacity: 0.6).copyWith(letterSpacing: 1)),
          const SizedBox(width: 4),
          Expanded(
            child: Slider(
              activeColor: mediaProvider.currentColors.vibrant,
              inactiveColor: Theme.of(context).cardColor,
              min: widget.min,
              max: widget.max,
              value: dragValue ?? widget.value,
              onChanged: (value) {
                if (!dragging) {
                  dragging = true;
                }
                setState(() {
                  dragValue = value;
                });
              },
              onChangeEnd: widget.onChange
            ),
          ),
          const SizedBox(width: 4),
          Text(widget.max.round().toString()+widget.valueTrailingString, style: tinyTextStyle(context, opacity: 0.6).copyWith(letterSpacing: 1)),
        ],
      )
    );
  }

}

class SettingTileDropdown extends StatelessWidget {
  const SettingTileDropdown({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.currentValue,
    required this.onChange,
    required this.items,
    super.key});
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final String currentValue;
  final Function(String?) onChange;
  final List<DropdownMenuItem<String>> items;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: SizedBox(
              height: double.infinity,
              child: AppAnimatedIcon(leadingIcon),
            ),
            title: Text(title, style: smallTextStyle(context)),
            subtitle: Text(subtitle, style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _dropdown(context),
        )
      ],
    );
  }

  Widget _dropdown(context) {
    MediaProvider mediaProvider = Provider.of(context);
    return SizedBox(
      height: 30,
      child: DropdownButton<String>(
        value: currentValue,
        iconSize: 18,
        elevation: 0,
        borderRadius: BorderRadius.circular(20),
        iconEnabledColor: mediaProvider.currentColors.vibrant,
        style: smallTextStyle(context),
        underline: Container(),
        items: items,
        onChanged: onChange
      ),
    );
  }

}