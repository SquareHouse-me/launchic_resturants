import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAQVzT7lTht0pPeik08rORDs04HjzsKG8A")
   
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)
   // copy from chat bahi
    if #available(iOS 10.0, *) {
      // Set UNUserNotificationCenter delegate to self
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
