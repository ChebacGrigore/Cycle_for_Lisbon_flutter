import 'package:i18n_extension/i18n_extension.dart';

const welcomeSplash = "welcomeSplash";
//onboard
const welcomeOnboard = "welcomeOnboard";
const welcomeOnboardDesc = "welcomOnboarDesc";

const supportInitiativeOnboard = "supportInitiativeOnboard";
const supportInitiativeOnboardDesc = "supportInitiativeOnboardDesc";

const signIn = "signIn";
const singUp = "singUp";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    welcomeSplash: {
      "en_us":
          "Welcome to Cycle for Lisbon! Get to know the city in the 2 wheels and help the community.",
      "pt_br":
          "Bem-vindo ao Cycle for Lisbon! Conheça a cidade em duas rodas e ajude a comunidade.",
    },
    singUp: {
      "en_us": "Sign Up",
      "pt_br": "Criar conta",
    },
    signIn: {
      "en_us": "Sign In",
      "pt_br": "Entrar",
    },
    welcomeOnboard: {
      "en_us": "Welcome to Cycle for Lisbon",
      "pt_br": "Bem-vindo ao Cycle for Lisbon",
    },
    welcomeOnboardDesc: {
      "en_us":
          "Get ready to explore the city of Lisbon on two wheels while making a positive impact on NGO initiatives.",
      "pt_br":
          "Prepare-se para explorar a cidade de Lisboa em duas rodas enquanto tem um impacto positivo em iniciativas de ONGs."
    },
    supportInitiativeOnboard: {
      "en_us": "Support an Initiative",
      "pt_br": "Apoie uma Iniciativa"
    },
    supportInitiativeOnboardDesc: {
      "en_us":
          "Choose the initiative you want to support and learn more about its goal and promoters.",
      "pt_br":
          "Escolha a iniciativa que pretende apoiar e saiba mais sobre o seu objetivo e os seus promotores."
    },
  });

  String get i18n => localize(this, _t);
}
