//
//  Book_App_extremeApp.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-26.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth



//@main
//struct Book_App_extremeApp: App {
//  // register app delegate for Firebase setup
////  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init(){
//        FirebaseApp.configure()
//    }
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//        LoginView()
//      }
//    }
//  }
//}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Book_App_extremeApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        MainView()
      }
    }
  }
}


