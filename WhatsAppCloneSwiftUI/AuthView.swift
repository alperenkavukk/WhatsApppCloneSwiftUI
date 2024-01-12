//
//  ContentView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Alperen Kavuk on 12.01.2024.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore


struct AuthView: View {
    
    let db = Firestore.firestore()
    @ObservedObject var userStore = UserStore()
    
    @State var userMail = ""
    @State var password = ""
    @State var userName = ""
    @State var showAuthView = true
    @State var SignUpView = false
    
    var body: some View {
        
        NavigationView{
            
            if showAuthView{
                
                List{
                    Text("WhatsApp Clone")
                        .font(.largeTitle)
                        .bold()
                    
                    Section{
                        
                        VStack(alignment: .leading){
                            SectionSubtitle(subtitle: "User E-mail")
                                .font(.system(size: 13))
                            TextField("Please email", text: $userMail)
                            
                        }
                    }
                    
                    Section{
                        VStack(alignment: .leading){
                            SectionSubtitle(subtitle: "Password")
                                .font(.system(size: 13))
                            SecureField("Please email", text: $password)
                            
                            
                            
                        }
                    }
                    
                    
                        Button {
                            Auth.auth().signIn(withEmail: self.userMail, password: self.password) { eesult, error in
                                if error != nil {
                                    print(error?.localizedDescription)
                                }else{
                                    self.showAuthView = false
                                }
                            }
                            
                        } label: {
                            Text("Sign In")
                        }
                        
                       
                    Section{
                        
                        HStack{
                            
                           
                            Spacer()
                            
                            NavigationLink(destination: WhatsAppCloneSwiftUI.SignUpView()) {
                                Text("Don't you have an account? Do you want to register?")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                        
        }
                
                
                
            
        }
        else{
            NavigationView {
                VStack {
                    List(userStore.userArray) { user in
                        NavigationLink {
                            ChatViw(userToChat: user)
                        } label: {
                            Text(user.name)
                        }
                    }
                    
                    HStack {
                        Spacer() 
                        Button {
                            do {
                                try Auth.auth().signOut()
                            } catch {
                                
                            }
                            self.showAuthView = true
                        } label: {
                            VStack {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                Text("Log Out")
                            }
                            Spacer()
                        }
                        
                    }
                }
            }            .navigationBarTitle(Text("Whatsapp"))
            
                .navigationBarItems(trailing: Button(action: {
                    
                    
                }, label: {
                   
                    
                }))



            }
            
        }
        
    }
    }


#Preview {
    Group{
      //  AuthView(showAuthView: true)
        AuthView(showAuthView: false)
    }
    
}


struct SectionSubtitle : View {
    
    var subtitle : String
    
    var body: some View {
        Text(subtitle).font(.subheadline).foregroundColor(.gray)
    }
}
