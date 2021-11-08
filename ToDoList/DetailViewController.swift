import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var dbManger: DbManager = DbManager()
    let day = DayModel()
    var result: DayModel?
    var currentDate: String?
    var currentDay: String?
    var currentTime: String?
    var titleText: String?
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelTap(label: titlelabel)
        self.setupLabelTap(label: dateLabel)
        self.setupLabelTap(label: descriptionLabel)
        self.result = dbManger.getObjectForKey(key: currentDate!)
        if self.result != nil{ titlelabel.text = result!.title}else{titlelabel.text = "Title"}
        if self.currentDate != nil{ dateLabel.text = "\(currentDay!)-\(hoursFormatter(rowNumber: currentTime!))"}else{dateLabel.text = "Current Time"}
        if self.result != nil{descriptionLabel.text = result!.text}else{descriptionLabel.text = "Description"}
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        switch sender.view {
        case titlelabel:
            print("titleLabelTapped")
            addAlertForTextLabel(title:"title",label: titlelabel)
        case dateLabel:
            print("dateLabelTapped")
        case descriptionLabel:
            print("descriptionLabelTapped")
            addAlertForTextLabel(title:"description", label: descriptionLabel)
        default:
            print("view???")
        }
    }
    @IBAction func saveTask(_ sender: Any) {
        if self.titleText != nil { day.title = self.titleText! }
        else{day.title = "Title"}
        if self.descriptionText != nil {day.text = self.descriptionText!}
        else{day.text = "Description"}
        day.setup(date: currentDay!, time: currentTime!)
        print(day.title)
        print(day.text)
        if dbManger.getObjectForKey(key: currentDate!) == nil {
            self.dbManger.saveData(list: day)}
        else{if titleText == nil { day.title = result!.title}
                else {day.title = titleText!}
            if descriptionText == nil  { day.text = result!.text}
                else {day.text = descriptionText!}
                dbManger.updateObject(obj: day)}

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        if dbManger.getObjectForKey(key: currentDate!) != nil
            { self.dbManger.remove(obj: self.result!)}
        self.navigationController?.popViewController(animated: true)
    }
      
    func setupLabelTap(label: UILabel) {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
        }
    
    func addAlertForTextLabel(title:String,label:UILabel){
        let alert = UIAlertController(title: "\(title)", message:"Write text", preferredStyle: .alert)
        var alertTextField: UITextField!
        alert.addTextField {textField in
            alertTextField = textField
            textField.placeholder = "\(title)"
        }
        let saveAction = UIAlertAction(title: "Ok", style: .default){action in
            guard let text = alertTextField.text, !text.isEmpty else {return}
            label.text = text
            if label == self.titlelabel {
                self.titleText = text
            } else {
                self.descriptionText = text
            }
            self.view.reloadInputViews()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert,animated: true,completion: nil)
    }
    
}
