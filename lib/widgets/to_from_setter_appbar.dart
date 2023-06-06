import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:pointr/my_theme.dart';
import 'package:pointr/providers/from_provider.dart';
import 'package:pointr/providers/search_suggestion_provider.dart';
import 'package:pointr/providers/to_provider.dart';
import 'package:pointr/widgets/map_results.dart';

class ToFromSetterAppBar extends StatelessWidget {
  const ToFromSetterAppBar({super.key, required this.onSelected});
  final Function(LatLng latLng) onSelected;
  static final LayerLink _layerLink = LayerLink();
  // from
  static final TextEditingController fromController = TextEditingController();
  static final FocusNode fromFocusNode = FocusNode();
  // to
  static final TextEditingController toController = TextEditingController();
  static final FocusNode toFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    OverlayEntry? fromOverlay;
    OverlayEntry? toOverlay;
    OverlayEntry overlaySuggestions() => OverlayEntry(
          builder: (context) => CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            showWhenUnlinked: false,
            child: Column(
              children: [
                Consumer<SearchSuggestionProvider>(
                  builder: (context, searchSuggestionProvider, child) =>
                      searchSuggestionProvider.suggestions.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 200,
                              child: Material(
                                elevation: 1.0,
                                child: PlaceListview(
                                  items: searchSuggestionProvider.suggestions,
                                  onSelected: (place) async {
                                    // get lat lng
                                    LatLng selectedLatLng =
                                        await place.getLatLng();
                                    // remove overlays
                                    fromOverlay?.remove();
                                    fromOverlay = null;
                                    toOverlay?.remove();
                                    toOverlay = null;
                                    // get provider
                                    FromProvider fromProvider;
                                    ToProvider toProvider;
                                    if (context.mounted) {
                                      fromProvider = Provider.of<FromProvider>(
                                          context,
                                          listen: false);
                                      toProvider = Provider.of<ToProvider>(
                                          context,
                                          listen: false);
                                    } else {
                                      throw Exception('context not mounted');
                                    }
                                    // whichever was focused, pass latlng, unfocus
                                    if (fromFocusNode.hasFocus &&
                                        context.mounted) {
                                      // clear form
                                      fromController.clear();
                                      // unfocus
                                      fromFocusNode.unfocus();
                                      // pass latlng
                                      fromProvider.select(
                                        latLng: selectedLatLng,
                                        name: place.title,
                                        context: context,
                                      );
                                      // focus on to
                                      if (toProvider.selected == null) {
                                        toFocusNode.requestFocus();
                                      }
                                    } else if (toFocusNode.hasFocus) {
                                      // clear form
                                      toController.clear();
                                      // unfocus
                                      toFocusNode.unfocus();
                                      // pass latlng
                                      toProvider.select(
                                        latLng: selectedLatLng,
                                        name: place.title,
                                        context: context,
                                      );
                                      // focus on from
                                      if (fromProvider.selected == null) {
                                        fromFocusNode.requestFocus();
                                      }
                                    }
                                    onSelected(selectedLatLng);
                                  },
                                ),
                              ),
                            ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: const SizedBox.expand(
                      child: Opacity(
                        opacity: 0.6,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (toOverlay?.mounted ?? false) toOverlay!.remove();
                      toOverlay = null;
                      if (fromOverlay?.mounted ?? false) fromOverlay!.remove();
                      fromOverlay = null;
                      Provider.of<SearchSuggestionProvider>(context,
                              listen: false)
                          .clear();
                      if (fromFocusNode.hasFocus) {
                        fromController.clear();
                        fromFocusNode.unfocus();
                      }
                      if (toFocusNode.hasFocus) {
                        toController.clear();
                        toFocusNode.unfocus();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );

    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 7,
          left: 15,
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(1, 1),
            )
          ],
          color: MyTheme.colorPrimary,
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(
              'assets/images/geometric pattern.png',
            ),
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(
              MyTheme.colorPrimaryLight,
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // back button
            IconButton(
              onPressed: Navigator.of(context).pop,
              color: MyTheme.colorSecondaryLight,
              icon: const Icon(Icons.arrow_back),
            ),
            // text fields
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // from textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Consumer<FromProvider>(
                      builder: (context, fromProvider, child) => TextField(
                        controller: fromController,
                        autofocus: true,
                        onChanged: (term) async {
                          if (term.trim().isEmpty) return;
                          var searchProvider =
                              Provider.of<SearchSuggestionProvider>(
                            context,
                            listen: false,
                          );
                          await searchProvider.fetchSuggestions(
                            context,
                            term,
                          );
                        },
                        focusNode: fromFocusNode
                          ..addListener(() {
                            bool isOverlayMounted =
                                (fromOverlay?.mounted ?? false) ||
                                    (toOverlay?.mounted ?? false);
                            if (fromFocusNode.hasFocus) {
                              fromProvider.clear();
                              toOverlay?.remove();
                              if (!isOverlayMounted) {
                                fromOverlay = overlaySuggestions();
                                Overlay.of(context).insert(
                                  fromOverlay!,
                                );
                              }
                            } else if (isOverlayMounted) {
                              fromController.clear();
                              Provider.of<SearchSuggestionProvider>(
                                context,
                                listen: false,
                              ).clear();
                              fromOverlay?.remove();
                              fromOverlay = null;
                              toOverlay?.remove();
                              toOverlay = null;
                            }
                          }),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          fillColor: fromFocusNode.hasFocus
                              ? Colors.white
                              : fromProvider.selected == null
                                  ? MyTheme.colorSecondaryLight
                                  : MyTheme.colorPrimaryLight,
                          filled: true,
                          focusColor: Colors.red,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            borderSide: BorderSide(
                              color: MyTheme.colorSecondary,
                              width: 5,
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(99),
                            ),
                          ),
                          hintText: fromProvider.title,
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 20, right: 15),
                            child: Text(
                              'FROM',
                              textScaleFactor: 0.6,
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // to
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Consumer<ToProvider>(
                      builder: (context, toProvider, child) => TextField(
                        controller: toController,
                        onChanged: (term) {
                          if (term.trim().isEmpty) return;
                          var searchProvider =
                              Provider.of<SearchSuggestionProvider>(
                            context,
                            listen: false,
                          );
                          searchProvider.fetchSuggestions(context, term);
                        },
                        focusNode: toFocusNode
                          ..addListener(() {
                            bool isOverlayMounted =
                                (fromOverlay?.mounted ?? false) ||
                                    (toOverlay?.mounted ?? false);
                            if (toFocusNode.hasFocus) {
                              toProvider.clear();
                              fromOverlay?.remove();
                              if (!isOverlayMounted) {
                                toOverlay = overlaySuggestions();
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => Overlay.of(context).insert(
                                          toOverlay!,
                                        ));
                              }
                            } else if (isOverlayMounted) {
                              toController.clear();
                              Provider.of<SearchSuggestionProvider>(
                                context,
                                listen: false,
                              ).clear();
                              fromOverlay?.remove();
                              fromOverlay = null;
                              toOverlay?.remove();
                              toOverlay = null;
                            }
                          }),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          fillColor: toFocusNode.hasFocus
                              ? Colors.white
                              : toProvider.selected == null
                                  ? MyTheme.colorSecondaryLight
                                  : MyTheme.colorPrimaryLight,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            borderSide: BorderSide(
                              color: MyTheme.colorSecondary,
                              width: 5,
                            ),
                          ),
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(99),
                            ),
                          ),
                          hintText: toProvider.title,
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 20, right: 15),
                            child: Text(
                              'TO      ',
                              textAlign: TextAlign.center,
                              textScaleFactor: 0.6,
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
