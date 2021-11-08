import Foundation
import UIKit

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
func dayFormatter(day:Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-YYYY"
    let dateString = formatter.string(from: day)
    return dateString
}

func hoursFormatter(rowNumber:Int)->String{
    let dateAsString = "\(rowNumber):00"
    return dateAsString
}
func hoursFormatter(rowNumber:String)->String{
    let dateAsString = "\(rowNumber):00"
    return dateAsString
}
