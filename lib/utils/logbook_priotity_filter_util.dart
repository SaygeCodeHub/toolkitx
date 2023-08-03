class LogBookPriorityFilterUtil {
  priorityFilter(data) {
    switch (data) {
      case '1':
        return 0;
      case '2':
        return 1;
      case '3':
        return 2;
    }
  }
}
