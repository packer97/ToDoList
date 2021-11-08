import Foundation
import RealmSwift

@objcMembers
class DayModel: Object{
 
    dynamic var title = String()
    dynamic var date = String()
    dynamic var time = String()
    dynamic var text = String()
    dynamic var compoundKey = String()

    override class func primaryKey() -> String? {
        return #keyPath(compoundKey)
    }
    func setup(date: String, time: String){
            self.date = date
            self.time = time
            self.compoundKey = compoundKeyValue()
    }

    func compoundKeyValue() -> String {
            return "\(date)\(time)"
    }
}
