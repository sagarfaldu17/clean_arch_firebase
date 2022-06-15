enum Priority { low, medium, high }

class PriorityUtil {
  static List<String> getPriorityList() {
    List<String> priorityList = [];
    for (var element in Priority.values) {
      priorityList.add(element.name);
    }
    return priorityList;
  }

  static int getPriorityCount(Priority? priority) {
    if (priority == Priority.low) {
      return 1;
    } else if (priority == Priority.medium) {
      return 2;
    } else if (priority == Priority.high) {
      return 3;
    } else {
      return 0;
    }
  }
}
