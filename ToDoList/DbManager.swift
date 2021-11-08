import Foundation
import RealmSwift

class DbManager {
    
    
    func saveData(list:DayModel){
        let realm = try! Realm()
        try! realm.write {
            realm.add(list)
        }
    }
    func remove(obj: Object){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(obj)
        }
    }
    func clearAll(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func getList()->[DayModel]{
        let realm = try! Realm()
        let models = realm.objects(DayModel.self)
        return Array(models)
        }
    func getListForDate(date:String)->[DayModel]{
        let realm = try! Realm()
        let currentDay =  realm.objects(DayModel.self).filter("date = '\(date)'")
        return Array(currentDay)
    }
    
    
    func getObjectForKey(key:String)->DayModel?{
        let realm = try! Realm()
        let day = realm.object(ofType: DayModel.self, forPrimaryKey: key)
        return day
    }
    
    func updateObject(obj: Object){
        let realm = try! Realm()
        try! realm.write {
            realm.add(obj, update: .all)
        }
    }
}
