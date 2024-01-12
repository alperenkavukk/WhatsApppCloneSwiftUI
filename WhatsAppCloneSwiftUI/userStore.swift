//
//  userStore.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 17.01.2024.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class UserStore : ObservableObject{
    
    let db = Firestore.firestore()
    @Published var userArray : [UserModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any> , Never>()
    
    init(){
        db.collection("Users").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else
            {
                
                self.userArray.removeAll(keepingCapacity: false)
                
                for document in  snapshot!.documents {
                    
                    if let userUidFromFirabase = document.get("useridfromfirabes") as? String {
                        
                        if let userName = document.get("username") as? String{
                            
                            let currentIndex = self.userArray.last?.id
                            
                            
                            let createUser = UserModel(id: (currentIndex ?? -1) + 1, name: userName, uidFromFirebase: userUidFromFirabase)
                            self.userArray.append(createUser)
                        }
                    }
                }
                self.objectWillChange.send(self.userArray)
            }
        }
    }
}
    

