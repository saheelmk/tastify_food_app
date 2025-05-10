import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastify_food_app/core/service/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
