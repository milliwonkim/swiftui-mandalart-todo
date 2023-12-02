//
//  Task.swift
//  Mandarate
//
//  Created by 김기원 on 2023/12/02.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var descriptions: String = ""
    @Persisted var completed = false
}
