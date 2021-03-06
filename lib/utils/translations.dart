import 'package:get/get.dart';

import 'constants.dart';

class InstaTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => const {
        'en_US': {
          'accept': 'Accept',
          'about': 'About Us',
          'settings': 'Settings',
          'app_version': 'Application Version',
          'login': 'Login',
          'logout': 'Log Out',
          'privacy_policy': 'Privacy Policy',
          'terms_conditions': 'Terms And Conditions',
          'language': 'Application Language',
          'font_size': 'Font Size',
          'current_version': 'Current Version',
          'notifications': 'Notifications',
          'on': 'On',
          'off': 'Off',
          'small': 'Small',
          'medium': 'Medium',
          'large': 'Large',
          'share': 'Share Application',
          'menu': 'Menu',
          'home': 'Home',
          'favorite': 'Favorites',
          'sources': 'Sources',
          'save_continue': 'Save And Continue',
          'countries': 'Countries',
          'search_country': 'Select Countries That You Are Interested In',
          'guset_login': 'Skip Login And Continue As a Guest',
          'google_login': 'Login With Google Account',
          'facebook_login': 'Login With Facebook Account',
          'guset_login_alert': guestLoginAlertEn,
          'cancel': 'Cancel',
          'continue': 'Continue',
          'mute_notification': 'Mute Notifications',
          'enable_notification': 'Enable Notification',
          'mark_as_read': 'Mark All As Read',
          'year': 'year',
          'months': 'month(s)',
          'day': 'd',
          'hour': 'h',
          'min': 'm',
          'sec': 's',
          'unfollow': 'Unfollow',
          'follow': 'Follow',
          'save': 'Save',
          'fav_add_failed': 'Something Went Wrong. Please Try Again!',
          'fav_add_success': 'News is Added To Favourites Successfully',
          "fav_remove_failed": 'Something Went Wrong. Please Try Again!',
          "fav_remove_success": 'News is removed from Favourites Successfully',
          'fav_with_guest': 'please sign-in first to see your favorite list',
          'favorite_news': 'Favorite News',
          'search_for_favorite_news': 'Search For Favorite News',
          'empty_widget_text': emptyWidgetTextEn,
          'welcome_to_insta': "Welcome to INSTA news!",
          'search_country_hint': 'Search Countries',
          'search_source_hint': 'Search Sources',
          'search_news_hint': 'Search News',
          'search_favorite_news_hint': 'Search Favorite News',
        },
        'ar_EG': {
          'accept': 'موافق',
          'about': 'نبذة عنا',
          'settings': 'الاعدادات',
          'app_version': 'نسخة التطبيق',
          'login': 'تسجيل دخول',
          'logout': 'تسجيل خروج',
          'privacy_policy': 'سياسه الخصوصية',
          'terms_conditions': 'الشروط والأحكام',
          'language': 'اللغة',
          'font_size': 'حجم الخط',
          'current_version': 'النسخه الحالية',
          'notifications': 'الاشعارات',
          'on': 'تشغيل',
          'off': 'ايقاف',
          'small': 'صغير',
          'medium': 'متوسط',
          'large': 'كبير',
          'share': 'مشاركه التطبيق',
          'menu': 'القائمة',
          'home': 'الرئيسية',
          'favorite': 'المفضلة',
          'sources': 'المصادر',
          'save_continue': 'حفظ واستمرار',
          'countries': 'الدول',
          'search_country': 'اختر الدول التي تود متابعة اخبارها',
          'guset_login': 'تخطي تسجيل الدخول المتابعه كزائر',
          'google_login': 'تسجيل الخول بحساب جوجل',
          'facebook_login': 'تسجيل الخول بحساب فيس بوك',
          'guset_login_alert': guestLoginAlertAr,
          'cancel': 'إلغاء',
          'continue': 'إستمرار',
          'mute_notification': 'كتم الإشعارات',
          'enable_notification': 'تفعيل الإشعارات',
          'mark_as_read': 'تحديد كمقروء',
          'year': 'سنه',
          'months': 'شهر',
          'day': 'ي',
          'hour': 'س',
          'min': 'د',
          'sec': 'ث',
          'unfollow': 'إلغاء المتابعة',
          'follow': 'متابعة',
          'save': 'حفظ',
          'fav_add_failed': 'هناك خطأ ما. حاول مرة اخرى!',
          'fav_add_success': 'تمت إضافة الخبر إلى المفضلة بنجاح',
          "fav_remove_failed": 'هناك خطأ ما. حاول مرة اخرى!',
          "fav_remove_success": 'تمت إزالة الخبر من المفضلة بنجاح',
          'fav_with_guest':
              'الرجاء تسجيل الدخول أولاً لرؤية قائمة المفضلة لديك!',
          'favorite_news': 'الاخبار المفضلة',
          'search_for_favorite_news': 'البحث عن خبر',
          'empty_widget_text': emptyWidgetTextAr,
          'welcome_to_insta': "مرحبا بكم في INSTA news",
          'search_country_hint': 'ابحث عن دولة',
          'search_source_hint': 'ابحث عن مصدر',
          'search_news_hint': 'ابحث عن خبر',
          'search_favorite_news_hint': 'ابحث في الاخبار المفضلة',
        },
        // 'es_MX': {
        //   'about': 'Sobre nosotros',
        //   'settings': 'Ajustes',
        //   'app_version': 'Versión de la Aplicación',
        //   'login': 'iniciar sesión',
        //   'logout': 'Cerrar sesión',
        //   'privacy_policy': 'Política de Privacidad',
        //   'terms_conditions': 'Términos y Condiciones',
        //   'language': 'Lenguaje de Aplicación',
        //   'font_size': 'Tamaño de Fuente',
        //   'current_version': 'Versión actual',
        //   'notifications': 'Notificaciones',
        //   'on': 'encender',
        //   'off': 'apagar',
        //   'small': 'pequeña',
        //   'medium': 'Medio',
        //   'large': 'Grande',
        //   'share': 'Compartir Aplicación',
        //   'menu': 'menú',
        //   'home': 'Principal',
        //   'favourite': 'Favoritos',
        //   'sources': 'Fuentes',
        //   'save_continue': 'Guardar y Continuar',
        //   'countries': 'Los Países',
        //   'search_country': 'Seleccione los países que le interesan',
        //   'guset_login': 'Saltar Iniciar sesión y continuar como invitado(a).',
        //   'google_login': 'Inicie sesión con una cuenta de Google ',
        //   'facebook_login': 'Inicie sesión con una cuenta de Facebook.',
        //   'guset_login_alert': guestLoginAlertEs,
        //   'cancel': 'Cancelar',
        //   'continue': 'Continuar',
        //   'mute_notification': 'Silenciar Notificaciones',
        //   'enable_notification': 'Permitir Notificaciones',
        //   'mark_as_read': 'Marcar Todo Como Leido',
        //   'year': 'año',
        //   'months': 'mes(es)',
        //   'day': 'd',
        //   'hour': 'h',
        //   'min': 'm',
        //   'sec': 's',
        //   'unfollow': 'Dejar de Seguir',
        //   'follow': 'Seguir',
        //   'save': 'Guardar',
        //   'fav_add_failed': 'Algo salió mal. ¡Inténtalo de nuevo!',
        //   'fav_add_success': 'Las noticias se agregan a favoritos con éxito',
        //   "fav_remove_failed": 'Algo salió mal. ¡Inténtalo de nuevo!',
        //   "fav_remove_success":
        //       'Las noticias se han eliminado de los favoritos con éxito',
        //   'fav_with_guest':
        //       'Por Favor inicie sesión primero para ver su lista de favoritos',
        //   'favorite_news': 'Las Noticias Favoritas',
        //   'search_for_favorite_news': 'Buscar noticias favoritas',
        //   'empty_widget_text': emptyWidgetTextEs,
        //   'welcome_to_insta': 'Bienvenido a INSTA News!',
        //   'search_country_hint': 'Buscar Los Países',
        //   'search_source_hint': 'Buscar las fuentes',
        //   'search_news_hint': 'Buscar las noticias',
        //   'search_favorite_news_hint': 'Buscar Noticias Favoritas',
        // },
      };
}
