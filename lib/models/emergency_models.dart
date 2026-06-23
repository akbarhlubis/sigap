class LocalizedText {
  final String id;
  final String en;

  LocalizedText({required this.id, required this.en});

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      id: json['id'] ?? '',
      en: json['en'] ?? '',
    );
  }

  String value(String languageCode) {
    return languageCode.toLowerCase() == 'en' ? en : id;
  }
}

class DecisionOption {
  final LocalizedText text;
  final String? nextNodeId;

  DecisionOption({required this.text, this.nextNodeId});

  factory DecisionOption.fromJson(Map<String, dynamic> json) {
    return DecisionOption(
      text: LocalizedText.fromJson(json['text']),
      nextNodeId: json['nextNodeId'],
    );
  }
}

class EmergencyNode {
  final String id;
  final LocalizedText question;
  final LocalizedText explanation;
  final String illustration;
  final List<DecisionOption> options;

  EmergencyNode({
    required this.id,
    required this.question,
    required this.explanation,
    required this.illustration,
    required this.options,
  });

  factory EmergencyNode.fromJson(Map<String, dynamic> json) {
    var optionsList = json['options'] as List? ?? [];
    return EmergencyNode(
      id: json['id'] ?? '',
      question: LocalizedText.fromJson(json['question']),
      explanation: LocalizedText.fromJson(json['explanation']),
      illustration: json['illustration'] ?? '',
      options: optionsList.map((o) => DecisionOption.fromJson(o)).toList(),
    );
  }

  bool get isLeaf => options.isEmpty;
}

class EmergencyCategory {
  final String id;
  final LocalizedText title;
  final LocalizedText description;
  final String icon;
  final String severity; // critical, moderate, low
  final String startNodeId;
  final Map<String, EmergencyNode> nodes;

  EmergencyCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.severity,
    required this.startNodeId,
    required this.nodes,
  });

  factory EmergencyCategory.fromJson(Map<String, dynamic> json) {
    var nodesMap = json['nodes'] as Map<String, dynamic>? ?? {};
    Map<String, EmergencyNode> parsedNodes = {};
    nodesMap.forEach((key, value) {
      parsedNodes[key] = EmergencyNode.fromJson(value);
    });

    return EmergencyCategory(
      id: json['id'] ?? '',
      title: LocalizedText.fromJson(json['title']),
      description: LocalizedText.fromJson(json['description']),
      icon: json['icon'] ?? '',
      severity: json['severity'] ?? 'moderate',
      startNodeId: json['startNodeId'] ?? '',
      nodes: parsedNodes,
    );
  }
}
