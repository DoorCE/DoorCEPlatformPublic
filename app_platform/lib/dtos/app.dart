import 'package:app_platform/common/types/app_status.dart';
import 'package:app_platform/dtos/identifiable_element.dart';

class XApp extends XIdentifiableElement {
  String description = "";
  String title = "";

  String activeResourceUri = "";
  Map<String, String> activeResourceTitle = <String, String>{};
  String templateUri = "";
  String? templateTitle;
  List<String> sourceResourceUris = List<String>.empty(growable: true);
  Map<String, Map<String, String>> sourceResourceTitles = <String, Map<String,String>>{};

  bool isVisible = false;
  bool isEnabled = false;

  AppStatus status = AppStatus.Created;

  XApp();

  @override
  void fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = json['description'] ?? "";
    title = json['title'] ?? "";
    activeResourceUri = json['activeResourceUri'] ?? "";
    activeResourceTitle =  Map<String, String>.from(json['activeResourceTitle'] ?? {});
    templateUri = json['templateUri'] ?? "";
    templateTitle = json['templateTitle'] ?? "";

    sourceResourceUris = List<String>.from(json['sourceResourceUris'] ?? []);

    sourceResourceTitles = <String, Map<String,String>>{};
    if (json['sourceResourceTitles'] != null && json['sourceResourceTitles'].isNotEmpty) {
      for (final id in sourceResourceUris) {
        if (json['sourceResourceTitles'][id] != null) {
          sourceResourceTitles[id] = Map<String, String>.from(json['sourceResourceTitles'][id]);
        }
      }
    }

    isVisible = json['isVisible'] ?? false;
    isEnabled = json['isEnabled'] ?? false;

    status = AppStatus.values[json['status'] ?? 0];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'description': description,
      'title': title,
      'activeResourceUri': activeResourceUri,
      'activeResourceTitle': activeResourceTitle,
      'templateUri': templateUri,
      'templateTitle': templateTitle,
      'sourceResourceUris': sourceResourceUris,
      'sourceResourceTitles': sourceResourceTitles,
      'isVisible': isVisible,
      'isEnabled': isEnabled,
      'status': status.index
    };
  }

  List<String> getSearchableFields() {
    return [identifier, title];
  }
}