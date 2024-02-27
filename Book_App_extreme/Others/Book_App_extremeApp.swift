//
//  Book_App_extremeApp.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-26.
//

import SwiftUI
import FirebaseCore



@main
struct Book_App_extremeApp: App {
  // register app delegate for Firebase setup
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        MainView()
      }
    }
  }
}


