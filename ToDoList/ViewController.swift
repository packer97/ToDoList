import UIKit
import FSCalendar
import RealmSwift

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    let day = DayModel()
    let dbManager: DbManager = DbManager()
    var results: [DayModel]?
    var currentDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        currentDate = dayFormatter(day:calendar.today!)
        results = dbManager.getListForDate(date: dayFormatter(day:calendar.today!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
        UIView.transition(with: tableView, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = dayFormatter(day: date)
        print(dbManager.getListForDate(date: dayFormatter(day: date)))
        UIView.transition(with: tableView, duration: 1.0, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.startTimeLabel.text = "\(hoursFormatter(rowNumber: indexPath.row))"
        cell.endTimeLabel.text = "\(indexPath.row == 23 ? hoursFormatter(rowNumber: 0) :hoursFormatter(rowNumber: indexPath.row+1))"
        if let text = dbManager.getObjectForKey(key: "\(currentDate!+String(indexPath.row))")?.title {
            cell.titleLabel.text = text
        }else{cell.titleLabel.text = "your task"}
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let index = tableView.indexPathForSelectedRow?.row
            if index != nil {
                destination.currentDate = "\(currentDate!+String(index!))"
                destination.currentDay = "\(currentDate!)"
                destination.currentTime = "\(String(index!))"
            } else {
                destination.currentDate = "nothing"
                destination.currentDay = "nothing"
                destination.currentTime = "nothing"
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
}



