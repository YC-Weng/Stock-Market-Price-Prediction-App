//
//  StockModel.swift


import Foundation


struct company_info: Decodable {
    let id: String?
    let stock_code: String
    let company_name: String
}
struct week_info: Decodable {
    var trade_week: String?
    var open_price: Double?
    var high_price: Double?
    var low_price: Double?
    var closing_price: Double?
    var volume: Double?
}

struct day_info: Decodable {
    var trade_day: String?
    var open_price: Double?
    var high_price: Double?
    var low_price: Double?
    var closing_price: Double?
    var volume: Double?
}

struct pre_info: Decodable {
    var trade_day: String?
    var open_price: Double?
}

class week_model {
    
    weak var delegate: Downloadable?
    let stockModel = Network()
    
//    func downloadStocks(parameters: [String: Any], url: String) {
//        let request = stockModel.request(parameters: parameters, url: url)
//        stockModel.response(request: request) { (data) in
//            let model = try! JSONDecoder().decode([Stocks_info]?.self, from: data) as [Stocks_info]?
//            self.delegate?.didReceiveData(data: model! as [Stocks_info])
//        }
//    }
    func downloadStocks(url: String) {
        let request = stockModel.request(url: url)
        stockModel.response(request: request) { (data) in
            let model = try! JSONDecoder().decode([week_info]?.self, from: data) as [week_info]?
            self.delegate?.didReceiveData(data: model! as [week_info])
        }
    }
}

class day_model {
    
    weak var delegate: Downloadable?
    let stockModel = Network()
    
    func downloadStocks(url: String) {
        let request = stockModel.request(url: url)
        stockModel.response(request: request) { (data) in
            let model = try! JSONDecoder().decode([day_info]?.self, from: data) as [day_info]?
            self.delegate?.didReceiveData(data: model! as [day_info])
        }
    }
}

class company_model {
    
    weak var delegate: Downloadable?
    let stockModel = Network()
    
    func downloadStocks(url: String) {
        let request = stockModel.request(url: url)
        stockModel.response(request: request) { (data) in
            let model = try! JSONDecoder().decode([company_info]?.self, from: data) as [company_info]?
            self.delegate?.didReceiveData(data: model! as [company_info])
        }
    }
}

class pre_model {
    
    weak var delegate: Downloadable?
    let stockModel = Network()
    
    func downloadStocks(url: String) {
        let request = stockModel.request(url: url)
        stockModel.response(request: request) { (data) in
            let model = try! JSONDecoder().decode([day_info]?.self, from: data) as [day_info]?
            self.delegate?.didReceiveData(data: model! as [day_info])
        }
    }
}
