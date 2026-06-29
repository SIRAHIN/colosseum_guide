import 'package:colosseum_guide/feature/language_select/view_model/language_select_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStrings {
  final String next;
  final String previous;
  final String skip;
  final String startTour;
  final String explore;
  final String stop;
  final String selectLanguage;
  final String chooseLanguage;
  final String colosseumGuide;
  final String landingDescription;
  final String min;
  final String stops;
  final String tourUnavailable;
  final String letsGetStarted;
  final String yourJourneyThroughHistory;
  final String settings;
  final String viewAndEditYourProfile;
  final String preferences;
  final String language;
  final String support;
  final String contactSupport;
  final String getHelpFromOurTeam;
  final String faqs;
  final String frequentlyAskedQuestions;
  final String about;
  final String privacyPolicy;
  final String appVersion;

  const AppStrings({
    required this.next,
    required this.previous,
    required this.skip,
    required this.startTour,
    required this.explore,
    required this.stop,
    required this.selectLanguage,
    required this.chooseLanguage,
    required this.colosseumGuide,
    required this.landingDescription,
    required this.min,
    required this.stops,
    required this.tourUnavailable,
    required this.letsGetStarted,
    required this.yourJourneyThroughHistory,
    required this.settings,
    required this.viewAndEditYourProfile,
    required this.preferences,
    required this.language,
    required this.support,
    required this.contactSupport,
    required this.getHelpFromOurTeam,
    required this.faqs,
    required this.about,
    required this.frequentlyAskedQuestions,
    required this.privacyPolicy,
    required this.appVersion, 
  });
}

const _english = AppStrings(
  next: 'Next',
  previous: 'Previous',
  skip: 'Skip',
  startTour: 'Start Tour',
  explore: 'Explore',
  stop: 'Stop',
  selectLanguage: 'Select Language',
  chooseLanguage: 'Choose your preferred language',
  colosseumGuide: 'Colosseum Guide',
  landingDescription:
      'Explore the Colosseum through panoramic views and immersive audio narration. Navigate through 5 iconic stops.',
  min: 'min',
  stops: 'stops',
  tourUnavailable: 'Oops! This tour is currently unavailable.',
  letsGetStarted: "Let's Get Started",
  yourJourneyThroughHistory: 'Your journey through history',
  settings: 'Settings',
  viewAndEditYourProfile: 'View and edit your profile',
  preferences: 'Preferences',
  language: 'Language',
  support: 'Support',
  contactSupport: 'Contact Support',
  getHelpFromOurTeam: 'Get help from our team',
  faqs: 'FAQs',
  about: 'About',
  frequentlyAskedQuestions: 'Frequently asked questions',
  privacyPolicy: 'Privacy Policy',
  appVersion: 'App Version',
);

const _translations = <String, AppStrings>{
  'English': _english,
  'Italian': AppStrings(
    next: 'Avanti',
    previous: 'Precedente',
    skip: 'Salta',
    startTour: 'Inizia il Tour',
    explore: 'Esplora',
    stop: 'Tappa',
    selectLanguage: 'Seleziona Lingua',
    chooseLanguage: 'Scegli la lingua preferita',
    colosseumGuide: 'Guida del Colosseo',
    landingDescription:
        'Esplora il Colosseo attraverso viste panoramiche e narrazione audio coinvolgente. Naviga tra 5 tappe iconiche.',
    min: 'min',
    stops: 'tappe',
    tourUnavailable: 'Ops! Questo tour non è attualmente disponibile.',
    letsGetStarted: 'Iniziamo',
    yourJourneyThroughHistory: 'Il tuo viaggio attraverso la storia',
    settings: 'Impostazioni',
    viewAndEditYourProfile: 'Visualizza e modifica il tuo profilo',
    preferences: 'Preferenze',
    language: 'Lingua',
    support: 'Supporto',
    contactSupport: 'Contatta il Supporto',
    getHelpFromOurTeam: 'Ottieni aiuto dalla nostra squadra',
    faqs: 'Domande Frequenti',
    about: 'Informazioni',
    frequentlyAskedQuestions: 'Domande Frequenti',
    privacyPolicy: 'Informativa sulla Privacy',
    appVersion: 'Versione dell\'App',
  ),
  'Spanish': AppStrings(
    next: 'Siguiente',
    previous: 'Anterior',
    skip: 'Omitir',
    startTour: 'Iniciar Tour',
    explore: 'Explorar',
    stop: 'Parada',
    selectLanguage: 'Seleccionar Idioma',
    chooseLanguage: 'Elige tu idioma preferido',
    colosseumGuide: 'Guía del Coliseo',
    landingDescription:
        'Explora el Coliseo a través de vistas panorámicas y narración de audio inmersiva. Navega por 5 paradas icónicas.',
    min: 'min',
    stops: 'paradas',
    tourUnavailable: '¡Ups! Este tour no está disponible actualmente.',
    letsGetStarted: 'Comencemos',
    yourJourneyThroughHistory: 'Tu viaje a través de la historia',
    settings: 'Configuración',
    viewAndEditYourProfile: 'Ver y editar tu perfil',
    preferences: 'Preferencias',
    language: 'Idioma',
    support: 'Soporte',
    contactSupport: 'Contactar el Soporte',
    getHelpFromOurTeam: 'Obtener ayuda de nuestro equipo',
    faqs: 'Preguntas Frecuentes',
    about: 'Acerca de',
    frequentlyAskedQuestions: 'Preguntas Frecuentes',
    privacyPolicy: 'Política de Privacidad',
    appVersion: 'Versión de la App',
  ),
  'French': AppStrings(
    next: 'Suivant',
    previous: 'Précédent',
    skip: 'Passer',
    startTour: 'Commencer le Tour',
    explore: 'Explorer',
    stop: 'Arrêt',
    selectLanguage: 'Sélectionner la Langue',
    chooseLanguage: 'Choisissez votre langue préférée',
    colosseumGuide: 'Guide du Colisée',
    landingDescription:
        'Explorez le Colisée à travers des vues panoramiques et une narration audio immersive. Naviguez à travers 5 arrêts emblématiques.',
    min: 'min',
    stops: 'arrêts',
    tourUnavailable: 'Oups ! Ce tour n\'est pas disponible actuellement.',
    letsGetStarted: 'Commençons',
    yourJourneyThroughHistory: 'Votre voyage à travers l\'histoire',
    settings: 'Paramètres',
    viewAndEditYourProfile: 'Voir et modifier votre profil',
    preferences: 'Préférences',
    language: 'Langue',
    support: 'Support',
    contactSupport: 'Contacter le Support',
    getHelpFromOurTeam: 'Obtenir de l\'aide de notre équipe',
    faqs: 'FAQs',
    about: 'À propos',
    frequentlyAskedQuestions: 'Questions Fréquentes',
    privacyPolicy: 'Politique de Confidentialité',
    appVersion: 'Version de l\'App',
  ),
  'German': AppStrings(
    next: 'Weiter',
    previous: 'Zurück',
    skip: 'Überspringen',
    startTour: 'Tour Starten',
    explore: 'Entdecken',
    stop: 'Station',
    selectLanguage: 'Sprache Wählen',
    chooseLanguage: 'Wählen Sie Ihre bevorzugte Sprache',
    colosseumGuide: 'Kolosseum Guide',
    landingDescription:
        'Erkunden Sie das Kolosseum durch Panoramaansichten und immersive Audiobegleitung. Navigieren Sie durch 5 ikonische Stationen.',
    min: 'Min',
    stops: 'Stationen',
    tourUnavailable: 'Hoppla! Diese Tour ist derzeit nicht verfügbar.',
    letsGetStarted: 'Los geht\'s',
    yourJourneyThroughHistory: 'Ihr Reise durch die Geschichte',
    settings: 'Einstellungen',
    viewAndEditYourProfile: 'Ihr Profil ansehen und bearbeiten',
    preferences: 'Einstellungen',
    language: 'Sprache',
    support: 'Support',
    contactSupport: 'Kontaktiere den Support',
    getHelpFromOurTeam: 'Holen Sie sich Hilfe von unserem Team',
    faqs: 'FAQs',
    about: 'Über',
    frequentlyAskedQuestions: 'Häufig gestellte Fragen',
    privacyPolicy: 'Datenschutzrichtlinie',
    appVersion: 'App-Version',
  ),
  'Japanese': AppStrings(
    next: '次へ',
    previous: '前へ',
    skip: 'スキップ',
    startTour: 'ツアー開始',
    explore: '探索',
    stop: 'ストップ',
    selectLanguage: '言語を選択',
    chooseLanguage: 'お好みの言語を選んでください',
    colosseumGuide: 'コロッセオガイド',
    landingDescription:
        'パノラマビューと没入型オーディオナレーションでコロッセオを探索しましょう。5つの象徴的なスポットを巡ります。',
    min: '分',
    stops: 'スポット',
    tourUnavailable: 'このツアーは現在ご利用いただけません。',
    letsGetStarted: '始めましょう',
    yourJourneyThroughHistory: 'あなたの歴史の旅',
    settings: '設定',
    viewAndEditYourProfile: 'プロフィールを表示して編集',
    preferences: '設定',
    language: '言語',
    support: 'サポート',
    contactSupport: 'サポートに連絡する',
    getHelpFromOurTeam: 'チームからの支援を受ける',
    faqs: 'よくある質問',
    about: '紹介',
    frequentlyAskedQuestions: 'よくある質問',
    privacyPolicy: 'プライバシーポリシー',
    appVersion: 'アプリバージョン',
  ),
  'Chinese': AppStrings(
    next: '下一步',
    previous: '上一步',
    skip: '跳过',
    startTour: '开始游览',
    explore: '探索',
    stop: '站点',
    selectLanguage: '选择语言',
    chooseLanguage: '选择您偏好的语言', 
    colosseumGuide: '斗兽场指南',
    landingDescription: '通过全景视图和沉浸式音频讲解探索斗兽场。游览5个标志性景点。',
    min: '分钟',
    stops: '站点',
    tourUnavailable: '抱歉！该游览目前不可用。',
    letsGetStarted: '开始吧',
    yourJourneyThroughHistory: '你的历史之旅',
    settings: '设置',
    viewAndEditYourProfile: '查看和编辑您的个人资料',
    preferences: '偏好设置',
    language: '语言',
    support: '支持',
    contactSupport: '联系支持',
    getHelpFromOurTeam: '从我们的团队获得帮助',
    faqs: '常见问题',
    about: '关于',
    frequentlyAskedQuestions: '常见问题',
    privacyPolicy: '隐私政策',
    appVersion: '应用版本',
  ),
  'Turkish': AppStrings(
    next: 'İleri',
    previous: 'Geri',
    skip: 'Atla',
    startTour: 'Turu Başlat',
    explore: 'Keşfet',
    stop: 'Durak',
    selectLanguage: 'Dil Seçin',
    chooseLanguage: 'Tercih ettiğiniz dili seçin',
    colosseumGuide: 'Kolezyum Rehberi',
    landingDescription:
        'Panoramik manzaralar ve sürükleyici sesli anlatımla Kolezyum\'u keşfedin. 5 ikonik durağı gezin.',
    min: 'dk',
    stops: 'durak',
    tourUnavailable: 'Hay aksi! Bu tur şu anda mevcut değil.',
    letsGetStarted: 'Başlayalım',
    yourJourneyThroughHistory: 'Türkçe tarihi yolculuğu',
    settings: 'Ayarlar',
    viewAndEditYourProfile: 'Profilinizi görüntüleyin ve düzenleyin',
    preferences: 'Tercihler',
    language: 'Dil',
    support: 'Destek',
    contactSupport: 'Destek Al',
    getHelpFromOurTeam: 'Ekipimize yardım alın',
    faqs: 'SSS',
    about: 'Hakkında',
    frequentlyAskedQuestions: 'Sıkça Sorulan Sorular',
    privacyPolicy: 'Gizlilik Politikası',
    appVersion: 'Uygulama Sürümü',
  ),
};

final appStringsProvider = Provider<AppStrings>((ref) {
  // Keep the provider alive
  ref.keepAlive();
  final language = ref.watch(languageSelectViewModelProvider).selectedLanguage;
  return _translations[language] ?? _english;
});
