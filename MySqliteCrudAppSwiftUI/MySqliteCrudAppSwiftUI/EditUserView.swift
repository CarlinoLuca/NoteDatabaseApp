//
//  EditUserView.swift
//  Pods
//
//  Created by user on 27/06/22.

//@Binding is used when you want to pass the value from one view to another. In that case, if you are using preview provider, then you have to create the @State variable in it.
//

import Foundation
import SwiftUI
 
struct EditUserView: View {
     
    // id receiving of user from previous view
    @Binding var id: Int64
     
    // variables to store value from input fields
    //@State var name: String = ""
    //@State var email: String = ""
    //@State var age: String = ""
    
    @State var note: String = ""
    @State var titleNote: String = ""
     
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        VStack {
            // create name field
            
            TextField("Enter title note", text: $titleNote)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter note", text: $note)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            // button to update user
            Button(action: {
                // call function to update row in sqlite database
                DB_Manager().updateUser(idValue: self.id, noteValue: self.note, titleNoteValue: self.titleNote)
 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
 
        // populate user's data in fields when view loaded
        .onAppear(perform: {
             
            // get data from database
            let userModel: UserModel = DB_Manager().getUser(idValue: self.id)
            self.note = userModel.note
        })
    }
}
 
struct EditUserView_Previews: PreviewProvider {
     
    // when using @Binding, do this in preview provider
    @State static var id: Int64 = 0
     
    static var previews: some View {
        EditUserView(id: $id)
    }
}
