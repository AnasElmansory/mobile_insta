const baseUrl = 'https://ok2code-insta-news.herokuapp.com/api';
const emptySourceUrl = 'EMPTY_SOURCE_URL';
const sourceSuspended = 'User has been suspended';
const guestLoginAlertEn =
    "Continue as a guest will make you miss your news sources in case of using the application from another phone.";
const guestLoginAlertAr =
    "لن تتمكن من استعاده المصادر الاخباريه في حاله استخدامك التطبيق من هاتف اخر او اذا قمت باعاده تبيت التطبيق.";
const guestLoginAlertEs =
    "Continuar como invitado hará que extrañe sus fuentes de noticias en caso de utilizar la aplicación desde otro teléfono.";

const emptyWidgetTextEn =
    "This is the best place to see the latest news from favorite sources, So let's find some sources to follow.";
const emptyWidgetTextAr =
    "هذا هو أفضل مكان لمشاهدة آخر الأخبار من المصادر المفضلة ، لذلك دعونا نجد بعض المصادر للمتابعة.";
const emptyWidgetTextEs =
    "Este es el mejor lugar para ver las últimas noticias de las fuentes favoritas, así que busquemos algunas fuentes para seguir.";

const permissions = ['user', 'editor', 'owner'];
const twitterRegex =
    r"([#@]([a-zA-Z0-9\_]|[\u0600-\u06FF\_])+)|((https|http):\/\/+[a-zA-Z0-9.]+\/+\w+)";
const twitterUrlRegex = r"((https|http):\/\/+[a-zA-Z0-9.]+\/+\w+)";
const kSnackBarDuration = Duration(seconds: 3);
