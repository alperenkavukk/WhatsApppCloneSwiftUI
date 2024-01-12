//
//  ChatRowView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 19.01.2024.
//

import SwiftUI
import Firebase
struct ChatRowView: View {
    
    var chatMessage : ChatModel
    var userToChatFromChatView : UserModel
    
    var body: some View {
        
        Group
        {
            if chatMessage.messageFrom == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChatFromChatView.uidFromFirebase {
                
                
                HStack{
                    Spacer()
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.green)
                        .padding(10)
                   
                    
                }
            }
            else if chatMessage.messageFrom == userToChatFromChatView.uidFromFirebase && chatMessage.messageTo == Auth.auth().currentUser!.uid
            {
                            
                            HStack{
         
                                Text(chatMessage.message)
                                    .bold()
                                    .foregroundColor(Color.blue)
                                    .padding(10)
                                
                                    Spacer()
                                
                            }
                            
                        } else {
                            //NO
                        }
                        
                        
                        
                    }.frame(width:UIScreen.main.bounds.width * 0.95)
                    
                    
                }
            }

#Preview {
    ChatRowView(chatMessage: ChatModel(id: 1, message: "alperen", messageFrom: "a", uidFromFirebase: "b", messageDate: "22.12.12", messageTo: "tr", messageFromMe: true), userToChatFromChatView: UserModel(id: 0, name: "alpere2", uidFromFirebase: "232"))
}
