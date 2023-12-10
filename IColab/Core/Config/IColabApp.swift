//
//  IColabApp.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 7/30/23.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
    return true
  }
}

@main
struct IColabApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        Mock.init()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
