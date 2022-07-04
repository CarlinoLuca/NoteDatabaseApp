//
//  UserModel.swift
//  MySqliteCrudAppSwiftUI
//
//  Created by user on 27/06/22.
//

import Foundation

/**
    Classe Pojo
    Your model class must conform to Identifiable protocol in order to show the users in List view.
 */
class UserModel: Identifiable {
    public var id: Int64 = 0
    public var note: String = ""
    public var titleNote: String = ""
}
