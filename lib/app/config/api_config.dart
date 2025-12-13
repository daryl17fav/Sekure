/// API Configuration
/// 
/// Update these values based on your environment

class ApiConfig {
  // Development URL (local network)
  static const String devBaseUrl = "http://192.168.43.164:3000/api";
  
  // Production URL (update when deploying)
  static const String prodBaseUrl = "https://your-production-url.com/api";
  
  // Current environment
  static const bool isProduction = false;
  
  // Get the appropriate base URL
  static String get baseUrl => isProduction ? prodBaseUrl : devBaseUrl;
  
  // ========================================
  // API ENDPOINTS
  // ========================================
  
  // AUTH ENDPOINTS
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String registerSeller = "auth/register/seller";
  static const String logout = "auth/logout";
  static const String me = "auth/me";
  static const String forgotPassword = "auth/forgot-password";
  static const String verifyOtp = "auth/verify-otp";
  static const String resendOtp = "auth/resend-otp";
  
  // DASHBOARD ENDPOINTS
  static const String dashboardStats = "dashboard/stats";
  
  // DISPUTES ENDPOINTS
  static const String disputes = "disputes";
  static String disputeById(String id) => "disputes/$id";
  static String disputeResolve(String id) => "disputes/$id/resolve";
  static String disputeRespond(String id) => "disputes/$id/respond";
  
  // LOYALTY ENDPOINTS
  static const String loyaltyHistory = "loyalty/history";
  static const String loyaltyPoints = "loyalty/points";
  static const String loyaltyRewards = "loyalty/rewards";
  
  // ORDERS ENDPOINTS
  static const String orders = "orders";
  static String orderById(String id) => "orders/$id";
  static String orderDispute(String id) => "orders/$id/dispute";
  static String orderTimeline(String id) => "orders/$id/timeline";
  static String orderValidate(String id) => "orders/$id/validate";
  
  // PAYMENTS ENDPOINTS
  static const String paymentsSimulate = "payments/simulate";
  static const String paymentsWebhook = "payments/webhook";
  
  // PURCHASE ORDERS ENDPOINTS
  static const String purchaseOrders = "purchase-orders";
  static String purchaseOrderById(String id) => "purchase-orders/$id";
  static String purchaseOrderAccept(String id) => "purchase-orders/$id/accept";
  static String purchaseOrderPayment(String id) => "purchase-orders/$id/payment";
  
  // QUOTES ENDPOINTS
  static const String quotes = "quotes";
  static String quoteById(String id) => "quotes/$id";
  static String quotePayment(String id) => "quotes/$id/payment";
  static String quoteByCode(String code) => "quotes/code/$code";
  
  // SETTINGS ENDPOINTS
  static const String settings = "settings";
  static const String settingsUpload = "settings/upload";
  
  // SHIPMENTS ENDPOINTS
  static const String shipments = "shipments";
  static String shipmentById(String id) => "shipments/$id";
  
  // USERS ENDPOINTS
  static const String users = "users";
  static String userById(String id) => "users/$id";
}
