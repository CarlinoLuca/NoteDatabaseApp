//
//  DB_Manager.swift
//  MySqliteCrudAppSwiftUI
//
//  Created by user on 27/06/22.
//

import Foundation
import SQLite


class DB_Manager {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var users: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var note: Expression<String>!
    private var titleNote: Expression<String>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
             
            // creating table object
            users = Table("users")
             
            // create instances of each column
            id = Expression<Int64>("id")
            note = Expression<String>("note")
            titleNote = Expression<String>("titleNote")
             
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
 
                // if not, then create the table
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(note)
                    t.column(titleNote)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    public func addUser(noteValue: String, titleNoteValue: String) {
        do {
            try db.run(users.insert(note <- noteValue, titleNote <- titleNoteValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of user models
    public func getUsers() -> [UserModel] {
         
        // create empty array
        var userModels: [UserModel] = []
     
        // get all users in descending order
        users = users.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(users) {
     
                // create new model in each loop iteration
                let userModel: UserModel = UserModel()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.note = user[note]
                userModel.titleNote = user[titleNote]
     
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }
    
    // get single user data
    public func getUser(idValue: Int64) -> UserModel {
     
        // create an empty object
        let userModel: UserModel = UserModel()
         
        // exception handling
        do {
     
            // get user using ID
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))
     
            // get row
            try user.forEach({ (rowValue) in
     
                // set values in model
                userModel.id = try rowValue.get(id)
                userModel.note = try rowValue.get(note)
                userModel.titleNote = try rowValue.get(titleNote)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return userModel
    }
    
    
    
    // function to update user
    public func updateUser(idValue: Int64, noteValue: String, titleNoteValue: String) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
            try db.run(user.update(note <- noteValue, titleNote <- titleNoteValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
 
  
        
    // function to delete user
    public func deleteUser(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}
