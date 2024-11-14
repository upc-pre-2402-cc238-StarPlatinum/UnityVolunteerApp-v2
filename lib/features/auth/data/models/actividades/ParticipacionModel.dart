class ParticipacionModel {
  final int actividadId;
  final int voluntarioId;

  ParticipacionModel({
    required this.actividadId,
    required this.voluntarioId,
  });

  Map<String, dynamic> toJson() {
    return {
      'actividadId': actividadId,
      'voluntarioId': voluntarioId,
    };
  }
}
