//
//  SignUpView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 12.01.2024.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct SignUpView: View {
    
    let db = Firestore.firestore()
    
    @State var userMail = ""
    @State var password = ""
    @State var userName = ""
    @State var showAuthView = true
    
    
    var body: some View {
        
        NavigationView{
            if showAuthView{
  
                List{
                    Text("WhatsApp Clone")
                        .font(.largeTitle)
                        .bold()
               
                    Section{
                        
                        VStack(alignment: .leading){
                            SectionSubtitle2(subtitle: "User E-mail")
                                .font(.system(size: 13))
                            TextField("Please email", text: $userMail)
                            
                        }
                    }
                    
                    Section{
                        VStack(alignment: .leading){
                            SectionSubtitle2(subtitle: "Password")
                                .font(.system(size: 13))
                            SecureField("Please email", text: $password)
                            
                            
                            
                        }
                    }
                    
                    Section{
                        VStack(alignment: .leading){
                            SectionSubtitle(subtitle: "Username")
                                .font(.system(size: 13))
                            TextField("Please email", text: $userName)
                        }
                    }
                    
                    Section{
                        
                        HStack{
                            Button {
                                Auth.auth().createUser(withEmail: self.userMail, password: self.password) { result, error in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    }
                                    else
                                    {
                                        //Users Screen
                                        //Database,
                                        
                                        var ref: DocumentReference? = nil
                                        var myUserDictionary: [String:Any] = ["username": self.userName,
                                                                              "usermail": self.userMail,
                                                                              "useridfromfirabes": result!.user.uid]
                                        
                                        ref = self.db.collection("Users").addDocument(data: myUserDictionary, completion: { Error in
                                            if Error != nil {
                                                
                                            }
                                        })
                                        
                                        self.showAuthView = false
                                    }
                                }
                            }  label: {
                                Text("Sign Up")
                            }
                        
                        
                           
                        }
                    }
     
                }
            }
            else{
                NavigationView{
                    Text("hello word user view")
                }
                
            }
            
        
        }
        }
}

#Preview {
    SignUpView()
}

struct SectionSubtitle2 : View {
    
    var subtitle : String
    
    var body: some View {
        Text(subtitle).font(.subheadline).foregroundColor(.gray)
    }
}
