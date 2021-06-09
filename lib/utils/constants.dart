const baseUrl = 'https://ok2code-insta-news.herokuapp.com/api';
const emptySourceUrl = 'EMPTY_SOURCE_URL';
const sourceSuspended = 'User has been suspended';
const guestLoginAlertEn =
    "Continue as a guest will make you miss your news sources in case of using the application from another phone.";
const guestLoginAlertAr =
    "لن تتمكن من استعاده المصادر الاخباريه في حاله استخدامك التطبيق من هاتف اخر او اذا قمت باعاده تبيت التطبيق.";
const guestLoginAlertEs =
    "Continuar como invitado hará que extrañe sus fuentes de noticias en caso de utilizar la aplicación desde otro teléfono.";

const adminUser = 'owner';
const normalUser = 'none';
// ignore: prefer_adjacent_string_concatenation
const twitterRegex =
    r"([#@]([a-zA-Z0-9\_]|[\u0600-\u06FF\_])+)|((https|http):\/\/+[a-zA-Z0-9.]+\/+\w+)";
