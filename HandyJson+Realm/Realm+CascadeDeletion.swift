import Realm
import RealmSwift

internal protocol CascadingDeletable: RealmSwift.Object {
    static var propertiesToCascadeDelete: [String] { get }
}

extension CascadingDeletable {
    static var propertiesToCascadeDelete: [String] {
        return []
    }
}

extension Realm {
    internal func cascadingDelete(_ object: RealmSwift.Object) {
        var toBeDeleted: Set<RLMObjectBase> = [object]
        while let element = toBeDeleted.popFirst() as? RealmSwift.Object {
            guard !element.isInvalidated else { continue }
            if let cascadingDeletable = element as? CascadingDeletable {
                cascade(into: cascadingDeletable, toBeDeleted: &toBeDeleted)
            }
            delete(element)
        }
    }

    private func cascade(into object: CascadingDeletable, toBeDeleted: inout Set<RLMObjectBase>) {
        let objectType = type(of: object)

        guard let schema = objectType.sharedSchema() else { return }

        let primaryKey = objectType.primaryKey()
        let primaryKeyValue = primaryKey.flatMap(object.value(forKey:))

        let properties = (schema.properties + schema.computedProperties)
            .filter { objectType.propertiesToCascadeDelete.contains($0.name) }

        for property in properties {
            switch object.value(forKey: property.name) {
            case let realmObject as RLMObjectBase:
                toBeDeleted.insert(realmObject)
            case let list as RLMSwiftCollectionBase:
                for index in 0 ..< list._rlmCollection.count {
                    guard let realmObject = list._rlmCollection.object(at: index) as? RLMObjectBase else { continue }
                    toBeDeleted.insert(realmObject)
                }
            default: // LinkingObjects
                if let linkOriginPropertyName = property.linkOriginPropertyName,
                   let linkOriginTypeName = property.objectClassName,
                   let primaryKey = primaryKey,
                   let primaryKeyValue = primaryKeyValue {
                    dynamicObjects(linkOriginTypeName)
                        .filter("%K == %@", "\(linkOriginPropertyName).\(primaryKey)", primaryKeyValue)
                        .forEach { toBeDeleted.insert($0) }
                }
            }
        }
    }
}
