//
//  File.swift
//  HandyJson+Realm
//
//  Created by feng on 2021/7/20.
//

import Foundation
import RealmSwift
import HandyJSON
typealias Base = RealmSwift.Object & HandyJSON & CascadingDeletable


class Province: Base {
    static var propertiesToCascadeDelete: [String] = ["cityList"]
    
    @objc dynamic var name: String? = nil
    @objc dynamic var id: String? = nil
    
    var desc: String? = nil
    var newName: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    var cityList = List<City>()
    
    required override init() {}
    override class func ignoredProperties() -> [String] {
        return ["newName"]
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            cityList <-- RealmListTransform<City>()
        
        mapper <<<
            desc <-- "description"
    }
    func didFinishMapping() {
        self.name = newName
    }
    
}

class City: Base {
    static var propertiesToCascadeDelete: [String] = ["schoolList", "distinguish"]
    @objc dynamic var name: String? = nil
    @objc dynamic var distinguish: Distinguish?
    var schoolList = List<School>()
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            schoolList <-- RealmListTransform<School>()
    }
    required override init() {}
}

class School: Base {
    static var propertiesToCascadeDelete: [String] = ["classList"]
    @objc dynamic var name: String? = nil
    var classList = List<Class>()
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            classList <-- RealmListTransform<Class>()
    }
    required override init() {}
}

class Class: Base {
    static var propertiesToCascadeDelete: [String] = ["studentList"]

    @objc dynamic var name: String? = nil
    var studentList = List<Student>()
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            studentList <-- RealmListTransform<Student>()
    }
    required override init() {}
}

class Student: Base {
    @objc dynamic var name: String? = nil
    @objc dynamic var ID: String? = nil
//    override class func primaryKey() -> String? {
//        return "ID"
//    }
    required override init() {}
}


class Distinguish: Base {
    @objc dynamic var name: String? = nil
    required override init() {}
}
