class AuthService {
  static String? _token;
  static bool _seenOnboarding = false;
  static DateTime? _lastActivity;

  // =========================
  // 🔐 AUTH
  // =========================
  static bool get isLoggedIn => _token != null;

  static void login(String token) {
    _token = token;
    _updateActivity();
  }

  static void logout() {
    _token = null;
  }

  // =========================
  // 🧠 ONBOARDING
  // =========================
  static bool get hasSeenOnboarding => _seenOnboarding;

  static void completeOnboarding() {
    _seenOnboarding = true;
  }

  // =========================
  // ⏱️ INATIVIDADE
  // =========================
  static void _updateActivity() {
    _lastActivity = DateTime.now();
  }

  static void registerActivity() {
    _updateActivity();
  }

  static bool isSessionExpired() {
    if (_lastActivity == null) return false;

    final now = DateTime.now();
    return now.difference(_lastActivity!).inMinutes > 30;
  }

  static void checkSession() {
    if (isSessionExpired()) {
      logout();
    }
  }
}