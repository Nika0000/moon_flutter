import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CarouselStory extends StatefulWidget {
  static const path = '/carousel';

  const CarouselStory({super.key});

  @override
  State<CarouselStory> createState() => _CarouselStoryState();
}

class _CarouselStoryState extends State<CarouselStory> {
  MoonCarouselScrollController carouselController = MoonCarouselScrollController();

  int selectedDot = 0;

  @override
  Widget build(BuildContext context) {
    final itemExtentKnob = context.knobs.nullable.sliderInt(
      label: "itemExtent",
      description: "MoonCarousel item extent.",
      enabled: false,
      initial: 114,
      max: MediaQuery.of(context).size.width.round(),
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "The gap between MoonCarousel items.",
      enabled: false,
      initial: 8,
      max: 64,
    );

    final anchorKnob = context.knobs.nullable.slider(
      label: "anchor",
      description: "MoonCarousel anchor placement.",
      enabled: false,
      initial: 0.04,
    );

    final velocityFactorKnob = context.knobs.nullable.slider(
      label: "velocityFactor",
      description: "The velocity factor for MoonCarousel.",
      enabled: false,
      min: 0.1,
      initial: 0.5,
    );

    final autoPlayKnob = context.knobs.boolean(
      label: "autoPlay",
      description: "Whether the MoonCarousel is auto playing.",
    );

    final isCenteredKnob = context.knobs.boolean(
      label: "isCentered",
      description: "Whether the MoonCarousel items are centered.",
    );

    final isLoopedKnob = context.knobs.boolean(
      label: "loop",
      description: "Whether the MoonCarousel is looped or not (infinite scroll).",
    );

    final clampMaxExtentKnob = context.knobs.boolean(
      label: "clampMaxExtent",
      description: "Whether to clamp the maxExtent of the MoonCarousel.",
      initial: true,
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "Customisable MoonCarousel",
              paddingTop: 0,
            ),
            SizedBox(
              height: 114,
              child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: MoonCarousel(
                  velocityFactor: velocityFactorKnob ?? 0.5,
                  gap: gapKnob?.toDouble() ?? 8,
                  autoPlay: autoPlayKnob,
                  itemCount: 10,
                  itemExtent: itemExtentKnob?.toDouble() ?? 114,
                  isCentered: isCenteredKnob,
                  anchor: anchorKnob ?? 0.041,
                  loop: isLoopedKnob,
                  clampMaxExtent: clampMaxExtentKnob,
                  itemBuilder: (BuildContext context, int itemIndex, int realIndex) => Container(
                    decoration: ShapeDecoration(
                      color: context.moonColors!.goku,
                      shape: MoonSquircleBorder(
                        borderRadius: BorderRadius.circular(12).squircleBorderRadius(context),
                      ),
                    ),
                    child: Center(
                      child: Text("${itemIndex + 1}"),
                    ),
                  ),
                ),
              ),
            ),
            const TextDivider(text: "Pre-made MoonCarousel with extras"),
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        MoonCarousel(
                          gap: 48,
                          controller: carouselController,
                          autoPlay: autoPlayKnob,
                          itemCount: 5,
                          itemExtent: MediaQuery.of(context).size.width - 64,
                          loop: isLoopedKnob,
                          onIndexChanged: (int index) => setState(() => selectedDot = index),
                          itemBuilder: (BuildContext context, int itemIndex, int realIndex) => Container(
                            decoration: ShapeDecoration(
                              color: context.moonColors!.goku,
                              shape: MoonSquircleBorder(
                                borderRadius: BorderRadius.circular(12).squircleBorderRadius(context),
                              ),
                            ),
                            child: Center(
                              child: Text("${itemIndex + 1}"),
                            ),
                          ),
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MoonButton.icon(
                                  buttonSize: MoonButtonSize.sm,
                                  showBorder: true,
                                  icon: Icon(
                                    Directionality.of(context) == TextDirection.ltr
                                        ? MoonIcons.controls_chevron_left_small_24_light
                                        : MoonIcons.controls_chevron_right_small_24_light,
                                  ),
                                  decoration: ShapeDecorationWithPremultipliedAlpha(
                                    color: context.moonColors!.goku,
                                    shadows: context.moonShadows!.sm,
                                    shape: MoonSquircleBorder(
                                      borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
                                    ),
                                  ),
                                  onTap: selectedDot == 0 ? null : () => carouselController.previousItem(),
                                ),
                                MoonButton.icon(
                                  buttonSize: MoonButtonSize.sm,
                                  showBorder: true,
                                  icon: Icon(
                                    Directionality.of(context) == TextDirection.ltr
                                        ? MoonIcons.controls_chevron_right_small_24_light
                                        : MoonIcons.controls_chevron_left_small_24_light,
                                  ),
                                  decoration: ShapeDecorationWithPremultipliedAlpha(
                                    color: context.moonColors!.goku,
                                    shadows: context.moonShadows!.sm,
                                    shape: MoonSquircleBorder(
                                      borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
                                    ),
                                  ),
                                  onTap: selectedDot == 4 ? null : () => carouselController.nextItem(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                MoonDotIndicator(
                  selectedDot: selectedDot,
                  dotCount: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
