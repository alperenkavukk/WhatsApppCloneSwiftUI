//
//  ChatViw.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 17.01.2024.
//

import SwiftUI
import Firebase
struct ChatViw: View {
    
    var userToChat: UserModel
    let db = Firestore.firestore()
    @ObservedObject var chatstore = chatStore()
    
    @State var messageToSend = ""
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                ScrollView{
                    ForEach(chatstore.chatArray){ chats in
                        ChatRowView(chatMessage: chats, userToChatFromChatView: self.userToChat)
                        
                    }
                
                }
               
                
                HStack{
                   
                    TextField("message here.. ", text: $messageToSend).frame(minHeight: 50).padding()
                    Button {
                        sendMessageToFirebase()
                    } label: {
                        Text("Send")
                    }.frame(minHeight: 50)
                        .padding()

                }
            }
        }.navigationBarTitle(Text(userToChat.name), displayMode: .inline)
    }
    func sendMessageToFirebase(){
        
        var ref: DocumentReference? = nil
        let myChatDictinoary : [String: Any] = ["chatUserFrom": Auth.auth().currentUser?.uid, "chatUserTo": userToChat.uidFromFirebase, "date": generateDate(), "message": self.messageToSend]
        ref = self.db.collection("Chats").addDocument(data: myChatDictinoary , completion: { error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else
            {
                self.messageToSend = ""
            }
            
        })
        
    }
    func generateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return(formatter.string(from: Date()) as NSString) as String
    }
}

#Preview {
    ChatViw(userToChat: UserModel(id: 0, name: "alpern", uidFromFirebase: "123"))
}
