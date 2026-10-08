import 'dart:ui_web' as ui;
import 'package:app_platform/common/consts/iframe_texts.dart';
import 'package:app_platform/dtos/iframe_message.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:universal_html/html.dart' as html;

class IframeEmbed extends StatefulWidget {
  final String _token;
  final String _datasetUri;
  final String _appUrl;

  const IframeEmbed(this._token, this._datasetUri, this._appUrl, {super.key});

  @override
  State<IframeEmbed> createState() => _IframeEmbedState();
}

class _IframeEmbedState extends State<IframeEmbed> {
  late html.IFrameElement _iframe;

  late final String _viewType;

  @override
  void initState() {
    super.initState();

    _viewType = 'iframeElement_${DateTime.now().microsecondsSinceEpoch}';

    _iframe = html.IFrameElement()
  ..src = widget._appUrl
  ..style.position = 'absolute'
  ..style.top = '0'
  ..style.left = '0'
  ..style.border = 'none'
  ..style.width = '100%'
  ..style.height = '100%'
  ..style.display = 'block'
  ..setAttribute('allow', 'allow-scripts allow-same-origin');

    ui.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) => _iframe,
    );
      
    Logger.root.info("[IframeEmbed] adding message listener for messages sent form IFrame");
    // Add message listener from iframe
    html.window.onMessage.listen((event) {
      final expectedOrigin = Uri.parse(widget._appUrl).origin;
      final data = event.data;

      if (event.origin != expectedOrigin) {
        Logger.root.warning("[IframeEmbed] ignoring message from unexpected origin: ${event.origin}");
        return;
      }

      if (data is Map && data['type'] == IFrameTexts.readyFromApp) {
        Logger.root.info("[IframeEmbed] received 'ready' message from IFrame");

        final message = XIFrameMessage()
          ..type = IFrameTexts.readyFromPlatform
          ..token = widget._token
          ..datasetUri = widget._datasetUri;

        Logger.root.info("[IframeEmbed] posting message to IFrame origin: $expectedOrigin");
        _iframe.contentWindow?.postMessage(
          message.toJson(),
          expectedOrigin,
        );
      }
    });

    // Add the iframe to the DOM
    // You must use an `HtmlElementView`
  }

  @override
  Widget build(BuildContext context) {
    // Register the view
    // You can only do this in Flutter web
    // The `viewType` must be unique
    // Register the iframe to Flutter DOM
    // ignore: undefined_prefixed_name
    // (Requires web build; won't work in mobile)

    // Register iframe in Flutter DOM
    // Use PlatformView for rendering in web
    // Must be in index.html with allow="allow-scripts allow-same-origin"
    final iframeWidget = HtmlElementView(viewType: _viewType);

    return iframeWidget;
  }
}
