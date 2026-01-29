// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletSummary _$WalletSummaryFromJson(Map<String, dynamic> json) =>
    _WalletSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      backupLabel: json['backupLabel'] as String,
      backupRequired: json['backupRequired'] as bool,
    );

Map<String, dynamic> _$WalletSummaryToJson(_WalletSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'backupLabel': instance.backupLabel,
      'backupRequired': instance.backupRequired,
    };

_ApiErrorEnvelope _$ApiErrorEnvelopeFromJson(Map<String, dynamic> json) =>
    _ApiErrorEnvelope(
      error: ApiError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiErrorEnvelopeToJson(_ApiErrorEnvelope instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

_ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => _ApiError(
      code: json['code'] as String,
      message: json['message'] as String,
      details:
          json['details'] as Map<String, dynamic>? ?? const <String, dynamic>{},
    );

Map<String, dynamic> _$ApiErrorToJson(_ApiError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'details': instance.details,
    };

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) => _UserSummary(
      id: json['id'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserSummaryToJson(_UserSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
    };

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserSummary.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_MeResponse _$MeResponseFromJson(Map<String, dynamic> json) => _MeResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      baseCurrency: json['baseCurrency'] as String,
      kycStatus: $enumDecode(_$KycStatusEnumMap, json['kycStatus']),
      phoneVerified: json['phoneVerified'] as bool,
    );

Map<String, dynamic> _$MeResponseToJson(_MeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'baseCurrency': instance.baseCurrency,
      'kycStatus': _$KycStatusEnumMap[instance.kycStatus]!,
      'phoneVerified': instance.phoneVerified,
    };

const _$KycStatusEnumMap = {
  KycStatus.not_started: 'not_started',
  KycStatus.pending: 'pending',
  KycStatus.approved: 'approved',
  KycStatus.rejected: 'rejected',
};

_FeatureFlagsResponse _$FeatureFlagsResponseFromJson(
        Map<String, dynamic> json) =>
    _FeatureFlagsResponse(
      chains: (json['chains'] as List<dynamic>)
          .map((e) => ChainFlag.fromJson(e as Map<String, dynamic>))
          .toList(),
      features: FeatureFlags.fromJson(json['features'] as Map<String, dynamic>),
      policies: Policies.fromJson(json['policies'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeatureFlagsResponseToJson(
        _FeatureFlagsResponse instance) =>
    <String, dynamic>{
      'chains': instance.chains,
      'features': instance.features,
      'policies': instance.policies,
    };

_ChainFlag _$ChainFlagFromJson(Map<String, dynamic> json) => _ChainFlag(
      chainId: (json['chainId'] as num).toInt(),
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$ChainFlagToJson(_ChainFlag instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'enabled': instance.enabled,
    };

_FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) =>
    _FeatureFlags(
      cardsEnabled: json['cardsEnabled'] as bool,
      swapEnabled: json['swapEnabled'] as bool,
      exportKeysEnabled: json['exportKeysEnabled'] as bool,
      tronEnabled: json['tronEnabled'] as bool,
    );

Map<String, dynamic> _$FeatureFlagsToJson(_FeatureFlags instance) =>
    <String, dynamic>{
      'cardsEnabled': instance.cardsEnabled,
      'swapEnabled': instance.swapEnabled,
      'exportKeysEnabled': instance.exportKeysEnabled,
      'tronEnabled': instance.tronEnabled,
    };

_Policies _$PoliciesFromJson(Map<String, dynamic> json) => _Policies(
      maxSlippageBps: (json['maxSlippageBps'] as num).toInt(),
      requireKycForCardOrder: json['requireKycForCardOrder'] as bool,
    );

Map<String, dynamic> _$PoliciesToJson(_Policies instance) => <String, dynamic>{
      'maxSlippageBps': instance.maxSlippageBps,
      'requireKycForCardOrder': instance.requireKycForCardOrder,
    };

_KycStartResponse _$KycStartResponseFromJson(Map<String, dynamic> json) =>
    _KycStartResponse(
      provider: json['provider'] as String,
      sdkToken: json['sdkToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$KycStartResponseToJson(_KycStartResponse instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'sdkToken': instance.sdkToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

_KycStatusResponse _$KycStatusResponseFromJson(Map<String, dynamic> json) =>
    _KycStatusResponse(
      status: $enumDecode(_$KycStatusEnumMap, json['status']),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$KycStatusResponseToJson(_KycStatusResponse instance) =>
    <String, dynamic>{
      'status': _$KycStatusEnumMap[instance.status]!,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_OtpRequestResponse _$OtpRequestResponseFromJson(Map<String, dynamic> json) =>
    _OtpRequestResponse(
      status: json['status'] as String,
    );

Map<String, dynamic> _$OtpRequestResponseToJson(_OtpRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

_OtpVerifyResponse _$OtpVerifyResponseFromJson(Map<String, dynamic> json) =>
    _OtpVerifyResponse(
      status: json['status'] as String,
    );

Map<String, dynamic> _$OtpVerifyResponseToJson(_OtpVerifyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

_ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) =>
    _ShippingAddress(
      name: json['name'] as String,
      address1: json['address1'] as String,
      address2: json['address2'] as String?,
      city: json['city'] as String,
      postcode: json['postcode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$ShippingAddressToJson(_ShippingAddress instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'postcode': instance.postcode,
      'country': instance.country,
    };

_CardSummary _$CardSummaryFromJson(Map<String, dynamic> json) => _CardSummary(
      id: json['id'] as String,
      type: $enumDecode(_$CardTypeEnumMap, json['type']),
      status: $enumDecode(_$CardStatusEnumMap, json['status']),
      last4: json['last4'] as String,
    );

Map<String, dynamic> _$CardSummaryToJson(_CardSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CardTypeEnumMap[instance.type]!,
      'status': _$CardStatusEnumMap[instance.status]!,
      'last4': instance.last4,
    };

const _$CardTypeEnumMap = {
  CardType.virtual: 'virtual',
  CardType.physical: 'physical',
};

const _$CardStatusEnumMap = {
  CardStatus.processing: 'processing',
  CardStatus.active: 'active',
  CardStatus.frozen: 'frozen',
  CardStatus.closed: 'closed',
  CardStatus.failed: 'failed',
};

_CardsListResponse _$CardsListResponseFromJson(Map<String, dynamic> json) =>
    _CardsListResponse(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardsListResponseToJson(_CardsListResponse instance) =>
    <String, dynamic>{
      'cards': instance.cards,
    };

_CardTransaction _$CardTransactionFromJson(Map<String, dynamic> json) =>
    _CardTransaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      merchant: json['merchant'] as String,
      status: json['status'] as String,
      time: DateTime.parse(json['time'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$CardTransactionToJson(_CardTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'currency': instance.currency,
      'merchant': instance.merchant,
      'status': instance.status,
      'time': instance.time.toIso8601String(),
      'metadata': instance.metadata,
    };

_CardTransactionsResponse _$CardTransactionsResponseFromJson(
        Map<String, dynamic> json) =>
    _CardTransactionsResponse(
      cursor: json['cursor'] as String?,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => CardTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardTransactionsResponseToJson(
        _CardTransactionsResponse instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'transactions': instance.transactions,
    };

_SwapQuoteRequest _$SwapQuoteRequestFromJson(Map<String, dynamic> json) =>
    _SwapQuoteRequest(
      chainId: (json['chainId'] as num).toInt(),
      fromToken: json['fromToken'] as String,
      toToken: json['toToken'] as String,
      amountIn: json['amountIn'] as String,
      taker: json['taker'] as String,
      slippageBps: (json['slippageBps'] as num).toInt(),
      preferredDex: json['preferredDex'] as String,
    );

Map<String, dynamic> _$SwapQuoteRequestToJson(_SwapQuoteRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'fromToken': instance.fromToken,
      'toToken': instance.toToken,
      'amountIn': instance.amountIn,
      'taker': instance.taker,
      'slippageBps': instance.slippageBps,
      'preferredDex': instance.preferredDex,
    };

_SwapRoute _$SwapRouteFromJson(Map<String, dynamic> json) => _SwapRoute(
      aggregator: json['aggregator'] as String,
      dex: json['dex'] as String,
      estimatedGas: json['estimatedGas'] as String,
    );

Map<String, dynamic> _$SwapRouteToJson(_SwapRoute instance) =>
    <String, dynamic>{
      'aggregator': instance.aggregator,
      'dex': instance.dex,
      'estimatedGas': instance.estimatedGas,
    };

_SwapApproval _$SwapApprovalFromJson(Map<String, dynamic> json) =>
    _SwapApproval(
      isRequired: json['isRequired'] as bool,
      spender: json['spender'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$SwapApprovalToJson(_SwapApproval instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'spender': instance.spender,
      'amount': instance.amount,
    };

_SwapQuoteResponse _$SwapQuoteResponseFromJson(Map<String, dynamic> json) =>
    _SwapQuoteResponse(
      quoteId: json['quoteId'] as String,
      chainId: (json['chainId'] as num).toInt(),
      amountIn: json['amountIn'] as String,
      amountOut: json['amountOut'] as String,
      minOut: json['minOut'] as String,
      route: SwapRoute.fromJson(json['route'] as Map<String, dynamic>),
      approval: SwapApproval.fromJson(json['approval'] as Map<String, dynamic>),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      warnings: (json['warnings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$SwapQuoteResponseToJson(_SwapQuoteResponse instance) =>
    <String, dynamic>{
      'quoteId': instance.quoteId,
      'chainId': instance.chainId,
      'amountIn': instance.amountIn,
      'amountOut': instance.amountOut,
      'minOut': instance.minOut,
      'route': instance.route,
      'approval': instance.approval,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'warnings': instance.warnings,
    };

_EvmTxRequest _$EvmTxRequestFromJson(Map<String, dynamic> json) =>
    _EvmTxRequest(
      to: json['to'] as String,
      data: json['data'] as String,
      value: json['value'] as String,
      gasLimit: json['gasLimit'] as String,
      type: $enumDecode(_$TxTypeEnumMap, json['type']),
      gasPrice: json['gasPrice'] as String?,
      maxFeePerGas: json['maxFeePerGas'] as String?,
      maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String?,
    );

Map<String, dynamic> _$EvmTxRequestToJson(_EvmTxRequest instance) =>
    <String, dynamic>{
      'to': instance.to,
      'data': instance.data,
      'value': instance.value,
      'gasLimit': instance.gasLimit,
      'type': _$TxTypeEnumMap[instance.type]!,
      'gasPrice': instance.gasPrice,
      'maxFeePerGas': instance.maxFeePerGas,
      'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
    };

const _$TxTypeEnumMap = {
  TxType.legacy: 'legacy',
  TxType.eip1559: 'eip1559',
};

_SwapFee _$SwapFeeFromJson(Map<String, dynamic> json) => _SwapFee(
      estimatedNetworkFeeWei: json['estimatedNetworkFeeWei'] as String,
    );

Map<String, dynamic> _$SwapFeeToJson(_SwapFee instance) => <String, dynamic>{
      'estimatedNetworkFeeWei': instance.estimatedNetworkFeeWei,
    };

_SwapBuildRequest _$SwapBuildRequestFromJson(Map<String, dynamic> json) =>
    _SwapBuildRequest(
      quoteId: json['quoteId'] as String,
      taker: json['taker'] as String,
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$SwapBuildRequestToJson(_SwapBuildRequest instance) =>
    <String, dynamic>{
      'quoteId': instance.quoteId,
      'taker': instance.taker,
      'recipient': instance.recipient,
    };

_SwapBuildResponse _$SwapBuildResponseFromJson(Map<String, dynamic> json) =>
    _SwapBuildResponse(
      tx: EvmTxRequest.fromJson(json['tx'] as Map<String, dynamic>),
      fee: SwapFee.fromJson(json['fee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SwapBuildResponseToJson(_SwapBuildResponse instance) =>
    <String, dynamic>{
      'tx': instance.tx,
      'fee': instance.fee,
    };
