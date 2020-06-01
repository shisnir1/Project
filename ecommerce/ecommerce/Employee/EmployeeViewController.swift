

import UIKit

class EmployeeViewController: UIViewController {
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var employeeSegmentedControl: UISegmentedControl!
    let apiManager = Api()
    var employees: [EmployeeModel] = []
    var flag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.employeeTableView.dataSource = self
               self.employeeTableView.delegate = self
        //For name in table View
         let nib = UINib(nibName: "EmployeeTableViewCell", bundle: nil)
                   employeeTableView.register(nib, forCellReuseIdentifier: "EmployeeTableViewCell")
        // For Card
        let nibCard = UINib(nibName : "EmployeeCardTableViewCell",bundle: nil)
        employeeTableView.register(nibCard, forCellReuseIdentifier:
        "EmployeeCardTableViewCell")
  getEmployeeData()
        // Do any additional setup after loading the view.
    }
    func getEmployeeData() {
          apiManager.getEmployees { [weak self] (response, error) in
              
              if let response = response as? [EmployeeModel] {
                  for item in response {
                      self?.employees.append(item)
                  }
                print("data from employee API recieved")
              }
              DispatchQueue.main.async {
                  self?.employeeTableView.reloadData()
                                                                    }        }
      }
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        if employeeSegmentedControl.selectedSegmentIndex == 0{
            flag = true
            employeeTableView.reloadData()
                                                        }
        else {
            flag = false
            employeeTableView.reloadData()
                                                        }
        }
}

extension EmployeeViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return employees.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               if flag {
                let listViewCell = employeeTableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
                               listViewCell.employeeName.text = employees[indexPath.row].employeeName
            return listViewCell

               }
                else {
                let cardViewCell = employeeTableView.dequeueReusableCell(withIdentifier: "EmployeeCardTableViewCell", for: indexPath) as! EmployeeCardTableViewCell
                cardViewCell.employeeId.text = employees[indexPath.row].id
                cardViewCell.employeeName.text = employees[indexPath.row].employeeName
                cardViewCell.employeeAge.text = employees[indexPath.row].employeeAge
                cardViewCell.employeeSalary.text = employees[indexPath.row].employeeSalary
            return cardViewCell
                   
               }
            
           }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if flag{
            return 50
        }
        else{
            return 150
        }
           }

    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


