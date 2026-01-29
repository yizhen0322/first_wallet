import 'package:dio/dio.dart';

import '../../../shared/contracts/app_contracts.dart';

class DioSwapRepository implements SwapRepository {
  DioSwapRepository(this._dio);

  final Dio _dio;

  @override
  Future<SwapQuoteResponse> quote(SwapQuoteRequest req) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/swap/quote',
      queryParameters: req.toJson(),
    );
    final data = res.data;
    if (data == null) throw Exception('Empty response');
    return SwapQuoteResponse.fromJson(data);
  }

  @override
  Future<SwapBuildResponse> build(SwapBuildRequest req) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/swap/build',
      data: req.toJson(),
    );
    final data = res.data;
    if (data == null) throw Exception('Empty response');
    return SwapBuildResponse.fromJson(data);
  }
}

