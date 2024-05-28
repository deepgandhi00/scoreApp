// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TeamModel> _$teamModelSerializer = new _$TeamModelSerializer();

class _$TeamModelSerializer implements StructuredSerializer<TeamModel> {
  @override
  final Iterable<Type> types = const [TeamModel, _$TeamModel];
  @override
  final String wireName = 'TeamModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TeamModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.teamId;
    if (value != null) {
      result
        ..add('teamId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.logo;
    if (value != null) {
      result
        ..add('logo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TeamModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TeamModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'teamId':
          result.teamId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'logo':
          result.logo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TeamModel extends TeamModel {
  @override
  final int? teamId;
  @override
  final String? logo;
  @override
  final String name;

  factory _$TeamModel([void Function(TeamModelBuilder)? updates]) =>
      (new TeamModelBuilder()..update(updates))._build();

  _$TeamModel._({this.teamId, this.logo, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'TeamModel', 'name');
  }

  @override
  TeamModel rebuild(void Function(TeamModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeamModelBuilder toBuilder() => new TeamModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeamModel &&
        teamId == other.teamId &&
        logo == other.logo &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, teamId.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeamModel')
          ..add('teamId', teamId)
          ..add('logo', logo)
          ..add('name', name))
        .toString();
  }
}

class TeamModelBuilder implements Builder<TeamModel, TeamModelBuilder> {
  _$TeamModel? _$v;

  int? _teamId;
  int? get teamId => _$this._teamId;
  set teamId(int? teamId) => _$this._teamId = teamId;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeamModelBuilder();

  TeamModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _teamId = $v.teamId;
      _logo = $v.logo;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeamModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TeamModel;
  }

  @override
  void update(void Function(TeamModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeamModel build() => _build();

  _$TeamModel _build() {
    final _$result = _$v ??
        new _$TeamModel._(
            teamId: teamId,
            logo: logo,
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TeamModel', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
