Stream<int> promotions =
    Stream.periodic(const Duration(seconds: 1), (int count) => count)
        .asBroadcastStream();
