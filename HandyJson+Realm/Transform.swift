//
//  HandyJSONTransform.swift
//  HandyJSONRealmDemo
//
//  Created by Yongle Fu on 2019/3/15.
//  Copyright © 2019 XXX. All rights reserved.
//

import HandyJSON
import RealmSwift

struct RealmListTransform<T: RealmSwift.Object>: TransformType where T: HandyJSON {
    
    public typealias Serialize = (List<T>) -> ()
        private let onSerialize: Serialize
        
        public init(onSerialize: @escaping Serialize = { _ in }) {
            self.onSerialize = onSerialize
        }
    
    public typealias Object = List<T>
    public typealias JSON = [Any]

    public func transformFromJSON(_ value: Any?) -> Object? {
        guard let array = value as? [Any] else { return nil }

        let list = List<T>()
        if let objects = Array<T>.deserialize(from: array)?.compactMap({$0}) {
            list.append(objectsIn: objects)
        }
        self.onSerialize(list)
        return list
    }

    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.compactMap{
            $0.toJSON()
        }
    }
}
