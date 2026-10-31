import 'package:flutter/foundation.dart';
import 'package:network/network.dart';

import 'connectivity_status.dart';

class ServiceConnectivityStatus implements ConnectivityStatus {
  const ServiceConnectivityStatus(this._service);

  final ConnectivityService _service;

  @override
  ValueListenable<bool> get online => _service.online;
}
