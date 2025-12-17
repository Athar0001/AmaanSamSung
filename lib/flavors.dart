enum Flavor {
  production(title: 'Amaan', showInProd: false),
  dev(title: 'Amaan TV Dev', showInProd: true);

  final String title;
  final bool showInProd;

  const Flavor({required this.title, required this.showInProd});
}

class AppFlavor {
  static Flavor flavor = Flavor.dev;

  static String get name => flavor.name;

  static String get title => flavor.title;

  static IFlavorData get data {
    switch (flavor) {
      case Flavor.production:
        return ProductionFlavorData();
      case Flavor.dev:
        return DevFlavorData();
    }
  }
}

abstract class IFlavorData {
  String get baseUrl;

  String get baseImageUrl;

  String get googleClientId;

  String get stripePublishableKey;

  String get twitterApiKey;
  String get twitterApiSecretKey;
  String get twitterRedirectURI;
}

class DevFlavorData extends IFlavorData {
  @override
  String get baseUrl => 'https://dev-be.amaantv.com';

  @override
  String get baseImageUrl => 'https://amaan-test.b-cdn.net/';

  @override
  String get googleClientId =>
      '63934637264-i7m1j62suomg9ju8l2493mogahf035il.apps.googleusercontent.com';

  @override
  String get stripePublishableKey =>
      'pk_test_51Q80UBCfKFjerD91dT8SrnQFWtZOYRACn4nnijszeAZ7Q48WEbL99gcce3LifMlnbAsebt4CD9nqponBLTznqQEA00oGFhujvJ';

  @override
  String get twitterApiKey => '2rt0idnjFI8RYhSxtziuNyFsX';

  @override
  String get twitterApiSecretKey =>
      'ZRwjEvEqaYLcib9IqYmAR4hfkkkLYpTBzzRKAWd5PyXs9BjbIG';
  @override
  String get twitterRedirectURI =>
      'https://amaan-dev.firebaseapp.com/__/auth/handler';
}

class ProductionFlavorData extends IFlavorData {
  @override
  String get baseUrl => 'https://be.amaantv.com';

  @override
  String get baseImageUrl => 'https://amaan.b-cdn.net/';
  @override
  String get googleClientId =>
      '407240694236-11hjsvsq8kh4f0tm9j2kariilihh8fr2.apps.googleusercontent.com';
  //TODO: add production key
  String get stripePublishableKey =>
      'pk_test_51Q80UBCfKFjerD91dT8SrnQFWtZOYRACn4nnijszeAZ7Q48WEbL99gcce3LifMlnbAsebt4CD9nqponBLTznqQEA00oGFhujvJ';

  @override
  String get twitterApiKey => '2rt0idnjFI8RYhSxtziuNyFsX';

  @override
  String get twitterApiSecretKey =>
      'ZRwjEvEqaYLcib9IqYmAR4hfkkkLYpTBzzRKAWd5PyXs9BjbIG';
  @override
  String get twitterRedirectURI =>
      'https://amaan-dev.firebaseapp.com/__/auth/handler';
}
