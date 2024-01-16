//
//  WeeklyTableViewController.swift


import UIKit

class WeeklyTableViewController: UITableViewController {
    
    let model=company_model()
    var selectNum = 0
    var stocks:[Stock]=[]
    var new_company_data: [company_info] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate=self
        get_company_data()
    }
    
    
    
    func get_company_data(){
        let url_server: String = "http://localhost:8080/ML_Server/CompanyServlet"
        model.downloadStocks(url: url_server)
        return
    }
    
    func add_company_data(){
        print("enter add com_data")
        for data in new_company_data{
            let newStock = Stock(name: data.company_name, stock_code: data.stock_code, imageName: data.stock_code, isLike:false)
            stocks.append(newStock)
            //print("\(newStock)\n")
        }
        //print(stocks)
        tableView.reloadData()
    }
    
    @IBSegueAction func show(_ coder: NSCoder) -> DetailViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
        selectNum = row
        return DetailViewController(coder: coder, stock: stocks[row], stocks: stocks, selectNum: selectNum)
    }
    
    
    @IBAction func preeLike(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            stocks[indexPath.row].isLike = !stocks[indexPath.row].isLike
            sender.setImage(UIImage(named: stocks[indexPath.row].likeBtnImageName), for: .normal)
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(stocks.count)
        return stocks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(WeeklyTableViewCell.reuseIdentifier)", for: indexPath) as? WeeklyTableViewCell else {fatalError("WeeklyTableViewCell faild")}
        let stock = stocks[indexPath.row]
        cell.update(with: stock)
        // Configure the cell...

        return cell
    }
}
extension WeeklyTableViewController: Downloadable{
    func didReceiveData(data: Any) {
        // The data model has been dowloaded at this point
        // Now, pass the data model to the Holidays table view controller
       DispatchQueue.main.async {
           print("Data loaded successfully")
           //print("Received Data: \(String(data: data as! Data, encoding: .utf8) ?? "Unable to convert data to string")")
           //print("input: \(data)")
           self.new_company_data=data as! [company_info]
           self.add_company_data()
        }
    }
}
