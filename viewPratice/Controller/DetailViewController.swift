//
//  DetailViewController.swift


import UIKit
import DGCharts

class DetailViewController: UIViewController {
    
    let stock: Stock
    var stocks: [Stock]
    let selectNum: Int
    let day_data=day_model()
    let pre_data=pre_model()
    var dataEntry: [CandleChartDataEntry] = []
    var new_stock_data: [day_info] = []
    var pre_stock_data: [day_info] = []
    var dataEntry_v: [BarChartDataEntry] = []
    var barColors:[NSUIColor]=[]
    var prev_volume=0.0
    var lock=1
   
    
    init?(coder: NSCoder, stock: Stock, stocks: [Stock], selectNum: Int) {
        self.stock = stock
        self.stocks = stocks
        self.selectNum = selectNum
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var pagination: UIPageControl!
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var high_price: UILabel!
    @IBOutlet weak var low_price: UILabel!
    @IBOutlet weak var open_price: UILabel!
    @IBOutlet weak var close_price: UILabel!
    
    
    @IBOutlet weak var volume_chart: BarChartView!
    
    @IBOutlet weak var stock_code: UILabel!
    
    @IBOutlet weak var pred_chart: CandleStickChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songLabel.text = stock.name
        stock_code.text = stock.stock_code+".TW"
        day_data.delegate=self
        pre_data.delegate=self
        // Do any additional setup after loading the view.
        get_stock_data()
        
        //        for i in 0..<monthArray.count {
        //            dataEntries.append(ChartDataEntry(x: Double(i), y: temperatureArray[i]))
        //        }
        //        // 產生 LineChartDataSet
        //        let DataSet = LineChartDataSet(entries: dataEntries, label: "stock_price")
        //        //DataSet.colors = [.red]
        //        // 產生 Data
        //        DataSet.mode = .cubicBezier
        //        DataSet.lineWidth=3
        //        DataSet.valueTextColor = .black
        //        DataSet.circleRadius=5
        //
        //        let Data = LineChartData(dataSet: DataSet)
        //        // 利用 ChartsView 顯示 BarChartData
        //        pred_chart.data = Data
        //
        //        // 將 x 方向的格式修改成我們設定的字串
        //        pred_chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: monthArray)
        //        // 隱藏 x,y 軸水平線
        //        pred_chart.xAxis.drawGridLinesEnabled = false
        //        pred_chart.leftAxis.drawGridLinesEnabled = false
        //        pred_chart.rightAxis.drawGridLinesEnabled = false
        
    }
    func assign_data(){
        let stock_id=stock.stock_code
                high_price.text="high:"+String(new_stock_data[0].high_price!)
                low_price.text="low:"+String(new_stock_data[0].low_price!)
                open_price.text="open:"+String(new_stock_data[0].open_price!)
                close_price.text="low:"+String(new_stock_data[0].closing_price!)
    }
    
    func get_stock_data(){
        //let param=["stock_code":stock.stock_code]
        let stock_id=stock.stock_code
        print(stock_id)
        //        let url_server: String = "http://localhost:8080/ML_Server/CompanyServlet/Data/week_ks?stock_code=\(stock_id)"
        let url_server_1: String = "http://localhost:8080/ML_Server/CompanyServlet/Data/pre_day_ks?stock_code=\(stock_id)"
        let url_server_2: String = "http://localhost:8080/ML_Server/CompanyServlet/Data/day_ks?stock_code=\(stock_id)"
        //        if lock==1{
        //            day_data.downloadStocks(url: url_server_2)
        //            lock=0
        //        }
        pre_data.downloadStocks(url: url_server_1)
        
    }
    
    func draw_kline_chart(){
        let stock_id=stock.stock_code
        pred_chart.dragEnabled = false
        pred_chart.setScaleEnabled(true)
        pred_chart.maxVisibleCount = 200
        pred_chart.pinchZoomEnabled = true
        
        pred_chart.legend.horizontalAlignment = .right
        pred_chart.legend.verticalAlignment = .top
        pred_chart.legend.orientation = .vertical
        pred_chart.legend.drawInside = false
        pred_chart.legend.font = UIFont.systemFont(ofSize: 10)
        pred_chart.legend.enabled=false//隱藏標籤
        //pred_chart.drawBordersEnabled = true
        
        pred_chart.leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        pred_chart.leftAxis.spaceTop = 0.3
        pred_chart.leftAxis.spaceBottom = 0.3
        pred_chart.leftAxis.axisMinimum = 0
        
        pred_chart.rightAxis.enabled = false
        
        pred_chart.xAxis.labelPosition = .bottom
        pred_chart.xAxis.labelFont = UIFont.systemFont(ofSize: 10)
        
        pred_chart.maxVisibleCount = 20
        
                for (i, each) in new_stock_data.enumerated().reversed(){
        
                    let x = Double((-1*i)+new_stock_data.count)
                    //let x = Double(i)
                    if let open = each.open_price,
                       let highest = each.high_price,
                       let lowest = each.low_price,
                       let close = each.closing_price {
        
                        let candleData = CandleChartDataEntry(x: x, shadowH: highest, shadowL: lowest, open: open, close: close)
                        dataEntry.append(candleData)
                        print(x,",",lowest,",",highest,".")
                    }
        
                }
    
        
        let DataSet = CandleChartDataSet(entries: dataEntry)
        DataSet.axisDependency = .left
        DataSet.setColor(.red)
        DataSet.drawIconsEnabled = false
        DataSet.shadowColor = .darkGray
        DataSet.shadowWidth = 0.5
        DataSet.decreasingColor = .systemGreen //注意下跌的顏色在該地區的習慣
        DataSet.decreasingFilled = true // 蠟燭線可以是實心，也可以是空心
        DataSet.increasingColor = .systemRed //注意下跌的顏色在該地區的習慣
        DataSet.increasingFilled = true
        DataSet.neutralColor = .black //當開盤 == 收盤的時候顏色
        
        let xAxis=pred_chart.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["12/5", "12/6", "12/7", "12/8", "12/12", "12/13", "12/14", "12/15", "12/18", "12/19", "12/20", "12/21", "12/22"])
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        
        let max = DataSet.yMax
        let min = DataSet.yMin
        pred_chart.leftAxis.axisMaximum = max * 1.05
        pred_chart.leftAxis.axisMinimum = min * 0.95
        // 隱藏 x,y 軸水平線
        pred_chart.xAxis.drawGridLinesEnabled = false
        //pred_chart.leftAxis.drawGridLinesEnabled = false
        //pred_chart.rightAxis.drawGridLinesEnabled = false
        
        let Data = CandleChartData(dataSet: DataSet)
        pred_chart.data=Data
    }
    func draw_volume_chart(){
        let stock_id=stock.stock_code
                for (i, each) in new_stock_data.enumerated().reversed(){
                    let x = Double((-1*i)+new_stock_data.count)
                    //let x = Double(i)
                    let volume = each.volume
                    let BarData = BarChartDataEntry(x: x, y:volume!)
                    dataEntry_v.append(BarData)
                    print(x,",",volume!,".")
                    if volume!>=prev_volume{
                        barColors.append(.systemRed)
                    }
                    else{
                        barColors.append(.systemGreen)
                    }
                    prev_volume=volume!
                }
        // 隱藏 x,y 軸水平線
        volume_chart.xAxis.drawGridLinesEnabled = false
        volume_chart.leftAxis.drawGridLinesEnabled = false
        volume_chart.rightAxis.drawGridLinesEnabled = false
        volume_chart.legend.enabled=false
        volume_chart.rightAxis.enabled = false
        volume_chart.xAxis.enabled=false//隱藏x軸座標
        //volume_chart.drawBordersEnabled = true
        volume_chart.leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        volume_chart.leftAxis.spaceTop = 0.3
        volume_chart.leftAxis.spaceBottom = 0.3
        
        
        let DataSet=BarChartDataSet(entries: dataEntry_v)
        DataSet.colors=barColors
        let max = DataSet.yMax
        let min = DataSet.yMin
        volume_chart.leftAxis.axisMaximum = max * 1.05
        volume_chart.leftAxis.axisMinimum = min * 0.95
        
        //DataSet.colors= //todo
        
        let Data=BarChartData(dataSet:DataSet)
        volume_chart.data=Data
        
        
    }
}





extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DetailCollectionViewCell.self)", for: indexPath) as? DetailCollectionViewCell else {
            fatalError("DetailCollectionViewCell faild")
        }
        let newIndexPath = (selectNum + indexPath.row) % stocks.count
        cell.detailAlbumImage.image = UIImage(named: stocks[newIndexPath].imageName)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.width
        pagination.currentPage = Int(pageNumber)
        let newNum = (selectNum + Int(pageNumber)) % stocks.count
        songLabel.text = stocks[newNum].name
        stock_code.text = stocks[newNum].stock_code
    }
}

extension DetailViewController: Downloadable{
    func didReceiveData(data: Any) {
        DispatchQueue.main.async {
            print("Data loaded successfully")
            //print("Received Data: \(String(data: data as! Data, encoding: .utf8) ?? "Unable to convert data to string")")
            print("input: \(data)")
            //            if self.lock==1{
            //                self.new_stock_data=data as! [day_info]
            //            }
            
            self.pre_stock_data=data as! [day_info]
            self.draw_kline_chart()
            self.draw_volume_chart()
            self.assign_data()
        }
    }
}
