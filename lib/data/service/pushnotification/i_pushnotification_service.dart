abstract class IPushnotificationService {
  Future<void> initializeFirebase();
  Future<void> setupInteractedMessage();
  Future<void> registerNotificationListeners();
  Future<void> getToken();
}
