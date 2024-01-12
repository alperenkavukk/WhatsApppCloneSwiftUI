//
//  chatModel.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 19.01.2024.
//

import SwiftUI

struct ChatModel : Identifiable {
    
    var id : Int
    var message: String
    var messageFrom : String
    var uidFromFirebase : String
    var messageDate : String
    var messageTo : String
    var messageFromMe : Bool
    
}


