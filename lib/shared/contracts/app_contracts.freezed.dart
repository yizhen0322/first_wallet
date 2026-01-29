// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_contracts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletSummary {
  String get id;
  String get name;
  String get backupLabel;
  bool get backupRequired;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletSummaryCopyWith<WalletSummary> get copyWith =>
      _$WalletSummaryCopyWithImpl<WalletSummary>(
          this as WalletSummary, _$identity);

  /// Serializes this WalletSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.backupLabel, backupLabel) ||
                other.backupLabel == backupLabel) &&
            (identical(other.backupRequired, backupRequired) ||
                other.backupRequired == backupRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, backupLabel, backupRequired);

  @override
  String toString() {
    return 'WalletSummary(id: $id, name: $name, backupLabel: $backupLabel, backupRequired: $backupRequired)';
  }
}

/// @nodoc
abstract mixin class $WalletSummaryCopyWith<$Res> {
  factory $WalletSummaryCopyWith(
          WalletSummary value, $Res Function(WalletSummary) _then) =
      _$WalletSummaryCopyWithImpl;
  @useResult
  $Res call({String id, String name, String backupLabel, bool backupRequired});
}

/// @nodoc
class _$WalletSummaryCopyWithImpl<$Res>
    implements $WalletSummaryCopyWith<$Res> {
  _$WalletSummaryCopyWithImpl(this._self, this._then);

  final WalletSummary _self;
  final $Res Function(WalletSummary) _then;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? backupLabel = null,
    Object? backupRequired = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      backupLabel: null == backupLabel
          ? _self.backupLabel
          : backupLabel // ignore: cast_nullable_to_non_nullable
              as String,
      backupRequired: null == backupRequired
          ? _self.backupRequired
          : backupRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WalletSummary implements WalletSummary {
  const _WalletSummary(
      {required this.id,
      required this.name,
      required this.backupLabel,
      required this.backupRequired});
  factory _WalletSummary.fromJson(Map<String, dynamic> json) =>
      _$WalletSummaryFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String backupLabel;
  @override
  final bool backupRequired;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WalletSummaryCopyWith<_WalletSummary> get copyWith =>
      __$WalletSummaryCopyWithImpl<_WalletSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WalletSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WalletSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.backupLabel, backupLabel) ||
                other.backupLabel == backupLabel) &&
            (identical(other.backupRequired, backupRequired) ||
                other.backupRequired == backupRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, backupLabel, backupRequired);

  @override
  String toString() {
    return 'WalletSummary(id: $id, name: $name, backupLabel: $backupLabel, backupRequired: $backupRequired)';
  }
}

/// @nodoc
abstract mixin class _$WalletSummaryCopyWith<$Res>
    implements $WalletSummaryCopyWith<$Res> {
  factory _$WalletSummaryCopyWith(
          _WalletSummary value, $Res Function(_WalletSummary) _then) =
      __$WalletSummaryCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String backupLabel, bool backupRequired});
}

/// @nodoc
class __$WalletSummaryCopyWithImpl<$Res>
    implements _$WalletSummaryCopyWith<$Res> {
  __$WalletSummaryCopyWithImpl(this._self, this._then);

  final _WalletSummary _self;
  final $Res Function(_WalletSummary) _then;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? backupLabel = null,
    Object? backupRequired = null,
  }) {
    return _then(_WalletSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      backupLabel: null == backupLabel
          ? _self.backupLabel
          : backupLabel // ignore: cast_nullable_to_non_nullable
              as String,
      backupRequired: null == backupRequired
          ? _self.backupRequired
          : backupRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ApiErrorEnvelope {
  ApiError get error;

  /// Create a copy of ApiErrorEnvelope
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiErrorEnvelopeCopyWith<ApiErrorEnvelope> get copyWith =>
      _$ApiErrorEnvelopeCopyWithImpl<ApiErrorEnvelope>(
          this as ApiErrorEnvelope, _$identity);

  /// Serializes this ApiErrorEnvelope to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiErrorEnvelope &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'ApiErrorEnvelope(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ApiErrorEnvelopeCopyWith<$Res> {
  factory $ApiErrorEnvelopeCopyWith(
          ApiErrorEnvelope value, $Res Function(ApiErrorEnvelope) _then) =
      _$ApiErrorEnvelopeCopyWithImpl;
  @useResult
  $Res call({ApiError error});

  $ApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class _$ApiErrorEnvelopeCopyWithImpl<$Res>
    implements $ApiErrorEnvelopeCopyWith<$Res> {
  _$ApiErrorEnvelopeCopyWithImpl(this._self, this._then);

  final ApiErrorEnvelope _self;
  final $Res Function(ApiErrorEnvelope) _then;

  /// Create a copy of ApiErrorEnvelope
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_self.copyWith(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiError,
    ));
  }

  /// Create a copy of ApiErrorEnvelope
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiErrorCopyWith<$Res> get error {
    return $ApiErrorCopyWith<$Res>(_self.error, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ApiErrorEnvelope implements ApiErrorEnvelope {
  const _ApiErrorEnvelope({required this.error});
  factory _ApiErrorEnvelope.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorEnvelopeFromJson(json);

  @override
  final ApiError error;

  /// Create a copy of ApiErrorEnvelope
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApiErrorEnvelopeCopyWith<_ApiErrorEnvelope> get copyWith =>
      __$ApiErrorEnvelopeCopyWithImpl<_ApiErrorEnvelope>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ApiErrorEnvelopeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiErrorEnvelope &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'ApiErrorEnvelope(error: $error)';
  }
}

/// @nodoc
abstract mixin class _$ApiErrorEnvelopeCopyWith<$Res>
    implements $ApiErrorEnvelopeCopyWith<$Res> {
  factory _$ApiErrorEnvelopeCopyWith(
          _ApiErrorEnvelope value, $Res Function(_ApiErrorEnvelope) _then) =
      __$ApiErrorEnvelopeCopyWithImpl;
  @override
  @useResult
  $Res call({ApiError error});

  @override
  $ApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$ApiErrorEnvelopeCopyWithImpl<$Res>
    implements _$ApiErrorEnvelopeCopyWith<$Res> {
  __$ApiErrorEnvelopeCopyWithImpl(this._self, this._then);

  final _ApiErrorEnvelope _self;
  final $Res Function(_ApiErrorEnvelope) _then;

  /// Create a copy of ApiErrorEnvelope
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(_ApiErrorEnvelope(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiError,
    ));
  }

  /// Create a copy of ApiErrorEnvelope
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiErrorCopyWith<$Res> get error {
    return $ApiErrorCopyWith<$Res>(_self.error, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// @nodoc
mixin _$ApiError {
  String get code;
  String get message;
  Map<String, dynamic> get details;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiErrorCopyWith<ApiError> get copyWith =>
      _$ApiErrorCopyWithImpl<ApiError>(this as ApiError, _$identity);

  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.details, details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(details));

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message, details: $details)';
  }
}

/// @nodoc
abstract mixin class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) _then) =
      _$ApiErrorCopyWithImpl;
  @useResult
  $Res call({String code, String message, Map<String, dynamic> details});
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res> implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._self, this._then);

  final ApiError _self;
  final $Res Function(ApiError) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? details = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ApiError implements ApiError {
  const _ApiError(
      {required this.code,
      required this.message,
      final Map<String, dynamic> details = const <String, dynamic>{}})
      : _details = details;
  factory _ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  @override
  final String code;
  @override
  final String message;
  final Map<String, dynamic> _details;
  @override
  @JsonKey()
  Map<String, dynamic> get details {
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_details);
  }

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApiErrorCopyWith<_ApiError> get copyWith =>
      __$ApiErrorCopyWithImpl<_ApiError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ApiErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message,
      const DeepCollectionEquality().hash(_details));

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message, details: $details)';
  }
}

/// @nodoc
abstract mixin class _$ApiErrorCopyWith<$Res>
    implements $ApiErrorCopyWith<$Res> {
  factory _$ApiErrorCopyWith(_ApiError value, $Res Function(_ApiError) _then) =
      __$ApiErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String code, String message, Map<String, dynamic> details});
}

/// @nodoc
class __$ApiErrorCopyWithImpl<$Res> implements _$ApiErrorCopyWith<$Res> {
  __$ApiErrorCopyWithImpl(this._self, this._then);

  final _ApiError _self;
  final $Res Function(_ApiError) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? details = null,
  }) {
    return _then(_ApiError(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _self._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$AuthTokens {
  String get accessToken;
  String get refreshToken;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthTokensCopyWith<AuthTokens> get copyWith =>
      _$AuthTokensCopyWithImpl<AuthTokens>(this as AuthTokens, _$identity);

  /// Serializes this AuthTokens to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthTokens &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'AuthTokens(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $AuthTokensCopyWith<$Res> {
  factory $AuthTokensCopyWith(
          AuthTokens value, $Res Function(AuthTokens) _then) =
      _$AuthTokensCopyWithImpl;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$AuthTokensCopyWithImpl<$Res> implements $AuthTokensCopyWith<$Res> {
  _$AuthTokensCopyWithImpl(this._self, this._then);

  final AuthTokens _self;
  final $Res Function(AuthTokens) _then;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AuthTokens implements AuthTokens {
  const _AuthTokens({required this.accessToken, required this.refreshToken});
  factory _AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthTokensCopyWith<_AuthTokens> get copyWith =>
      __$AuthTokensCopyWithImpl<_AuthTokens>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthTokensToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthTokens &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'AuthTokens(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$AuthTokensCopyWith<$Res>
    implements $AuthTokensCopyWith<$Res> {
  factory _$AuthTokensCopyWith(
          _AuthTokens value, $Res Function(_AuthTokens) _then) =
      __$AuthTokensCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$AuthTokensCopyWithImpl<$Res> implements _$AuthTokensCopyWith<$Res> {
  __$AuthTokensCopyWithImpl(this._self, this._then);

  final _AuthTokens _self;
  final $Res Function(_AuthTokens) _then;

  /// Create a copy of AuthTokens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_AuthTokens(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UserSummary {
  String get id;
  String get email;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<UserSummary> get copyWith =>
      _$UserSummaryCopyWithImpl<UserSummary>(this as UserSummary, _$identity);

  /// Serializes this UserSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email);

  @override
  String toString() {
    return 'UserSummary(id: $id, email: $email)';
  }
}

/// @nodoc
abstract mixin class $UserSummaryCopyWith<$Res> {
  factory $UserSummaryCopyWith(
          UserSummary value, $Res Function(UserSummary) _then) =
      _$UserSummaryCopyWithImpl;
  @useResult
  $Res call({String id, String email});
}

/// @nodoc
class _$UserSummaryCopyWithImpl<$Res> implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._self, this._then);

  final UserSummary _self;
  final $Res Function(UserSummary) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserSummary implements UserSummary {
  const _UserSummary({required this.id, required this.email});
  factory _UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);

  @override
  final String id;
  @override
  final String email;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserSummaryCopyWith<_UserSummary> get copyWith =>
      __$UserSummaryCopyWithImpl<_UserSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email);

  @override
  String toString() {
    return 'UserSummary(id: $id, email: $email)';
  }
}

/// @nodoc
abstract mixin class _$UserSummaryCopyWith<$Res>
    implements $UserSummaryCopyWith<$Res> {
  factory _$UserSummaryCopyWith(
          _UserSummary value, $Res Function(_UserSummary) _then) =
      __$UserSummaryCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String email});
}

/// @nodoc
class __$UserSummaryCopyWithImpl<$Res> implements _$UserSummaryCopyWith<$Res> {
  __$UserSummaryCopyWithImpl(this._self, this._then);

  final _UserSummary _self;
  final $Res Function(_UserSummary) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? email = null,
  }) {
    return _then(_UserSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AuthResponse {
  String get accessToken;
  String get refreshToken;
  UserSummary get user;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      _$AuthResponseCopyWithImpl<AuthResponse>(
          this as AuthResponse, _$identity);

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken, user);

  @override
  String toString() {
    return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
  }
}

/// @nodoc
abstract mixin class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
          AuthResponse value, $Res Function(AuthResponse) _then) =
      _$AuthResponseCopyWithImpl;
  @useResult
  $Res call({String accessToken, String refreshToken, UserSummary user});

  $UserSummaryCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res> implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._self, this._then);

  final AuthResponse _self;
  final $Res Function(AuthResponse) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? user = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSummary,
    ));
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get user {
    return $UserSummaryCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _AuthResponse implements AuthResponse {
  const _AuthResponse(
      {required this.accessToken,
      required this.refreshToken,
      required this.user});
  factory _AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final UserSummary user;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthResponseCopyWith<_AuthResponse> get copyWith =>
      __$AuthResponseCopyWithImpl<_AuthResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken, user);

  @override
  String toString() {
    return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
  }
}

/// @nodoc
abstract mixin class _$AuthResponseCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$AuthResponseCopyWith(
          _AuthResponse value, $Res Function(_AuthResponse) _then) =
      __$AuthResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken, UserSummary user});

  @override
  $UserSummaryCopyWith<$Res> get user;
}

/// @nodoc
class __$AuthResponseCopyWithImpl<$Res>
    implements _$AuthResponseCopyWith<$Res> {
  __$AuthResponseCopyWithImpl(this._self, this._then);

  final _AuthResponse _self;
  final $Res Function(_AuthResponse) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? user = null,
  }) {
    return _then(_AuthResponse(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSummary,
    ));
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get user {
    return $UserSummaryCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc
mixin _$MeResponse {
  String get id;
  String get email;
  String get baseCurrency;
  KycStatus get kycStatus;
  bool get phoneVerified;

  /// Create a copy of MeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MeResponseCopyWith<MeResponse> get copyWith =>
      _$MeResponseCopyWithImpl<MeResponse>(this as MeResponse, _$identity);

  /// Serializes this MeResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MeResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.baseCurrency, baseCurrency) ||
                other.baseCurrency == baseCurrency) &&
            (identical(other.kycStatus, kycStatus) ||
                other.kycStatus == kycStatus) &&
            (identical(other.phoneVerified, phoneVerified) ||
                other.phoneVerified == phoneVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, baseCurrency, kycStatus, phoneVerified);

  @override
  String toString() {
    return 'MeResponse(id: $id, email: $email, baseCurrency: $baseCurrency, kycStatus: $kycStatus, phoneVerified: $phoneVerified)';
  }
}

/// @nodoc
abstract mixin class $MeResponseCopyWith<$Res> {
  factory $MeResponseCopyWith(
          MeResponse value, $Res Function(MeResponse) _then) =
      _$MeResponseCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String email,
      String baseCurrency,
      KycStatus kycStatus,
      bool phoneVerified});
}

/// @nodoc
class _$MeResponseCopyWithImpl<$Res> implements $MeResponseCopyWith<$Res> {
  _$MeResponseCopyWithImpl(this._self, this._then);

  final MeResponse _self;
  final $Res Function(MeResponse) _then;

  /// Create a copy of MeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? baseCurrency = null,
    Object? kycStatus = null,
    Object? phoneVerified = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrency: null == baseCurrency
          ? _self.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      kycStatus: null == kycStatus
          ? _self.kycStatus
          : kycStatus // ignore: cast_nullable_to_non_nullable
              as KycStatus,
      phoneVerified: null == phoneVerified
          ? _self.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MeResponse implements MeResponse {
  const _MeResponse(
      {required this.id,
      required this.email,
      required this.baseCurrency,
      required this.kycStatus,
      required this.phoneVerified});
  factory _MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String baseCurrency;
  @override
  final KycStatus kycStatus;
  @override
  final bool phoneVerified;

  /// Create a copy of MeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MeResponseCopyWith<_MeResponse> get copyWith =>
      __$MeResponseCopyWithImpl<_MeResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MeResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MeResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.baseCurrency, baseCurrency) ||
                other.baseCurrency == baseCurrency) &&
            (identical(other.kycStatus, kycStatus) ||
                other.kycStatus == kycStatus) &&
            (identical(other.phoneVerified, phoneVerified) ||
                other.phoneVerified == phoneVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, baseCurrency, kycStatus, phoneVerified);

  @override
  String toString() {
    return 'MeResponse(id: $id, email: $email, baseCurrency: $baseCurrency, kycStatus: $kycStatus, phoneVerified: $phoneVerified)';
  }
}

/// @nodoc
abstract mixin class _$MeResponseCopyWith<$Res>
    implements $MeResponseCopyWith<$Res> {
  factory _$MeResponseCopyWith(
          _MeResponse value, $Res Function(_MeResponse) _then) =
      __$MeResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String baseCurrency,
      KycStatus kycStatus,
      bool phoneVerified});
}

/// @nodoc
class __$MeResponseCopyWithImpl<$Res> implements _$MeResponseCopyWith<$Res> {
  __$MeResponseCopyWithImpl(this._self, this._then);

  final _MeResponse _self;
  final $Res Function(_MeResponse) _then;

  /// Create a copy of MeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? baseCurrency = null,
    Object? kycStatus = null,
    Object? phoneVerified = null,
  }) {
    return _then(_MeResponse(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrency: null == baseCurrency
          ? _self.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      kycStatus: null == kycStatus
          ? _self.kycStatus
          : kycStatus // ignore: cast_nullable_to_non_nullable
              as KycStatus,
      phoneVerified: null == phoneVerified
          ? _self.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$FeatureFlagsResponse {
  List<ChainFlag> get chains;
  FeatureFlags get features;
  Policies get policies;

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeatureFlagsResponseCopyWith<FeatureFlagsResponse> get copyWith =>
      _$FeatureFlagsResponseCopyWithImpl<FeatureFlagsResponse>(
          this as FeatureFlagsResponse, _$identity);

  /// Serializes this FeatureFlagsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeatureFlagsResponse &&
            const DeepCollectionEquality().equals(other.chains, chains) &&
            (identical(other.features, features) ||
                other.features == features) &&
            (identical(other.policies, policies) ||
                other.policies == policies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(chains), features, policies);

  @override
  String toString() {
    return 'FeatureFlagsResponse(chains: $chains, features: $features, policies: $policies)';
  }
}

/// @nodoc
abstract mixin class $FeatureFlagsResponseCopyWith<$Res> {
  factory $FeatureFlagsResponseCopyWith(FeatureFlagsResponse value,
          $Res Function(FeatureFlagsResponse) _then) =
      _$FeatureFlagsResponseCopyWithImpl;
  @useResult
  $Res call({List<ChainFlag> chains, FeatureFlags features, Policies policies});

  $FeatureFlagsCopyWith<$Res> get features;
  $PoliciesCopyWith<$Res> get policies;
}

/// @nodoc
class _$FeatureFlagsResponseCopyWithImpl<$Res>
    implements $FeatureFlagsResponseCopyWith<$Res> {
  _$FeatureFlagsResponseCopyWithImpl(this._self, this._then);

  final FeatureFlagsResponse _self;
  final $Res Function(FeatureFlagsResponse) _then;

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? features = null,
    Object? policies = null,
  }) {
    return _then(_self.copyWith(
      chains: null == chains
          ? _self.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<ChainFlag>,
      features: null == features
          ? _self.features
          : features // ignore: cast_nullable_to_non_nullable
              as FeatureFlags,
      policies: null == policies
          ? _self.policies
          : policies // ignore: cast_nullable_to_non_nullable
              as Policies,
    ));
  }

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeatureFlagsCopyWith<$Res> get features {
    return $FeatureFlagsCopyWith<$Res>(_self.features, (value) {
      return _then(_self.copyWith(features: value));
    });
  }

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoliciesCopyWith<$Res> get policies {
    return $PoliciesCopyWith<$Res>(_self.policies, (value) {
      return _then(_self.copyWith(policies: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _FeatureFlagsResponse implements FeatureFlagsResponse {
  const _FeatureFlagsResponse(
      {required final List<ChainFlag> chains,
      required this.features,
      required this.policies})
      : _chains = chains;
  factory _FeatureFlagsResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsResponseFromJson(json);

  final List<ChainFlag> _chains;
  @override
  List<ChainFlag> get chains {
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chains);
  }

  @override
  final FeatureFlags features;
  @override
  final Policies policies;

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FeatureFlagsResponseCopyWith<_FeatureFlagsResponse> get copyWith =>
      __$FeatureFlagsResponseCopyWithImpl<_FeatureFlagsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FeatureFlagsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FeatureFlagsResponse &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            (identical(other.features, features) ||
                other.features == features) &&
            (identical(other.policies, policies) ||
                other.policies == policies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_chains), features, policies);

  @override
  String toString() {
    return 'FeatureFlagsResponse(chains: $chains, features: $features, policies: $policies)';
  }
}

/// @nodoc
abstract mixin class _$FeatureFlagsResponseCopyWith<$Res>
    implements $FeatureFlagsResponseCopyWith<$Res> {
  factory _$FeatureFlagsResponseCopyWith(_FeatureFlagsResponse value,
          $Res Function(_FeatureFlagsResponse) _then) =
      __$FeatureFlagsResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<ChainFlag> chains, FeatureFlags features, Policies policies});

  @override
  $FeatureFlagsCopyWith<$Res> get features;
  @override
  $PoliciesCopyWith<$Res> get policies;
}

/// @nodoc
class __$FeatureFlagsResponseCopyWithImpl<$Res>
    implements _$FeatureFlagsResponseCopyWith<$Res> {
  __$FeatureFlagsResponseCopyWithImpl(this._self, this._then);

  final _FeatureFlagsResponse _self;
  final $Res Function(_FeatureFlagsResponse) _then;

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chains = null,
    Object? features = null,
    Object? policies = null,
  }) {
    return _then(_FeatureFlagsResponse(
      chains: null == chains
          ? _self._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<ChainFlag>,
      features: null == features
          ? _self.features
          : features // ignore: cast_nullable_to_non_nullable
              as FeatureFlags,
      policies: null == policies
          ? _self.policies
          : policies // ignore: cast_nullable_to_non_nullable
              as Policies,
    ));
  }

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeatureFlagsCopyWith<$Res> get features {
    return $FeatureFlagsCopyWith<$Res>(_self.features, (value) {
      return _then(_self.copyWith(features: value));
    });
  }

  /// Create a copy of FeatureFlagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoliciesCopyWith<$Res> get policies {
    return $PoliciesCopyWith<$Res>(_self.policies, (value) {
      return _then(_self.copyWith(policies: value));
    });
  }
}

/// @nodoc
mixin _$ChainFlag {
  int get chainId;
  bool get enabled;

  /// Create a copy of ChainFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChainFlagCopyWith<ChainFlag> get copyWith =>
      _$ChainFlagCopyWithImpl<ChainFlag>(this as ChainFlag, _$identity);

  /// Serializes this ChainFlag to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChainFlag &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, enabled);

  @override
  String toString() {
    return 'ChainFlag(chainId: $chainId, enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class $ChainFlagCopyWith<$Res> {
  factory $ChainFlagCopyWith(ChainFlag value, $Res Function(ChainFlag) _then) =
      _$ChainFlagCopyWithImpl;
  @useResult
  $Res call({int chainId, bool enabled});
}

/// @nodoc
class _$ChainFlagCopyWithImpl<$Res> implements $ChainFlagCopyWith<$Res> {
  _$ChainFlagCopyWithImpl(this._self, this._then);

  final ChainFlag _self;
  final $Res Function(ChainFlag) _then;

  /// Create a copy of ChainFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? enabled = null,
  }) {
    return _then(_self.copyWith(
      chainId: null == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChainFlag implements ChainFlag {
  const _ChainFlag({required this.chainId, required this.enabled});
  factory _ChainFlag.fromJson(Map<String, dynamic> json) =>
      _$ChainFlagFromJson(json);

  @override
  final int chainId;
  @override
  final bool enabled;

  /// Create a copy of ChainFlag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChainFlagCopyWith<_ChainFlag> get copyWith =>
      __$ChainFlagCopyWithImpl<_ChainFlag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChainFlagToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChainFlag &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, enabled);

  @override
  String toString() {
    return 'ChainFlag(chainId: $chainId, enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class _$ChainFlagCopyWith<$Res>
    implements $ChainFlagCopyWith<$Res> {
  factory _$ChainFlagCopyWith(
          _ChainFlag value, $Res Function(_ChainFlag) _then) =
      __$ChainFlagCopyWithImpl;
  @override
  @useResult
  $Res call({int chainId, bool enabled});
}

/// @nodoc
class __$ChainFlagCopyWithImpl<$Res> implements _$ChainFlagCopyWith<$Res> {
  __$ChainFlagCopyWithImpl(this._self, this._then);

  final _ChainFlag _self;
  final $Res Function(_ChainFlag) _then;

  /// Create a copy of ChainFlag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chainId = null,
    Object? enabled = null,
  }) {
    return _then(_ChainFlag(
      chainId: null == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$FeatureFlags {
  bool get cardsEnabled;
  bool get swapEnabled;
  bool get exportKeysEnabled;
  bool get tronEnabled;

  /// Create a copy of FeatureFlags
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeatureFlagsCopyWith<FeatureFlags> get copyWith =>
      _$FeatureFlagsCopyWithImpl<FeatureFlags>(
          this as FeatureFlags, _$identity);

  /// Serializes this FeatureFlags to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeatureFlags &&
            (identical(other.cardsEnabled, cardsEnabled) ||
                other.cardsEnabled == cardsEnabled) &&
            (identical(other.swapEnabled, swapEnabled) ||
                other.swapEnabled == swapEnabled) &&
            (identical(other.exportKeysEnabled, exportKeysEnabled) ||
                other.exportKeysEnabled == exportKeysEnabled) &&
            (identical(other.tronEnabled, tronEnabled) ||
                other.tronEnabled == tronEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cardsEnabled, swapEnabled, exportKeysEnabled, tronEnabled);

  @override
  String toString() {
    return 'FeatureFlags(cardsEnabled: $cardsEnabled, swapEnabled: $swapEnabled, exportKeysEnabled: $exportKeysEnabled, tronEnabled: $tronEnabled)';
  }
}

/// @nodoc
abstract mixin class $FeatureFlagsCopyWith<$Res> {
  factory $FeatureFlagsCopyWith(
          FeatureFlags value, $Res Function(FeatureFlags) _then) =
      _$FeatureFlagsCopyWithImpl;
  @useResult
  $Res call(
      {bool cardsEnabled,
      bool swapEnabled,
      bool exportKeysEnabled,
      bool tronEnabled});
}

/// @nodoc
class _$FeatureFlagsCopyWithImpl<$Res> implements $FeatureFlagsCopyWith<$Res> {
  _$FeatureFlagsCopyWithImpl(this._self, this._then);

  final FeatureFlags _self;
  final $Res Function(FeatureFlags) _then;

  /// Create a copy of FeatureFlags
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardsEnabled = null,
    Object? swapEnabled = null,
    Object? exportKeysEnabled = null,
    Object? tronEnabled = null,
  }) {
    return _then(_self.copyWith(
      cardsEnabled: null == cardsEnabled
          ? _self.cardsEnabled
          : cardsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      swapEnabled: null == swapEnabled
          ? _self.swapEnabled
          : swapEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      exportKeysEnabled: null == exportKeysEnabled
          ? _self.exportKeysEnabled
          : exportKeysEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      tronEnabled: null == tronEnabled
          ? _self.tronEnabled
          : tronEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FeatureFlags implements FeatureFlags {
  const _FeatureFlags(
      {required this.cardsEnabled,
      required this.swapEnabled,
      required this.exportKeysEnabled,
      required this.tronEnabled});
  factory _FeatureFlags.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsFromJson(json);

  @override
  final bool cardsEnabled;
  @override
  final bool swapEnabled;
  @override
  final bool exportKeysEnabled;
  @override
  final bool tronEnabled;

  /// Create a copy of FeatureFlags
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FeatureFlagsCopyWith<_FeatureFlags> get copyWith =>
      __$FeatureFlagsCopyWithImpl<_FeatureFlags>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FeatureFlagsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FeatureFlags &&
            (identical(other.cardsEnabled, cardsEnabled) ||
                other.cardsEnabled == cardsEnabled) &&
            (identical(other.swapEnabled, swapEnabled) ||
                other.swapEnabled == swapEnabled) &&
            (identical(other.exportKeysEnabled, exportKeysEnabled) ||
                other.exportKeysEnabled == exportKeysEnabled) &&
            (identical(other.tronEnabled, tronEnabled) ||
                other.tronEnabled == tronEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cardsEnabled, swapEnabled, exportKeysEnabled, tronEnabled);

  @override
  String toString() {
    return 'FeatureFlags(cardsEnabled: $cardsEnabled, swapEnabled: $swapEnabled, exportKeysEnabled: $exportKeysEnabled, tronEnabled: $tronEnabled)';
  }
}

/// @nodoc
abstract mixin class _$FeatureFlagsCopyWith<$Res>
    implements $FeatureFlagsCopyWith<$Res> {
  factory _$FeatureFlagsCopyWith(
          _FeatureFlags value, $Res Function(_FeatureFlags) _then) =
      __$FeatureFlagsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool cardsEnabled,
      bool swapEnabled,
      bool exportKeysEnabled,
      bool tronEnabled});
}

/// @nodoc
class __$FeatureFlagsCopyWithImpl<$Res>
    implements _$FeatureFlagsCopyWith<$Res> {
  __$FeatureFlagsCopyWithImpl(this._self, this._then);

  final _FeatureFlags _self;
  final $Res Function(_FeatureFlags) _then;

  /// Create a copy of FeatureFlags
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cardsEnabled = null,
    Object? swapEnabled = null,
    Object? exportKeysEnabled = null,
    Object? tronEnabled = null,
  }) {
    return _then(_FeatureFlags(
      cardsEnabled: null == cardsEnabled
          ? _self.cardsEnabled
          : cardsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      swapEnabled: null == swapEnabled
          ? _self.swapEnabled
          : swapEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      exportKeysEnabled: null == exportKeysEnabled
          ? _self.exportKeysEnabled
          : exportKeysEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      tronEnabled: null == tronEnabled
          ? _self.tronEnabled
          : tronEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$Policies {
  /// Example: 50 = 0.50%
  int get maxSlippageBps;
  bool get requireKycForCardOrder;

  /// Create a copy of Policies
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PoliciesCopyWith<Policies> get copyWith =>
      _$PoliciesCopyWithImpl<Policies>(this as Policies, _$identity);

  /// Serializes this Policies to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Policies &&
            (identical(other.maxSlippageBps, maxSlippageBps) ||
                other.maxSlippageBps == maxSlippageBps) &&
            (identical(other.requireKycForCardOrder, requireKycForCardOrder) ||
                other.requireKycForCardOrder == requireKycForCardOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, maxSlippageBps, requireKycForCardOrder);

  @override
  String toString() {
    return 'Policies(maxSlippageBps: $maxSlippageBps, requireKycForCardOrder: $requireKycForCardOrder)';
  }
}

/// @nodoc
abstract mixin class $PoliciesCopyWith<$Res> {
  factory $PoliciesCopyWith(Policies value, $Res Function(Policies) _then) =
      _$PoliciesCopyWithImpl;
  @useResult
  $Res call({int maxSlippageBps, bool requireKycForCardOrder});
}

/// @nodoc
class _$PoliciesCopyWithImpl<$Res> implements $PoliciesCopyWith<$Res> {
  _$PoliciesCopyWithImpl(this._self, this._then);

  final Policies _self;
  final $Res Function(Policies) _then;

  /// Create a copy of Policies
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxSlippageBps = null,
    Object? requireKycForCardOrder = null,
  }) {
    return _then(_self.copyWith(
      maxSlippageBps: null == maxSlippageBps
          ? _self.maxSlippageBps
          : maxSlippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      requireKycForCardOrder: null == requireKycForCardOrder
          ? _self.requireKycForCardOrder
          : requireKycForCardOrder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Policies implements Policies {
  const _Policies(
      {required this.maxSlippageBps, required this.requireKycForCardOrder});
  factory _Policies.fromJson(Map<String, dynamic> json) =>
      _$PoliciesFromJson(json);

  /// Example: 50 = 0.50%
  @override
  final int maxSlippageBps;
  @override
  final bool requireKycForCardOrder;

  /// Create a copy of Policies
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PoliciesCopyWith<_Policies> get copyWith =>
      __$PoliciesCopyWithImpl<_Policies>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PoliciesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Policies &&
            (identical(other.maxSlippageBps, maxSlippageBps) ||
                other.maxSlippageBps == maxSlippageBps) &&
            (identical(other.requireKycForCardOrder, requireKycForCardOrder) ||
                other.requireKycForCardOrder == requireKycForCardOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, maxSlippageBps, requireKycForCardOrder);

  @override
  String toString() {
    return 'Policies(maxSlippageBps: $maxSlippageBps, requireKycForCardOrder: $requireKycForCardOrder)';
  }
}

/// @nodoc
abstract mixin class _$PoliciesCopyWith<$Res>
    implements $PoliciesCopyWith<$Res> {
  factory _$PoliciesCopyWith(_Policies value, $Res Function(_Policies) _then) =
      __$PoliciesCopyWithImpl;
  @override
  @useResult
  $Res call({int maxSlippageBps, bool requireKycForCardOrder});
}

/// @nodoc
class __$PoliciesCopyWithImpl<$Res> implements _$PoliciesCopyWith<$Res> {
  __$PoliciesCopyWithImpl(this._self, this._then);

  final _Policies _self;
  final $Res Function(_Policies) _then;

  /// Create a copy of Policies
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? maxSlippageBps = null,
    Object? requireKycForCardOrder = null,
  }) {
    return _then(_Policies(
      maxSlippageBps: null == maxSlippageBps
          ? _self.maxSlippageBps
          : maxSlippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      requireKycForCardOrder: null == requireKycForCardOrder
          ? _self.requireKycForCardOrder
          : requireKycForCardOrder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$KycStartResponse {
  String get provider;
  String get sdkToken;
  DateTime get expiresAt;

  /// Create a copy of KycStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KycStartResponseCopyWith<KycStartResponse> get copyWith =>
      _$KycStartResponseCopyWithImpl<KycStartResponse>(
          this as KycStartResponse, _$identity);

  /// Serializes this KycStartResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KycStartResponse &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.sdkToken, sdkToken) ||
                other.sdkToken == sdkToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, provider, sdkToken, expiresAt);

  @override
  String toString() {
    return 'KycStartResponse(provider: $provider, sdkToken: $sdkToken, expiresAt: $expiresAt)';
  }
}

/// @nodoc
abstract mixin class $KycStartResponseCopyWith<$Res> {
  factory $KycStartResponseCopyWith(
          KycStartResponse value, $Res Function(KycStartResponse) _then) =
      _$KycStartResponseCopyWithImpl;
  @useResult
  $Res call({String provider, String sdkToken, DateTime expiresAt});
}

/// @nodoc
class _$KycStartResponseCopyWithImpl<$Res>
    implements $KycStartResponseCopyWith<$Res> {
  _$KycStartResponseCopyWithImpl(this._self, this._then);

  final KycStartResponse _self;
  final $Res Function(KycStartResponse) _then;

  /// Create a copy of KycStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? sdkToken = null,
    Object? expiresAt = null,
  }) {
    return _then(_self.copyWith(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      sdkToken: null == sdkToken
          ? _self.sdkToken
          : sdkToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KycStartResponse implements KycStartResponse {
  const _KycStartResponse(
      {required this.provider,
      required this.sdkToken,
      required this.expiresAt});
  factory _KycStartResponse.fromJson(Map<String, dynamic> json) =>
      _$KycStartResponseFromJson(json);

  @override
  final String provider;
  @override
  final String sdkToken;
  @override
  final DateTime expiresAt;

  /// Create a copy of KycStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KycStartResponseCopyWith<_KycStartResponse> get copyWith =>
      __$KycStartResponseCopyWithImpl<_KycStartResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KycStartResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KycStartResponse &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.sdkToken, sdkToken) ||
                other.sdkToken == sdkToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, provider, sdkToken, expiresAt);

  @override
  String toString() {
    return 'KycStartResponse(provider: $provider, sdkToken: $sdkToken, expiresAt: $expiresAt)';
  }
}

/// @nodoc
abstract mixin class _$KycStartResponseCopyWith<$Res>
    implements $KycStartResponseCopyWith<$Res> {
  factory _$KycStartResponseCopyWith(
          _KycStartResponse value, $Res Function(_KycStartResponse) _then) =
      __$KycStartResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String provider, String sdkToken, DateTime expiresAt});
}

/// @nodoc
class __$KycStartResponseCopyWithImpl<$Res>
    implements _$KycStartResponseCopyWith<$Res> {
  __$KycStartResponseCopyWithImpl(this._self, this._then);

  final _KycStartResponse _self;
  final $Res Function(_KycStartResponse) _then;

  /// Create a copy of KycStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? provider = null,
    Object? sdkToken = null,
    Object? expiresAt = null,
  }) {
    return _then(_KycStartResponse(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      sdkToken: null == sdkToken
          ? _self.sdkToken
          : sdkToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$KycStatusResponse {
  KycStatus get status;
  DateTime get updatedAt;

  /// Create a copy of KycStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KycStatusResponseCopyWith<KycStatusResponse> get copyWith =>
      _$KycStatusResponseCopyWithImpl<KycStatusResponse>(
          this as KycStatusResponse, _$identity);

  /// Serializes this KycStatusResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KycStatusResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, updatedAt);

  @override
  String toString() {
    return 'KycStatusResponse(status: $status, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $KycStatusResponseCopyWith<$Res> {
  factory $KycStatusResponseCopyWith(
          KycStatusResponse value, $Res Function(KycStatusResponse) _then) =
      _$KycStatusResponseCopyWithImpl;
  @useResult
  $Res call({KycStatus status, DateTime updatedAt});
}

/// @nodoc
class _$KycStatusResponseCopyWithImpl<$Res>
    implements $KycStatusResponseCopyWith<$Res> {
  _$KycStatusResponseCopyWithImpl(this._self, this._then);

  final KycStatusResponse _self;
  final $Res Function(KycStatusResponse) _then;

  /// Create a copy of KycStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as KycStatus,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KycStatusResponse implements KycStatusResponse {
  const _KycStatusResponse({required this.status, required this.updatedAt});
  factory _KycStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$KycStatusResponseFromJson(json);

  @override
  final KycStatus status;
  @override
  final DateTime updatedAt;

  /// Create a copy of KycStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KycStatusResponseCopyWith<_KycStatusResponse> get copyWith =>
      __$KycStatusResponseCopyWithImpl<_KycStatusResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KycStatusResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KycStatusResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, updatedAt);

  @override
  String toString() {
    return 'KycStatusResponse(status: $status, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$KycStatusResponseCopyWith<$Res>
    implements $KycStatusResponseCopyWith<$Res> {
  factory _$KycStatusResponseCopyWith(
          _KycStatusResponse value, $Res Function(_KycStatusResponse) _then) =
      __$KycStatusResponseCopyWithImpl;
  @override
  @useResult
  $Res call({KycStatus status, DateTime updatedAt});
}

/// @nodoc
class __$KycStatusResponseCopyWithImpl<$Res>
    implements _$KycStatusResponseCopyWith<$Res> {
  __$KycStatusResponseCopyWithImpl(this._self, this._then);

  final _KycStatusResponse _self;
  final $Res Function(_KycStatusResponse) _then;

  /// Create a copy of KycStatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? updatedAt = null,
  }) {
    return _then(_KycStatusResponse(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as KycStatus,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$OtpRequestResponse {
  /// e.g. "sent"
  String get status;

  /// Create a copy of OtpRequestResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtpRequestResponseCopyWith<OtpRequestResponse> get copyWith =>
      _$OtpRequestResponseCopyWithImpl<OtpRequestResponse>(
          this as OtpRequestResponse, _$identity);

  /// Serializes this OtpRequestResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtpRequestResponse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'OtpRequestResponse(status: $status)';
  }
}

/// @nodoc
abstract mixin class $OtpRequestResponseCopyWith<$Res> {
  factory $OtpRequestResponseCopyWith(
          OtpRequestResponse value, $Res Function(OtpRequestResponse) _then) =
      _$OtpRequestResponseCopyWithImpl;
  @useResult
  $Res call({String status});
}

/// @nodoc
class _$OtpRequestResponseCopyWithImpl<$Res>
    implements $OtpRequestResponseCopyWith<$Res> {
  _$OtpRequestResponseCopyWithImpl(this._self, this._then);

  final OtpRequestResponse _self;
  final $Res Function(OtpRequestResponse) _then;

  /// Create a copy of OtpRequestResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OtpRequestResponse implements OtpRequestResponse {
  const _OtpRequestResponse({required this.status});
  factory _OtpRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestResponseFromJson(json);

  /// e.g. "sent"
  @override
  final String status;

  /// Create a copy of OtpRequestResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OtpRequestResponseCopyWith<_OtpRequestResponse> get copyWith =>
      __$OtpRequestResponseCopyWithImpl<_OtpRequestResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OtpRequestResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpRequestResponse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'OtpRequestResponse(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$OtpRequestResponseCopyWith<$Res>
    implements $OtpRequestResponseCopyWith<$Res> {
  factory _$OtpRequestResponseCopyWith(
          _OtpRequestResponse value, $Res Function(_OtpRequestResponse) _then) =
      __$OtpRequestResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String status});
}

/// @nodoc
class __$OtpRequestResponseCopyWithImpl<$Res>
    implements _$OtpRequestResponseCopyWith<$Res> {
  __$OtpRequestResponseCopyWithImpl(this._self, this._then);

  final _OtpRequestResponse _self;
  final $Res Function(_OtpRequestResponse) _then;

  /// Create a copy of OtpRequestResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
  }) {
    return _then(_OtpRequestResponse(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OtpVerifyResponse {
  /// e.g. "verified"
  String get status;

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtpVerifyResponseCopyWith<OtpVerifyResponse> get copyWith =>
      _$OtpVerifyResponseCopyWithImpl<OtpVerifyResponse>(
          this as OtpVerifyResponse, _$identity);

  /// Serializes this OtpVerifyResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtpVerifyResponse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'OtpVerifyResponse(status: $status)';
  }
}

/// @nodoc
abstract mixin class $OtpVerifyResponseCopyWith<$Res> {
  factory $OtpVerifyResponseCopyWith(
          OtpVerifyResponse value, $Res Function(OtpVerifyResponse) _then) =
      _$OtpVerifyResponseCopyWithImpl;
  @useResult
  $Res call({String status});
}

/// @nodoc
class _$OtpVerifyResponseCopyWithImpl<$Res>
    implements $OtpVerifyResponseCopyWith<$Res> {
  _$OtpVerifyResponseCopyWithImpl(this._self, this._then);

  final OtpVerifyResponse _self;
  final $Res Function(OtpVerifyResponse) _then;

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OtpVerifyResponse implements OtpVerifyResponse {
  const _OtpVerifyResponse({required this.status});
  factory _OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseFromJson(json);

  /// e.g. "verified"
  @override
  final String status;

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OtpVerifyResponseCopyWith<_OtpVerifyResponse> get copyWith =>
      __$OtpVerifyResponseCopyWithImpl<_OtpVerifyResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OtpVerifyResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpVerifyResponse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'OtpVerifyResponse(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$OtpVerifyResponseCopyWith<$Res>
    implements $OtpVerifyResponseCopyWith<$Res> {
  factory _$OtpVerifyResponseCopyWith(
          _OtpVerifyResponse value, $Res Function(_OtpVerifyResponse) _then) =
      __$OtpVerifyResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String status});
}

/// @nodoc
class __$OtpVerifyResponseCopyWithImpl<$Res>
    implements _$OtpVerifyResponseCopyWith<$Res> {
  __$OtpVerifyResponseCopyWithImpl(this._self, this._then);

  final _OtpVerifyResponse _self;
  final $Res Function(_OtpVerifyResponse) _then;

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
  }) {
    return _then(_OtpVerifyResponse(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ShippingAddress {
  String get name;
  String get address1;
  String? get address2;
  String get city;
  String get postcode;
  String get country;

  /// Create a copy of ShippingAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShippingAddressCopyWith<ShippingAddress> get copyWith =>
      _$ShippingAddressCopyWithImpl<ShippingAddress>(
          this as ShippingAddress, _$identity);

  /// Serializes this ShippingAddress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShippingAddress &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address1, address1) ||
                other.address1 == address1) &&
            (identical(other.address2, address2) ||
                other.address2 == address2) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.postcode, postcode) ||
                other.postcode == postcode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, address1, address2, city, postcode, country);

  @override
  String toString() {
    return 'ShippingAddress(name: $name, address1: $address1, address2: $address2, city: $city, postcode: $postcode, country: $country)';
  }
}

/// @nodoc
abstract mixin class $ShippingAddressCopyWith<$Res> {
  factory $ShippingAddressCopyWith(
          ShippingAddress value, $Res Function(ShippingAddress) _then) =
      _$ShippingAddressCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String address1,
      String? address2,
      String city,
      String postcode,
      String country});
}

/// @nodoc
class _$ShippingAddressCopyWithImpl<$Res>
    implements $ShippingAddressCopyWith<$Res> {
  _$ShippingAddressCopyWithImpl(this._self, this._then);

  final ShippingAddress _self;
  final $Res Function(ShippingAddress) _then;

  /// Create a copy of ShippingAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address1 = null,
    Object? address2 = freezed,
    Object? city = null,
    Object? postcode = null,
    Object? country = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address1: null == address1
          ? _self.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String,
      address2: freezed == address2
          ? _self.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      postcode: null == postcode
          ? _self.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ShippingAddress implements ShippingAddress {
  const _ShippingAddress(
      {required this.name,
      required this.address1,
      this.address2,
      required this.city,
      required this.postcode,
      required this.country});
  factory _ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  @override
  final String name;
  @override
  final String address1;
  @override
  final String? address2;
  @override
  final String city;
  @override
  final String postcode;
  @override
  final String country;

  /// Create a copy of ShippingAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShippingAddressCopyWith<_ShippingAddress> get copyWith =>
      __$ShippingAddressCopyWithImpl<_ShippingAddress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShippingAddressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShippingAddress &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address1, address1) ||
                other.address1 == address1) &&
            (identical(other.address2, address2) ||
                other.address2 == address2) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.postcode, postcode) ||
                other.postcode == postcode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, address1, address2, city, postcode, country);

  @override
  String toString() {
    return 'ShippingAddress(name: $name, address1: $address1, address2: $address2, city: $city, postcode: $postcode, country: $country)';
  }
}

/// @nodoc
abstract mixin class _$ShippingAddressCopyWith<$Res>
    implements $ShippingAddressCopyWith<$Res> {
  factory _$ShippingAddressCopyWith(
          _ShippingAddress value, $Res Function(_ShippingAddress) _then) =
      __$ShippingAddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String address1,
      String? address2,
      String city,
      String postcode,
      String country});
}

/// @nodoc
class __$ShippingAddressCopyWithImpl<$Res>
    implements _$ShippingAddressCopyWith<$Res> {
  __$ShippingAddressCopyWithImpl(this._self, this._then);

  final _ShippingAddress _self;
  final $Res Function(_ShippingAddress) _then;

  /// Create a copy of ShippingAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? address1 = null,
    Object? address2 = freezed,
    Object? city = null,
    Object? postcode = null,
    Object? country = null,
  }) {
    return _then(_ShippingAddress(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address1: null == address1
          ? _self.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String,
      address2: freezed == address2
          ? _self.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      postcode: null == postcode
          ? _self.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CardSummary {
  String get id;
  CardType get type;
  CardStatus get status;
  String get last4;

  /// Create a copy of CardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardSummaryCopyWith<CardSummary> get copyWith =>
      _$CardSummaryCopyWithImpl<CardSummary>(this as CardSummary, _$identity);

  /// Serializes this CardSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.last4, last4) || other.last4 == last4));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, status, last4);

  @override
  String toString() {
    return 'CardSummary(id: $id, type: $type, status: $status, last4: $last4)';
  }
}

/// @nodoc
abstract mixin class $CardSummaryCopyWith<$Res> {
  factory $CardSummaryCopyWith(
          CardSummary value, $Res Function(CardSummary) _then) =
      _$CardSummaryCopyWithImpl;
  @useResult
  $Res call({String id, CardType type, CardStatus status, String last4});
}

/// @nodoc
class _$CardSummaryCopyWithImpl<$Res> implements $CardSummaryCopyWith<$Res> {
  _$CardSummaryCopyWithImpl(this._self, this._then);

  final CardSummary _self;
  final $Res Function(CardSummary) _then;

  /// Create a copy of CardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? last4 = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CardType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CardStatus,
      last4: null == last4
          ? _self.last4
          : last4 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CardSummary implements CardSummary {
  const _CardSummary(
      {required this.id,
      required this.type,
      required this.status,
      required this.last4});
  factory _CardSummary.fromJson(Map<String, dynamic> json) =>
      _$CardSummaryFromJson(json);

  @override
  final String id;
  @override
  final CardType type;
  @override
  final CardStatus status;
  @override
  final String last4;

  /// Create a copy of CardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardSummaryCopyWith<_CardSummary> get copyWith =>
      __$CardSummaryCopyWithImpl<_CardSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.last4, last4) || other.last4 == last4));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, status, last4);

  @override
  String toString() {
    return 'CardSummary(id: $id, type: $type, status: $status, last4: $last4)';
  }
}

/// @nodoc
abstract mixin class _$CardSummaryCopyWith<$Res>
    implements $CardSummaryCopyWith<$Res> {
  factory _$CardSummaryCopyWith(
          _CardSummary value, $Res Function(_CardSummary) _then) =
      __$CardSummaryCopyWithImpl;
  @override
  @useResult
  $Res call({String id, CardType type, CardStatus status, String last4});
}

/// @nodoc
class __$CardSummaryCopyWithImpl<$Res> implements _$CardSummaryCopyWith<$Res> {
  __$CardSummaryCopyWithImpl(this._self, this._then);

  final _CardSummary _self;
  final $Res Function(_CardSummary) _then;

  /// Create a copy of CardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? last4 = null,
  }) {
    return _then(_CardSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CardType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CardStatus,
      last4: null == last4
          ? _self.last4
          : last4 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CardsListResponse {
  List<CardSummary> get cards;

  /// Create a copy of CardsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardsListResponseCopyWith<CardsListResponse> get copyWith =>
      _$CardsListResponseCopyWithImpl<CardsListResponse>(
          this as CardsListResponse, _$identity);

  /// Serializes this CardsListResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardsListResponse &&
            const DeepCollectionEquality().equals(other.cards, cards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(cards));

  @override
  String toString() {
    return 'CardsListResponse(cards: $cards)';
  }
}

/// @nodoc
abstract mixin class $CardsListResponseCopyWith<$Res> {
  factory $CardsListResponseCopyWith(
          CardsListResponse value, $Res Function(CardsListResponse) _then) =
      _$CardsListResponseCopyWithImpl;
  @useResult
  $Res call({List<CardSummary> cards});
}

/// @nodoc
class _$CardsListResponseCopyWithImpl<$Res>
    implements $CardsListResponseCopyWith<$Res> {
  _$CardsListResponseCopyWithImpl(this._self, this._then);

  final CardsListResponse _self;
  final $Res Function(CardsListResponse) _then;

  /// Create a copy of CardsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_self.copyWith(
      cards: null == cards
          ? _self.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CardsListResponse implements CardsListResponse {
  const _CardsListResponse({required final List<CardSummary> cards})
      : _cards = cards;
  factory _CardsListResponse.fromJson(Map<String, dynamic> json) =>
      _$CardsListResponseFromJson(json);

  final List<CardSummary> _cards;
  @override
  List<CardSummary> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  /// Create a copy of CardsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardsListResponseCopyWith<_CardsListResponse> get copyWith =>
      __$CardsListResponseCopyWithImpl<_CardsListResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardsListResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardsListResponse &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @override
  String toString() {
    return 'CardsListResponse(cards: $cards)';
  }
}

/// @nodoc
abstract mixin class _$CardsListResponseCopyWith<$Res>
    implements $CardsListResponseCopyWith<$Res> {
  factory _$CardsListResponseCopyWith(
          _CardsListResponse value, $Res Function(_CardsListResponse) _then) =
      __$CardsListResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<CardSummary> cards});
}

/// @nodoc
class __$CardsListResponseCopyWithImpl<$Res>
    implements _$CardsListResponseCopyWith<$Res> {
  __$CardsListResponseCopyWithImpl(this._self, this._then);

  final _CardsListResponse _self;
  final $Res Function(_CardsListResponse) _then;

  /// Create a copy of CardsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cards = null,
  }) {
    return _then(_CardsListResponse(
      cards: null == cards
          ? _self._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardSummary>,
    ));
  }
}

/// @nodoc
mixin _$CardTransaction {
  String get id;
  double get amount;
  String get currency;
  String get merchant;

  /// e.g. authorized/settled/declined
  String get status;
  DateTime get time;
  Map<String, dynamic> get metadata;

  /// Create a copy of CardTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardTransactionCopyWith<CardTransaction> get copyWith =>
      _$CardTransactionCopyWithImpl<CardTransaction>(
          this as CardTransaction, _$identity);

  /// Serializes this CardTransaction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardTransaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, currency, merchant,
      status, time, const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'CardTransaction(id: $id, amount: $amount, currency: $currency, merchant: $merchant, status: $status, time: $time, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $CardTransactionCopyWith<$Res> {
  factory $CardTransactionCopyWith(
          CardTransaction value, $Res Function(CardTransaction) _then) =
      _$CardTransactionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      double amount,
      String currency,
      String merchant,
      String status,
      DateTime time,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$CardTransactionCopyWithImpl<$Res>
    implements $CardTransactionCopyWith<$Res> {
  _$CardTransactionCopyWithImpl(this._self, this._then);

  final CardTransaction _self;
  final $Res Function(CardTransaction) _then;

  /// Create a copy of CardTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? currency = null,
    Object? merchant = null,
    Object? status = null,
    Object? time = null,
    Object? metadata = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      merchant: null == merchant
          ? _self.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CardTransaction implements CardTransaction {
  const _CardTransaction(
      {required this.id,
      required this.amount,
      required this.currency,
      required this.merchant,
      required this.status,
      required this.time,
      final Map<String, dynamic> metadata = const <String, dynamic>{}})
      : _metadata = metadata;
  factory _CardTransaction.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String merchant;

  /// e.g. authorized/settled/declined
  @override
  final String status;
  @override
  final DateTime time;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// Create a copy of CardTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardTransactionCopyWith<_CardTransaction> get copyWith =>
      __$CardTransactionCopyWithImpl<_CardTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardTransactionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardTransaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, currency, merchant,
      status, time, const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'CardTransaction(id: $id, amount: $amount, currency: $currency, merchant: $merchant, status: $status, time: $time, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$CardTransactionCopyWith<$Res>
    implements $CardTransactionCopyWith<$Res> {
  factory _$CardTransactionCopyWith(
          _CardTransaction value, $Res Function(_CardTransaction) _then) =
      __$CardTransactionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      String currency,
      String merchant,
      String status,
      DateTime time,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$CardTransactionCopyWithImpl<$Res>
    implements _$CardTransactionCopyWith<$Res> {
  __$CardTransactionCopyWithImpl(this._self, this._then);

  final _CardTransaction _self;
  final $Res Function(_CardTransaction) _then;

  /// Create a copy of CardTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? currency = null,
    Object? merchant = null,
    Object? status = null,
    Object? time = null,
    Object? metadata = null,
  }) {
    return _then(_CardTransaction(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      merchant: null == merchant
          ? _self.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$CardTransactionsResponse {
  String? get cursor;
  List<CardTransaction> get transactions;

  /// Create a copy of CardTransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardTransactionsResponseCopyWith<CardTransactionsResponse> get copyWith =>
      _$CardTransactionsResponseCopyWithImpl<CardTransactionsResponse>(
          this as CardTransactionsResponse, _$identity);

  /// Serializes this CardTransactionsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardTransactionsResponse &&
            (identical(other.cursor, cursor) || other.cursor == cursor) &&
            const DeepCollectionEquality()
                .equals(other.transactions, transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cursor, const DeepCollectionEquality().hash(transactions));

  @override
  String toString() {
    return 'CardTransactionsResponse(cursor: $cursor, transactions: $transactions)';
  }
}

/// @nodoc
abstract mixin class $CardTransactionsResponseCopyWith<$Res> {
  factory $CardTransactionsResponseCopyWith(CardTransactionsResponse value,
          $Res Function(CardTransactionsResponse) _then) =
      _$CardTransactionsResponseCopyWithImpl;
  @useResult
  $Res call({String? cursor, List<CardTransaction> transactions});
}

/// @nodoc
class _$CardTransactionsResponseCopyWithImpl<$Res>
    implements $CardTransactionsResponseCopyWith<$Res> {
  _$CardTransactionsResponseCopyWithImpl(this._self, this._then);

  final CardTransactionsResponse _self;
  final $Res Function(CardTransactionsResponse) _then;

  /// Create a copy of CardTransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cursor = freezed,
    Object? transactions = null,
  }) {
    return _then(_self.copyWith(
      cursor: freezed == cursor
          ? _self.cursor
          : cursor // ignore: cast_nullable_to_non_nullable
              as String?,
      transactions: null == transactions
          ? _self.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<CardTransaction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CardTransactionsResponse implements CardTransactionsResponse {
  const _CardTransactionsResponse(
      {this.cursor, required final List<CardTransaction> transactions})
      : _transactions = transactions;
  factory _CardTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionsResponseFromJson(json);

  @override
  final String? cursor;
  final List<CardTransaction> _transactions;
  @override
  List<CardTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  /// Create a copy of CardTransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardTransactionsResponseCopyWith<_CardTransactionsResponse> get copyWith =>
      __$CardTransactionsResponseCopyWithImpl<_CardTransactionsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardTransactionsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardTransactionsResponse &&
            (identical(other.cursor, cursor) || other.cursor == cursor) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cursor, const DeepCollectionEquality().hash(_transactions));

  @override
  String toString() {
    return 'CardTransactionsResponse(cursor: $cursor, transactions: $transactions)';
  }
}

/// @nodoc
abstract mixin class _$CardTransactionsResponseCopyWith<$Res>
    implements $CardTransactionsResponseCopyWith<$Res> {
  factory _$CardTransactionsResponseCopyWith(_CardTransactionsResponse value,
          $Res Function(_CardTransactionsResponse) _then) =
      __$CardTransactionsResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String? cursor, List<CardTransaction> transactions});
}

/// @nodoc
class __$CardTransactionsResponseCopyWithImpl<$Res>
    implements _$CardTransactionsResponseCopyWith<$Res> {
  __$CardTransactionsResponseCopyWithImpl(this._self, this._then);

  final _CardTransactionsResponse _self;
  final $Res Function(_CardTransactionsResponse) _then;

  /// Create a copy of CardTransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cursor = freezed,
    Object? transactions = null,
  }) {
    return _then(_CardTransactionsResponse(
      cursor: freezed == cursor
          ? _self.cursor
          : cursor // ignore: cast_nullable_to_non_nullable
              as String?,
      transactions: null == transactions
          ? _self._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<CardTransaction>,
    ));
  }
}

/// @nodoc
mixin _$SwapQuoteRequest {
  int get chainId;

  /// Token address. Use 0x000..000 for native ETH OR standardize to WETH.
  String get fromToken;
  String get toToken;

  /// In smallest unit (wei for ETH, token decimals for ERC20)
  String get amountIn;

  /// Active EOA address
  String get taker;

  /// Example: 50 = 0.50%
  int get slippageBps;

  /// "auto" or specific DEX name
  String get preferredDex;

  /// Create a copy of SwapQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapQuoteRequestCopyWith<SwapQuoteRequest> get copyWith =>
      _$SwapQuoteRequestCopyWithImpl<SwapQuoteRequest>(
          this as SwapQuoteRequest, _$identity);

  /// Serializes this SwapQuoteRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapQuoteRequest &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.fromToken, fromToken) ||
                other.fromToken == fromToken) &&
            (identical(other.toToken, toToken) || other.toToken == toToken) &&
            (identical(other.amountIn, amountIn) ||
                other.amountIn == amountIn) &&
            (identical(other.taker, taker) || other.taker == taker) &&
            (identical(other.slippageBps, slippageBps) ||
                other.slippageBps == slippageBps) &&
            (identical(other.preferredDex, preferredDex) ||
                other.preferredDex == preferredDex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, fromToken, toToken,
      amountIn, taker, slippageBps, preferredDex);

  @override
  String toString() {
    return 'SwapQuoteRequest(chainId: $chainId, fromToken: $fromToken, toToken: $toToken, amountIn: $amountIn, taker: $taker, slippageBps: $slippageBps, preferredDex: $preferredDex)';
  }
}

/// @nodoc
abstract mixin class $SwapQuoteRequestCopyWith<$Res> {
  factory $SwapQuoteRequestCopyWith(
          SwapQuoteRequest value, $Res Function(SwapQuoteRequest) _then) =
      _$SwapQuoteRequestCopyWithImpl;
  @useResult
  $Res call(
      {int chainId,
      String fromToken,
      String toToken,
      String amountIn,
      String taker,
      int slippageBps,
      String preferredDex});
}

/// @nodoc
class _$SwapQuoteRequestCopyWithImpl<$Res>
    implements $SwapQuoteRequestCopyWith<$Res> {
  _$SwapQuoteRequestCopyWithImpl(this._self, this._then);

  final SwapQuoteRequest _self;
  final $Res Function(SwapQuoteRequest) _then;

  /// Create a copy of SwapQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? fromToken = null,
    Object? toToken = null,
    Object? amountIn = null,
    Object? taker = null,
    Object? slippageBps = null,
    Object? preferredDex = null,
  }) {
    return _then(_self.copyWith(
      chainId: null == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      fromToken: null == fromToken
          ? _self.fromToken
          : fromToken // ignore: cast_nullable_to_non_nullable
              as String,
      toToken: null == toToken
          ? _self.toToken
          : toToken // ignore: cast_nullable_to_non_nullable
              as String,
      amountIn: null == amountIn
          ? _self.amountIn
          : amountIn // ignore: cast_nullable_to_non_nullable
              as String,
      taker: null == taker
          ? _self.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String,
      slippageBps: null == slippageBps
          ? _self.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      preferredDex: null == preferredDex
          ? _self.preferredDex
          : preferredDex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SwapQuoteRequest implements SwapQuoteRequest {
  const _SwapQuoteRequest(
      {required this.chainId,
      required this.fromToken,
      required this.toToken,
      required this.amountIn,
      required this.taker,
      required this.slippageBps,
      required this.preferredDex});
  factory _SwapQuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$SwapQuoteRequestFromJson(json);

  @override
  final int chainId;

  /// Token address. Use 0x000..000 for native ETH OR standardize to WETH.
  @override
  final String fromToken;
  @override
  final String toToken;

  /// In smallest unit (wei for ETH, token decimals for ERC20)
  @override
  final String amountIn;

  /// Active EOA address
  @override
  final String taker;

  /// Example: 50 = 0.50%
  @override
  final int slippageBps;

  /// "auto" or specific DEX name
  @override
  final String preferredDex;

  /// Create a copy of SwapQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapQuoteRequestCopyWith<_SwapQuoteRequest> get copyWith =>
      __$SwapQuoteRequestCopyWithImpl<_SwapQuoteRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapQuoteRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapQuoteRequest &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.fromToken, fromToken) ||
                other.fromToken == fromToken) &&
            (identical(other.toToken, toToken) || other.toToken == toToken) &&
            (identical(other.amountIn, amountIn) ||
                other.amountIn == amountIn) &&
            (identical(other.taker, taker) || other.taker == taker) &&
            (identical(other.slippageBps, slippageBps) ||
                other.slippageBps == slippageBps) &&
            (identical(other.preferredDex, preferredDex) ||
                other.preferredDex == preferredDex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, fromToken, toToken,
      amountIn, taker, slippageBps, preferredDex);

  @override
  String toString() {
    return 'SwapQuoteRequest(chainId: $chainId, fromToken: $fromToken, toToken: $toToken, amountIn: $amountIn, taker: $taker, slippageBps: $slippageBps, preferredDex: $preferredDex)';
  }
}

/// @nodoc
abstract mixin class _$SwapQuoteRequestCopyWith<$Res>
    implements $SwapQuoteRequestCopyWith<$Res> {
  factory _$SwapQuoteRequestCopyWith(
          _SwapQuoteRequest value, $Res Function(_SwapQuoteRequest) _then) =
      __$SwapQuoteRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int chainId,
      String fromToken,
      String toToken,
      String amountIn,
      String taker,
      int slippageBps,
      String preferredDex});
}

/// @nodoc
class __$SwapQuoteRequestCopyWithImpl<$Res>
    implements _$SwapQuoteRequestCopyWith<$Res> {
  __$SwapQuoteRequestCopyWithImpl(this._self, this._then);

  final _SwapQuoteRequest _self;
  final $Res Function(_SwapQuoteRequest) _then;

  /// Create a copy of SwapQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chainId = null,
    Object? fromToken = null,
    Object? toToken = null,
    Object? amountIn = null,
    Object? taker = null,
    Object? slippageBps = null,
    Object? preferredDex = null,
  }) {
    return _then(_SwapQuoteRequest(
      chainId: null == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      fromToken: null == fromToken
          ? _self.fromToken
          : fromToken // ignore: cast_nullable_to_non_nullable
              as String,
      toToken: null == toToken
          ? _self.toToken
          : toToken // ignore: cast_nullable_to_non_nullable
              as String,
      amountIn: null == amountIn
          ? _self.amountIn
          : amountIn // ignore: cast_nullable_to_non_nullable
              as String,
      taker: null == taker
          ? _self.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String,
      slippageBps: null == slippageBps
          ? _self.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      preferredDex: null == preferredDex
          ? _self.preferredDex
          : preferredDex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SwapRoute {
  /// "0x", "1inch", "paraswap", etc.
  String get aggregator;

  /// Suggested DEX route name
  String get dex;

  /// Gas estimate (string to avoid int overflow)
  String get estimatedGas;

  /// Create a copy of SwapRoute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapRouteCopyWith<SwapRoute> get copyWith =>
      _$SwapRouteCopyWithImpl<SwapRoute>(this as SwapRoute, _$identity);

  /// Serializes this SwapRoute to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapRoute &&
            (identical(other.aggregator, aggregator) ||
                other.aggregator == aggregator) &&
            (identical(other.dex, dex) || other.dex == dex) &&
            (identical(other.estimatedGas, estimatedGas) ||
                other.estimatedGas == estimatedGas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, aggregator, dex, estimatedGas);

  @override
  String toString() {
    return 'SwapRoute(aggregator: $aggregator, dex: $dex, estimatedGas: $estimatedGas)';
  }
}

/// @nodoc
abstract mixin class $SwapRouteCopyWith<$Res> {
  factory $SwapRouteCopyWith(SwapRoute value, $Res Function(SwapRoute) _then) =
      _$SwapRouteCopyWithImpl;
  @useResult
  $Res call({String aggregator, String dex, String estimatedGas});
}

/// @nodoc
class _$SwapRouteCopyWithImpl<$Res> implements $SwapRouteCopyWith<$Res> {
  _$SwapRouteCopyWithImpl(this._self, this._then);

  final SwapRoute _self;
  final $Res Function(SwapRoute) _then;

  /// Create a copy of SwapRoute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aggregator = null,
    Object? dex = null,
    Object? estimatedGas = null,
  }) {
    return _then(_self.copyWith(
      aggregator: null == aggregator
          ? _self.aggregator
          : aggregator // ignore: cast_nullable_to_non_nullable
              as String,
      dex: null == dex
          ? _self.dex
          : dex // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedGas: null == estimatedGas
          ? _self.estimatedGas
          : estimatedGas // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SwapRoute implements SwapRoute {
  const _SwapRoute(
      {required this.aggregator,
      required this.dex,
      required this.estimatedGas});
  factory _SwapRoute.fromJson(Map<String, dynamic> json) =>
      _$SwapRouteFromJson(json);

  /// "0x", "1inch", "paraswap", etc.
  @override
  final String aggregator;

  /// Suggested DEX route name
  @override
  final String dex;

  /// Gas estimate (string to avoid int overflow)
  @override
  final String estimatedGas;

  /// Create a copy of SwapRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapRouteCopyWith<_SwapRoute> get copyWith =>
      __$SwapRouteCopyWithImpl<_SwapRoute>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapRouteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapRoute &&
            (identical(other.aggregator, aggregator) ||
                other.aggregator == aggregator) &&
            (identical(other.dex, dex) || other.dex == dex) &&
            (identical(other.estimatedGas, estimatedGas) ||
                other.estimatedGas == estimatedGas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, aggregator, dex, estimatedGas);

  @override
  String toString() {
    return 'SwapRoute(aggregator: $aggregator, dex: $dex, estimatedGas: $estimatedGas)';
  }
}

/// @nodoc
abstract mixin class _$SwapRouteCopyWith<$Res>
    implements $SwapRouteCopyWith<$Res> {
  factory _$SwapRouteCopyWith(
          _SwapRoute value, $Res Function(_SwapRoute) _then) =
      __$SwapRouteCopyWithImpl;
  @override
  @useResult
  $Res call({String aggregator, String dex, String estimatedGas});
}

/// @nodoc
class __$SwapRouteCopyWithImpl<$Res> implements _$SwapRouteCopyWith<$Res> {
  __$SwapRouteCopyWithImpl(this._self, this._then);

  final _SwapRoute _self;
  final $Res Function(_SwapRoute) _then;

  /// Create a copy of SwapRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? aggregator = null,
    Object? dex = null,
    Object? estimatedGas = null,
  }) {
    return _then(_SwapRoute(
      aggregator: null == aggregator
          ? _self.aggregator
          : aggregator // ignore: cast_nullable_to_non_nullable
              as String,
      dex: null == dex
          ? _self.dex
          : dex // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedGas: null == estimatedGas
          ? _self.estimatedGas
          : estimatedGas // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SwapApproval {
  bool get isRequired;
  String get spender;

  /// Approval amount in smallest unit
  String get amount;

  /// Create a copy of SwapApproval
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapApprovalCopyWith<SwapApproval> get copyWith =>
      _$SwapApprovalCopyWithImpl<SwapApproval>(
          this as SwapApproval, _$identity);

  /// Serializes this SwapApproval to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapApproval &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.spender, spender) || other.spender == spender) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isRequired, spender, amount);

  @override
  String toString() {
    return 'SwapApproval(isRequired: $isRequired, spender: $spender, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $SwapApprovalCopyWith<$Res> {
  factory $SwapApprovalCopyWith(
          SwapApproval value, $Res Function(SwapApproval) _then) =
      _$SwapApprovalCopyWithImpl;
  @useResult
  $Res call({bool isRequired, String spender, String amount});
}

/// @nodoc
class _$SwapApprovalCopyWithImpl<$Res> implements $SwapApprovalCopyWith<$Res> {
  _$SwapApprovalCopyWithImpl(this._self, this._then);

  final SwapApproval _self;
  final $Res Function(SwapApproval) _then;

  /// Create a copy of SwapApproval
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRequired = null,
    Object? spender = null,
    Object? amount = null,
  }) {
    return _then(_self.copyWith(
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      spender: null == spender
          ? _self.spender
          : spender // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SwapApproval implements SwapApproval {
  const _SwapApproval(
      {required this.isRequired, required this.spender, required this.amount});
  factory _SwapApproval.fromJson(Map<String, dynamic> json) =>
      _$SwapApprovalFromJson(json);

  @override
  final bool isRequired;
  @override
  final String spender;

  /// Approval amount in smallest unit
  @override
  final String amount;

  /// Create a copy of SwapApproval
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapApprovalCopyWith<_SwapApproval> get copyWith =>
      __$SwapApprovalCopyWithImpl<_SwapApproval>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapApprovalToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapApproval &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.spender, spender) || other.spender == spender) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isRequired, spender, amount);

  @override
  String toString() {
    return 'SwapApproval(isRequired: $isRequired, spender: $spender, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$SwapApprovalCopyWith<$Res>
    implements $SwapApprovalCopyWith<$Res> {
  factory _$SwapApprovalCopyWith(
          _SwapApproval value, $Res Function(_SwapApproval) _then) =
      __$SwapApprovalCopyWithImpl;
  @override
  @useResult
  $Res call({bool isRequired, String spender, String amount});
}

/// @nodoc
class __$SwapApprovalCopyWithImpl<$Res>
    implements _$SwapApprovalCopyWith<$Res> {
  __$SwapApprovalCopyWithImpl(this._self, this._then);

  final _SwapApproval _self;
  final $Res Function(_SwapApproval) _then;

  /// Create a copy of SwapApproval
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isRequired = null,
    Object? spender = null,
    Object? amount = null,
  }) {
    return _then(_SwapApproval(
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      spender: null == spender
          ? _self.spender
          : spender // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SwapQuoteResponse {
  String get quoteId;
  int get chainId;
  String get amountIn;
  String get amountOut;

  /// AmountOut after slippage protection
  String get minOut;
  SwapRoute get route;
  SwapApproval get approval;
  DateTime get expiresAt;
  List<String> get warnings;

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapQuoteResponseCopyWith<SwapQuoteResponse> get copyWith =>
      _$SwapQuoteResponseCopyWithImpl<SwapQuoteResponse>(
          this as SwapQuoteResponse, _$identity);

  /// Serializes this SwapQuoteResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapQuoteResponse &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.amountIn, amountIn) ||
                other.amountIn == amountIn) &&
            (identical(other.amountOut, amountOut) ||
                other.amountOut == amountOut) &&
            (identical(other.minOut, minOut) || other.minOut == minOut) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.approval, approval) ||
                other.approval == approval) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other.warnings, warnings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      quoteId,
      chainId,
      amountIn,
      amountOut,
      minOut,
      route,
      approval,
      expiresAt,
      const DeepCollectionEquality().hash(warnings));

  @override
  String toString() {
    return 'SwapQuoteResponse(quoteId: $quoteId, chainId: $chainId, amountIn: $amountIn, amountOut: $amountOut, minOut: $minOut, route: $route, approval: $approval, expiresAt: $expiresAt, warnings: $warnings)';
  }
}

/// @nodoc
abstract mixin class $SwapQuoteResponseCopyWith<$Res> {
  factory $SwapQuoteResponseCopyWith(
          SwapQuoteResponse value, $Res Function(SwapQuoteResponse) _then) =
      _$SwapQuoteResponseCopyWithImpl;
  @useResult
  $Res call(
      {String quoteId,
      int chainId,
      String amountIn,
      String amountOut,
      String minOut,
      SwapRoute route,
      SwapApproval approval,
      DateTime expiresAt,
      List<String> warnings});

  $SwapRouteCopyWith<$Res> get route;
  $SwapApprovalCopyWith<$Res> get approval;
}

/// @nodoc
class _$SwapQuoteResponseCopyWithImpl<$Res>
    implements $SwapQuoteResponseCopyWith<$Res> {
  _$SwapQuoteResponseCopyWithImpl(this._self, this._then);

  final SwapQuoteResponse _self;
  final $Res Function(SwapQuoteResponse) _then;

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quoteId = null,
    Object? chainId = null,
    Object? amountIn = null,
    Object? amountOut = null,
    Object? minOut = null,
    Object? route = null,
    Object? approval = null,
    Object? expiresAt = null,
    Object? warnings = null,
  }) {
    return _then(_self.copyWith(
      quoteId: null == quoteId
          ? _self.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      amountIn: null == amountIn
          ? _self.amountIn
          : amountIn // ignore: cast_nullable_to_non_nullable
              as String,
      amountOut: null == amountOut
          ? _self.amountOut
          : amountOut // ignore: cast_nullable_to_non_nullable
              as String,
      minOut: null == minOut
          ? _self.minOut
          : minOut // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _self.route
          : route // ignore: cast_nullable_to_non_nullable
              as SwapRoute,
      approval: null == approval
          ? _self.approval
          : approval // ignore: cast_nullable_to_non_nullable
              as SwapApproval,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SwapRouteCopyWith<$Res> get route {
    return $SwapRouteCopyWith<$Res>(_self.route, (value) {
      return _then(_self.copyWith(route: value));
    });
  }

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SwapApprovalCopyWith<$Res> get approval {
    return $SwapApprovalCopyWith<$Res>(_self.approval, (value) {
      return _then(_self.copyWith(approval: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SwapQuoteResponse implements SwapQuoteResponse {
  const _SwapQuoteResponse(
      {required this.quoteId,
      required this.chainId,
      required this.amountIn,
      required this.amountOut,
      required this.minOut,
      required this.route,
      required this.approval,
      required this.expiresAt,
      final List<String> warnings = const <String>[]})
      : _warnings = warnings;
  factory _SwapQuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$SwapQuoteResponseFromJson(json);

  @override
  final String quoteId;
  @override
  final int chainId;
  @override
  final String amountIn;
  @override
  final String amountOut;

  /// AmountOut after slippage protection
  @override
  final String minOut;
  @override
  final SwapRoute route;
  @override
  final SwapApproval approval;
  @override
  final DateTime expiresAt;
  final List<String> _warnings;
  @override
  @JsonKey()
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapQuoteResponseCopyWith<_SwapQuoteResponse> get copyWith =>
      __$SwapQuoteResponseCopyWithImpl<_SwapQuoteResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapQuoteResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapQuoteResponse &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.amountIn, amountIn) ||
                other.amountIn == amountIn) &&
            (identical(other.amountOut, amountOut) ||
                other.amountOut == amountOut) &&
            (identical(other.minOut, minOut) || other.minOut == minOut) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.approval, approval) ||
                other.approval == approval) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      quoteId,
      chainId,
      amountIn,
      amountOut,
      minOut,
      route,
      approval,
      expiresAt,
      const DeepCollectionEquality().hash(_warnings));

  @override
  String toString() {
    return 'SwapQuoteResponse(quoteId: $quoteId, chainId: $chainId, amountIn: $amountIn, amountOut: $amountOut, minOut: $minOut, route: $route, approval: $approval, expiresAt: $expiresAt, warnings: $warnings)';
  }
}

/// @nodoc
abstract mixin class _$SwapQuoteResponseCopyWith<$Res>
    implements $SwapQuoteResponseCopyWith<$Res> {
  factory _$SwapQuoteResponseCopyWith(
          _SwapQuoteResponse value, $Res Function(_SwapQuoteResponse) _then) =
      __$SwapQuoteResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String quoteId,
      int chainId,
      String amountIn,
      String amountOut,
      String minOut,
      SwapRoute route,
      SwapApproval approval,
      DateTime expiresAt,
      List<String> warnings});

  @override
  $SwapRouteCopyWith<$Res> get route;
  @override
  $SwapApprovalCopyWith<$Res> get approval;
}

/// @nodoc
class __$SwapQuoteResponseCopyWithImpl<$Res>
    implements _$SwapQuoteResponseCopyWith<$Res> {
  __$SwapQuoteResponseCopyWithImpl(this._self, this._then);

  final _SwapQuoteResponse _self;
  final $Res Function(_SwapQuoteResponse) _then;

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? quoteId = null,
    Object? chainId = null,
    Object? amountIn = null,
    Object? amountOut = null,
    Object? minOut = null,
    Object? route = null,
    Object? approval = null,
    Object? expiresAt = null,
    Object? warnings = null,
  }) {
    return _then(_SwapQuoteResponse(
      quoteId: null == quoteId
          ? _self.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _self.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      amountIn: null == amountIn
          ? _self.amountIn
          : amountIn // ignore: cast_nullable_to_non_nullable
              as String,
      amountOut: null == amountOut
          ? _self.amountOut
          : amountOut // ignore: cast_nullable_to_non_nullable
              as String,
      minOut: null == minOut
          ? _self.minOut
          : minOut // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _self.route
          : route // ignore: cast_nullable_to_non_nullable
              as SwapRoute,
      approval: null == approval
          ? _self.approval
          : approval // ignore: cast_nullable_to_non_nullable
              as SwapApproval,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      warnings: null == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SwapRouteCopyWith<$Res> get route {
    return $SwapRouteCopyWith<$Res>(_self.route, (value) {
      return _then(_self.copyWith(route: value));
    });
  }

  /// Create a copy of SwapQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SwapApprovalCopyWith<$Res> get approval {
    return $SwapApprovalCopyWith<$Res>(_self.approval, (value) {
      return _then(_self.copyWith(approval: value));
    });
  }
}

/// @nodoc
mixin _$EvmTxRequest {
  String get to;
  String get data;

  /// Hex or decimal string. Standardize in backend.
  String get value;

  /// Gas limit as string (avoid int overflow)
  String get gasLimit;
  TxType get type;

  /// Legacy
  String? get gasPrice;

  /// EIP-1559
  String? get maxFeePerGas;
  String? get maxPriorityFeePerGas;

  /// Create a copy of EvmTxRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EvmTxRequestCopyWith<EvmTxRequest> get copyWith =>
      _$EvmTxRequestCopyWithImpl<EvmTxRequest>(
          this as EvmTxRequest, _$identity);

  /// Serializes this EvmTxRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EvmTxRequest &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice) &&
            (identical(other.maxFeePerGas, maxFeePerGas) ||
                other.maxFeePerGas == maxFeePerGas) &&
            (identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) ||
                other.maxPriorityFeePerGas == maxPriorityFeePerGas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, to, data, value, gasLimit, type,
      gasPrice, maxFeePerGas, maxPriorityFeePerGas);

  @override
  String toString() {
    return 'EvmTxRequest(to: $to, data: $data, value: $value, gasLimit: $gasLimit, type: $type, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
  }
}

/// @nodoc
abstract mixin class $EvmTxRequestCopyWith<$Res> {
  factory $EvmTxRequestCopyWith(
          EvmTxRequest value, $Res Function(EvmTxRequest) _then) =
      _$EvmTxRequestCopyWithImpl;
  @useResult
  $Res call(
      {String to,
      String data,
      String value,
      String gasLimit,
      TxType type,
      String? gasPrice,
      String? maxFeePerGas,
      String? maxPriorityFeePerGas});
}

/// @nodoc
class _$EvmTxRequestCopyWithImpl<$Res> implements $EvmTxRequestCopyWith<$Res> {
  _$EvmTxRequestCopyWithImpl(this._self, this._then);

  final EvmTxRequest _self;
  final $Res Function(EvmTxRequest) _then;

  /// Create a copy of EvmTxRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? data = null,
    Object? value = null,
    Object? gasLimit = null,
    Object? type = null,
    Object? gasPrice = freezed,
    Object? maxFeePerGas = freezed,
    Object? maxPriorityFeePerGas = freezed,
  }) {
    return _then(_self.copyWith(
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      gasLimit: null == gasLimit
          ? _self.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as TxType,
      gasPrice: freezed == gasPrice
          ? _self.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      maxFeePerGas: freezed == maxFeePerGas
          ? _self.maxFeePerGas
          : maxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPriorityFeePerGas: freezed == maxPriorityFeePerGas
          ? _self.maxPriorityFeePerGas
          : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EvmTxRequest implements EvmTxRequest {
  const _EvmTxRequest(
      {required this.to,
      required this.data,
      required this.value,
      required this.gasLimit,
      required this.type,
      this.gasPrice,
      this.maxFeePerGas,
      this.maxPriorityFeePerGas});
  factory _EvmTxRequest.fromJson(Map<String, dynamic> json) =>
      _$EvmTxRequestFromJson(json);

  @override
  final String to;
  @override
  final String data;

  /// Hex or decimal string. Standardize in backend.
  @override
  final String value;

  /// Gas limit as string (avoid int overflow)
  @override
  final String gasLimit;
  @override
  final TxType type;

  /// Legacy
  @override
  final String? gasPrice;

  /// EIP-1559
  @override
  final String? maxFeePerGas;
  @override
  final String? maxPriorityFeePerGas;

  /// Create a copy of EvmTxRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EvmTxRequestCopyWith<_EvmTxRequest> get copyWith =>
      __$EvmTxRequestCopyWithImpl<_EvmTxRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EvmTxRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EvmTxRequest &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice) &&
            (identical(other.maxFeePerGas, maxFeePerGas) ||
                other.maxFeePerGas == maxFeePerGas) &&
            (identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) ||
                other.maxPriorityFeePerGas == maxPriorityFeePerGas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, to, data, value, gasLimit, type,
      gasPrice, maxFeePerGas, maxPriorityFeePerGas);

  @override
  String toString() {
    return 'EvmTxRequest(to: $to, data: $data, value: $value, gasLimit: $gasLimit, type: $type, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
  }
}

/// @nodoc
abstract mixin class _$EvmTxRequestCopyWith<$Res>
    implements $EvmTxRequestCopyWith<$Res> {
  factory _$EvmTxRequestCopyWith(
          _EvmTxRequest value, $Res Function(_EvmTxRequest) _then) =
      __$EvmTxRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String to,
      String data,
      String value,
      String gasLimit,
      TxType type,
      String? gasPrice,
      String? maxFeePerGas,
      String? maxPriorityFeePerGas});
}

/// @nodoc
class __$EvmTxRequestCopyWithImpl<$Res>
    implements _$EvmTxRequestCopyWith<$Res> {
  __$EvmTxRequestCopyWithImpl(this._self, this._then);

  final _EvmTxRequest _self;
  final $Res Function(_EvmTxRequest) _then;

  /// Create a copy of EvmTxRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? to = null,
    Object? data = null,
    Object? value = null,
    Object? gasLimit = null,
    Object? type = null,
    Object? gasPrice = freezed,
    Object? maxFeePerGas = freezed,
    Object? maxPriorityFeePerGas = freezed,
  }) {
    return _then(_EvmTxRequest(
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      gasLimit: null == gasLimit
          ? _self.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as TxType,
      gasPrice: freezed == gasPrice
          ? _self.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      maxFeePerGas: freezed == maxFeePerGas
          ? _self.maxFeePerGas
          : maxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPriorityFeePerGas: freezed == maxPriorityFeePerGas
          ? _self.maxPriorityFeePerGas
          : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SwapFee {
  /// Estimated network fee in wei (string)
  String get estimatedNetworkFeeWei;

  /// Create a copy of SwapFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapFeeCopyWith<SwapFee> get copyWith =>
      _$SwapFeeCopyWithImpl<SwapFee>(this as SwapFee, _$identity);

  /// Serializes this SwapFee to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapFee &&
            (identical(other.estimatedNetworkFeeWei, estimatedNetworkFeeWei) ||
                other.estimatedNetworkFeeWei == estimatedNetworkFeeWei));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, estimatedNetworkFeeWei);

  @override
  String toString() {
    return 'SwapFee(estimatedNetworkFeeWei: $estimatedNetworkFeeWei)';
  }
}

/// @nodoc
abstract mixin class $SwapFeeCopyWith<$Res> {
  factory $SwapFeeCopyWith(SwapFee value, $Res Function(SwapFee) _then) =
      _$SwapFeeCopyWithImpl;
  @useResult
  $Res call({String estimatedNetworkFeeWei});
}

/// @nodoc
class _$SwapFeeCopyWithImpl<$Res> implements $SwapFeeCopyWith<$Res> {
  _$SwapFeeCopyWithImpl(this._self, this._then);

  final SwapFee _self;
  final $Res Function(SwapFee) _then;

  /// Create a copy of SwapFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? estimatedNetworkFeeWei = null,
  }) {
    return _then(_self.copyWith(
      estimatedNetworkFeeWei: null == estimatedNetworkFeeWei
          ? _self.estimatedNetworkFeeWei
          : estimatedNetworkFeeWei // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SwapFee implements SwapFee {
  const _SwapFee({required this.estimatedNetworkFeeWei});
  factory _SwapFee.fromJson(Map<String, dynamic> json) =>
      _$SwapFeeFromJson(json);

  /// Estimated network fee in wei (string)
  @override
  final String estimatedNetworkFeeWei;

  /// Create a copy of SwapFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapFeeCopyWith<_SwapFee> get copyWith =>
      __$SwapFeeCopyWithImpl<_SwapFee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapFeeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapFee &&
            (identical(other.estimatedNetworkFeeWei, estimatedNetworkFeeWei) ||
                other.estimatedNetworkFeeWei == estimatedNetworkFeeWei));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, estimatedNetworkFeeWei);

  @override
  String toString() {
    return 'SwapFee(estimatedNetworkFeeWei: $estimatedNetworkFeeWei)';
  }
}

/// @nodoc
abstract mixin class _$SwapFeeCopyWith<$Res> implements $SwapFeeCopyWith<$Res> {
  factory _$SwapFeeCopyWith(_SwapFee value, $Res Function(_SwapFee) _then) =
      __$SwapFeeCopyWithImpl;
  @override
  @useResult
  $Res call({String estimatedNetworkFeeWei});
}

/// @nodoc
class __$SwapFeeCopyWithImpl<$Res> implements _$SwapFeeCopyWith<$Res> {
  __$SwapFeeCopyWithImpl(this._self, this._then);

  final _SwapFee _self;
  final $Res Function(_SwapFee) _then;

  /// Create a copy of SwapFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? estimatedNetworkFeeWei = null,
  }) {
    return _then(_SwapFee(
      estimatedNetworkFeeWei: null == estimatedNetworkFeeWei
          ? _self.estimatedNetworkFeeWei
          : estimatedNetworkFeeWei // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SwapBuildRequest {
  String get quoteId;

  /// The signer EOA
  String get taker;

  /// Recipient address for output tokens
  String get recipient;

  /// Create a copy of SwapBuildRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapBuildRequestCopyWith<SwapBuildRequest> get copyWith =>
      _$SwapBuildRequestCopyWithImpl<SwapBuildRequest>(
          this as SwapBuildRequest, _$identity);

  /// Serializes this SwapBuildRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapBuildRequest &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId) &&
            (identical(other.taker, taker) || other.taker == taker) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quoteId, taker, recipient);

  @override
  String toString() {
    return 'SwapBuildRequest(quoteId: $quoteId, taker: $taker, recipient: $recipient)';
  }
}

/// @nodoc
abstract mixin class $SwapBuildRequestCopyWith<$Res> {
  factory $SwapBuildRequestCopyWith(
          SwapBuildRequest value, $Res Function(SwapBuildRequest) _then) =
      _$SwapBuildRequestCopyWithImpl;
  @useResult
  $Res call({String quoteId, String taker, String recipient});
}

/// @nodoc
class _$SwapBuildRequestCopyWithImpl<$Res>
    implements $SwapBuildRequestCopyWith<$Res> {
  _$SwapBuildRequestCopyWithImpl(this._self, this._then);

  final SwapBuildRequest _self;
  final $Res Function(SwapBuildRequest) _then;

  /// Create a copy of SwapBuildRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quoteId = null,
    Object? taker = null,
    Object? recipient = null,
  }) {
    return _then(_self.copyWith(
      quoteId: null == quoteId
          ? _self.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String,
      taker: null == taker
          ? _self.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: null == recipient
          ? _self.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SwapBuildRequest implements SwapBuildRequest {
  const _SwapBuildRequest(
      {required this.quoteId, required this.taker, required this.recipient});
  factory _SwapBuildRequest.fromJson(Map<String, dynamic> json) =>
      _$SwapBuildRequestFromJson(json);

  @override
  final String quoteId;

  /// The signer EOA
  @override
  final String taker;

  /// Recipient address for output tokens
  @override
  final String recipient;

  /// Create a copy of SwapBuildRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapBuildRequestCopyWith<_SwapBuildRequest> get copyWith =>
      __$SwapBuildRequestCopyWithImpl<_SwapBuildRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapBuildRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapBuildRequest &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId) &&
            (identical(other.taker, taker) || other.taker == taker) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quoteId, taker, recipient);

  @override
  String toString() {
    return 'SwapBuildRequest(quoteId: $quoteId, taker: $taker, recipient: $recipient)';
  }
}

/// @nodoc
abstract mixin class _$SwapBuildRequestCopyWith<$Res>
    implements $SwapBuildRequestCopyWith<$Res> {
  factory _$SwapBuildRequestCopyWith(
          _SwapBuildRequest value, $Res Function(_SwapBuildRequest) _then) =
      __$SwapBuildRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String quoteId, String taker, String recipient});
}

/// @nodoc
class __$SwapBuildRequestCopyWithImpl<$Res>
    implements _$SwapBuildRequestCopyWith<$Res> {
  __$SwapBuildRequestCopyWithImpl(this._self, this._then);

  final _SwapBuildRequest _self;
  final $Res Function(_SwapBuildRequest) _then;

  /// Create a copy of SwapBuildRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? quoteId = null,
    Object? taker = null,
    Object? recipient = null,
  }) {
    return _then(_SwapBuildRequest(
      quoteId: null == quoteId
          ? _self.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String,
      taker: null == taker
          ? _self.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: null == recipient
          ? _self.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SwapBuildResponse {
  EvmTxRequest get tx;
  SwapFee get fee;

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwapBuildResponseCopyWith<SwapBuildResponse> get copyWith =>
      _$SwapBuildResponseCopyWithImpl<SwapBuildResponse>(
          this as SwapBuildResponse, _$identity);

  /// Serializes this SwapBuildResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwapBuildResponse &&
            (identical(other.tx, tx) || other.tx == tx) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tx, fee);

  @override
  String toString() {
    return 'SwapBuildResponse(tx: $tx, fee: $fee)';
  }
}

/// @nodoc
abstract mixin class $SwapBuildResponseCopyWith<$Res> {
  factory $SwapBuildResponseCopyWith(
          SwapBuildResponse value, $Res Function(SwapBuildResponse) _then) =
      _$SwapBuildResponseCopyWithImpl;
  @useResult
  $Res call({EvmTxRequest tx, SwapFee fee});

  $EvmTxRequestCopyWith<$Res> get tx;
  $SwapFeeCopyWith<$Res> get fee;
}

/// @nodoc
class _$SwapBuildResponseCopyWithImpl<$Res>
    implements $SwapBuildResponseCopyWith<$Res> {
  _$SwapBuildResponseCopyWithImpl(this._self, this._then);

  final SwapBuildResponse _self;
  final $Res Function(SwapBuildResponse) _then;

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tx = null,
    Object? fee = null,
  }) {
    return _then(_self.copyWith(
      tx: null == tx
          ? _self.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as EvmTxRequest,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as SwapFee,
    ));
  }

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EvmTxRequestCopyWith<$Res> get tx {
    return $EvmTxRequestCopyWith<$Res>(_self.tx, (value) {
      return _then(_self.copyWith(tx: value));
    });
  }

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SwapFeeCopyWith<$Res> get fee {
    return $SwapFeeCopyWith<$Res>(_self.fee, (value) {
      return _then(_self.copyWith(fee: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SwapBuildResponse implements SwapBuildResponse {
  const _SwapBuildResponse({required this.tx, required this.fee});
  factory _SwapBuildResponse.fromJson(Map<String, dynamic> json) =>
      _$SwapBuildResponseFromJson(json);

  @override
  final EvmTxRequest tx;
  @override
  final SwapFee fee;

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SwapBuildResponseCopyWith<_SwapBuildResponse> get copyWith =>
      __$SwapBuildResponseCopyWithImpl<_SwapBuildResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SwapBuildResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapBuildResponse &&
            (identical(other.tx, tx) || other.tx == tx) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tx, fee);

  @override
  String toString() {
    return 'SwapBuildResponse(tx: $tx, fee: $fee)';
  }
}

/// @nodoc
abstract mixin class _$SwapBuildResponseCopyWith<$Res>
    implements $SwapBuildResponseCopyWith<$Res> {
  factory _$SwapBuildResponseCopyWith(
          _SwapBuildResponse value, $Res Function(_SwapBuildResponse) _then) =
      __$SwapBuildResponseCopyWithImpl;
  @override
  @useResult
  $Res call({EvmTxRequest tx, SwapFee fee});

  @override
  $EvmTxRequestCopyWith<$Res> get tx;
  @override
  $SwapFeeCopyWith<$Res> get fee;
}

/// @nodoc
class __$SwapBuildResponseCopyWithImpl<$Res>
    implements _$SwapBuildResponseCopyWith<$Res> {
  __$SwapBuildResponseCopyWithImpl(this._self, this._then);

  final _SwapBuildResponse _self;
  final $Res Function(_SwapBuildResponse) _then;

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tx = null,
    Object? fee = null,
  }) {
    return _then(_SwapBuildResponse(
      tx: null == tx
          ? _self.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as EvmTxRequest,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as SwapFee,
    ));
  }

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EvmTxRequestCopyWith<$Res> get tx {
    return $EvmTxRequestCopyWith<$Res>(_self.tx, (value) {
      return _then(_self.copyWith(tx: value));
    });
  }

  /// Create a copy of SwapBuildResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SwapFeeCopyWith<$Res> get fee {
    return $SwapFeeCopyWith<$Res>(_self.fee, (value) {
      return _then(_self.copyWith(fee: value));
    });
  }
}

// dart format on
