//
//  chatStore.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 19.01.2024.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class chatStore : ObservableObject {
    
    let db = Firestore.firestore()
    var chatArray : [ChatModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>, Never>()
    
    
    init(){
        
        db.collection("Chats").whereField("chatUserFrom", isEqualTo:  Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else
            {
                self.chatArray.removeAll(keepingCapacity: false )
                
                for document in snapshot!.documents {
                    
                    let chatUidfromFirebase = document.documentID
                    
                    if let chatMessage = document.get("message") as? String {
                        if let messageFrom = document.get("chatUserFrom") as? String {
                            if let messageTo = document.get("chatUserTo") as? String {
                                if let dataString = document.get("date") as? String {
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    let dateFromDb = dateFormatter.date(from: dataString)
                                    
                                    let currentIndex = self.chatArray.last?.id
                                    
                                    let createChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, messageFrom: messageFrom, uidFromFirebase: chatUidfromFirebase, messageDate: dataString, messageTo: messageTo, messageFromMe: true)
                                
                                    self.chatArray.append(createChat)
                                    
                                }
                            }
                        }
                    }
                }
                
                self.db.collection("Chats").whereField("chatUserTo", isEqualTo:  Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                    else
                    {
                        
                        
                        for document in snapshot!.documents {
                            
                            let chatUidfromFirebase = document.documentID
                            
                            if let chatMessage = document.get("message") as? String {
                                if let messageFrom = document.get("chatUserFrom") as? String {
                                    if let messageTo = document.get("chatUserTo") as? String {
                                        if let dataString = document.get("date") as? String {
                                            
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                            let dateFromDb = dateFormatter.date(from: dataString)
                                            
                                            let currentIndex = self.chatArray.last?.id
                                            
                                            let createChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, messageFrom: messageFrom, uidFromFirebase: chatUidfromFirebase, messageDate: dataString, messageTo: messageTo, messageFromMe: true)
                                        
                                            self.chatArray.append(createChat)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        self.chatArray = self.chatArray.sorted(by: {
                            $0.messageDate.compare($1.messageDate) == .orderedAscending
                        })
                        self.objectWillChange.send(self.chatArray)
                    }
                    
                }
            }
        }
    }
        
    
}

