import 'package:logger/logger.dart';

// 전역적으로 사용할 Logger 인스턴스 생성
final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // 호출 스택을 출력하지 않음
    errorMethodCount: 5, // 에러 발생 시 호출 스택 5단계까지 출력
    lineLength: 120, // 로그 출력 시 한 줄의 길이 제한
    colors: true, // 컬러 출력
    printEmojis: true, // 이모지 출력
    printTime: true, // 시간 출력
  ),
);
