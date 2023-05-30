enum Status {
  all,
  pending,
  completed,
}

extension StatusExtension on Status {
  String get status {
    String status;
    switch (this) {
      case Status.pending:
        status = 'pending';
        break;
      case Status.completed:
        status = "completed";
        break;
      case Status.all:
        status = "all";
        break;
    }
    return status;
  }
}
