//
//  AddUserView.swift
//  MySqliteCrudAppSwiftUI
//
//  Created by user on 27/06/22.
//

import Foundation


//
//  AddUserView.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import SwiftUI
 
struct AddUserView: View {
     
    // create variables to store user input values
    @State var note: String = ""
    @State var titleNote: String = ""
     
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
         
        VStack {
            TextField("Enter Title Note", text: $titleNote)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter note", text: $note)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
             
            // button to add a user
            Button(action: {
                // call function to add row in sqlite database
                DB_Manager().addUser(noteValue: self.note, titleNoteValue: self.titleNote)
                 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
         
    }
}
