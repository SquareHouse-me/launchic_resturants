 
import 'package:restaurant/res/icons.dart';

class LanguageModel {
  String locale;
  String image;
  String langCode;
  String langName;
  LanguageModel({
    required this.locale,
    required this.image,
    required this.langCode,
    required this.langName,
  });
}

List<LanguageModel> langList = [
  LanguageModel(
      locale: 'en',
      image: AppIcons.flagUK,
      langCode: 'US',
      langName: 'Stay on English edition'),
  LanguageModel(
      locale: 'ar',
      image: AppIcons.flagKuwaitIcon,
      langCode: 'KW',
      langName: 'Switch to Arabic edition'),
  
];
