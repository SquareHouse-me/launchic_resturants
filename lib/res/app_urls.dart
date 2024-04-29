String baseUrl = 'https://lunchic.co/api/';
String versionApi = 'v1/';
String route = 'restaurant/';
String loginApi = baseUrl + versionApi + route + "login";

String forgotPasswordApi = baseUrl + versionApi + route + "forgot-password";
String resetPasswordApi = baseUrl + versionApi + route + "reset-password";
String resendCodeApi = baseUrl + versionApi + route + "resend-code";
String logoutApi = baseUrl + versionApi + route + "logout";
String ProfileUpdateApi = baseUrl + versionApi + route + "profile/update";
String ProfileUpdatePasswordApi =
    baseUrl + versionApi + route + "profile/update-password";
// String getAllRestaurantsApi = baseUrl + versionApi+route + "restaurants";
// String detailApi = getAllRestaurantsApi + '/';
String getAllReservations = baseUrl + versionApi + route + "reservations";
String pastApprovedReservationsApi =
    baseUrl + versionApi + route + "past-reservations";
String pastCancelledReservationsApi =
    baseUrl + versionApi + route + 'past-cancelled-reservations';
String googleMapApi = "AIzaSyAQVzT7lTht0pPeik08rORDs04HjzsKG8A";

String bookReservationApi = baseUrl + versionApi + route + 'book-reservation';
String contactUsApi = baseUrl + versionApi + 'contact-us';
String saveDeviceTokenAPI = baseUrl + versionApi + route + 'save-token';
String updateForceFullyApi = baseUrl + versionApi + 'check-update';
String phoneNumbersApi = baseUrl + versionApi + "phone-numbers";
