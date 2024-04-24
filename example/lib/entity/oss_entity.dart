/// accessKeyId : "STS.NSmaM8Hgc2oFvSeM6hgCQaTnv"
/// fileName : "fiele70spnevtfpkg88k747s1eqvxxqk"
/// securityToken : "CAIS/QF1q6Ft5B2yfSjIr5DYKveMpbhCha2tdHXUqTY9a8x9jpHFlDz2IHlJf3VsAuwftPoxlGlS7P4elqZUUIRsXVT+YMJ80Y5W7Q759x9RBkPyv9I+k5SANTW5KXyShb3/AYjQSNfaZY3eCTTtnTNyxr3XbCirW0ffX7SClZ9gaKZ8PGD6F00kYu1bPQx/ssQXGGLMPPK2SH7Qj3HXEVBjt3gX6wo9y9zmn5fFtUuB3ACilLNF+9utGPX+MZkwZqUYesyuwel7epDG1CNt8BVQ/M909vcdpGyb4orBWgMPvUXfabCMrscIKxRib7AiAaNNoOfmlOF1qh4kRA4NIaQnGoABjySGEwbOhl4OBo+Ju8+NYPOsCPdMe2MtGPYlcLKMVBle4XQdCfSR19i209Skx7sRGkiYJLw4PiPjZ/9WUBfqap4K8BzuCmJTcWpVXyp+OkVfuXzeGU9kZfKdINjkYkUCEk6LbSHSgKofEzcE9f/WZleArTPQgdlIhy7UsQNN/d4="
/// bucket : "zhaoyl-et-file"
/// accessKeySecret : "6eDn5MK7nEf2KQ4pFQ3oZCrPyBu1X1W1XsFFwTuvzcxz"
/// directoryPath : "/tkradar/card/20220121/"
/// region : "cn-hangzhou"

class OssEntity {
  OssEntity({
    String? accessKeyId,
    String? fileName,
    String? securityToken,
    String? bucket,
    String? accessKeySecret,
    String? directoryPath,
    String? region,
  }) {
    _accessKeyId = accessKeyId;
    _fileName = fileName;
    _securityToken = securityToken;
    _bucket = bucket;
    _accessKeySecret = accessKeySecret;
    _directoryPath = directoryPath;
    _region = region;
  }

  OssEntity.fromJson(dynamic json) {
    _accessKeyId = json['accessKeyId'];
    _fileName = json['fileName'];
    _securityToken = json['securityToken'];
    _bucket = json['bucket'];
    _accessKeySecret = json['accessKeySecret'];
    _directoryPath = json['directoryPath'];
    _region = json['region'];
  }

  String? _accessKeyId;
  String? _fileName;
  String? _securityToken;
  String? _bucket;
  String? _accessKeySecret;
  String? _directoryPath;
  String? _region;

  String? get accessKeyId => _accessKeyId;

  String? get fileName => _fileName;

  String? get securityToken => _securityToken;

  String? get bucket => _bucket;

  String? get accessKeySecret => _accessKeySecret;

  String? get directoryPath => _directoryPath;

  String? get region => _region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessKeyId'] = _accessKeyId;
    map['fileName'] = _fileName;
    map['securityToken'] = _securityToken;
    map['bucket'] = _bucket;
    map['accessKeySecret'] = _accessKeySecret;
    map['directoryPath'] = _directoryPath;
    map['region'] = _region;
    return map;
  }
}
