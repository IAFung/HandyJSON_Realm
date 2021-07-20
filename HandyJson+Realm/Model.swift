//
//  File.swift
//  HandyJson+Realm
//
//  Created by feng on 2021/7/20.
//

import Foundation
import RealmSwift
import HandyJSON
typealias Base = RealmSwift.Object & HandyJSON

class Province: Base {
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
    @objc dynamic var name: String? = nil
    var schoolList = List<School>()
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            schoolList <-- RealmListTransform<School>()
    }
    required override init() {}
}

class School: Base {
    @objc dynamic var name: String? = nil
    var classList = List<Class>()
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            classList <-- RealmListTransform<Class>()
    }
    required override init() {}
}

class Class: Base {
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
    required override init() {}
}

