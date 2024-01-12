//
//  WhatsAppCloneSwiftUIApp.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 12.01.2024.
//

import SwiftUI
import Firebase

@main
struct WhatsAppCloneSwiftUIApp: App {
    init() {
      FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}

