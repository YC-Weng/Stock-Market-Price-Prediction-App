//
//  resultViewController.swift
//  viewPratice
//
//  Created by 楊子頤 on 2023/12/25.
//

import UIKit

class resultViewController: UIViewController {
    
    @IBOutlet weak var survey_result: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var portfolio: UILabel!
    @IBOutlet weak var potfolio1: UILabel!
    @IBOutlet weak var portfolio2: UILabel!
    @IBOutlet weak var portfolio3: UILabel!
    
    let total_num: Int
    
    init?(coder: NSCoder, total_num:Int) {
        self.total_num=total_num
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text1.text="建議投資標的   年化夏普率"
        text2.text="3034.TW       2.352"
        text3.text="3231.TW       2.480"
        text4.text="2382.TW       2.709"
        portfolio.text="投資組合推薦"
        
        result()
    }
    func result(){
        print("total_num:",total_num)
        if total_num>=3 && total_num<=6{
            survey_result.text="結果：謹慎型"
            potfolio1.text="3034.TW weight:0.48"
            portfolio2.text="3231.TW weight:0.23"
            portfolio3.text="2382.TW weight:0.29"
        }
        else if total_num>=7 && total_num<=10{
            survey_result.text="結果：穩健型"
            potfolio1.text="3034.TW weight:0.31"
            portfolio2.text="3231.TW weight:0.36"
            portfolio3.text="2382.TW weight:0.33"
        }
        else if total_num>=11 && total_num<=15{
            survey_result.text="結果：冒險型"
            potfolio1.text="3034.TW weight:0.11"
            portfolio2.text="3231.TW weight:0.40"
            portfolio3.text="2382.TW weight:0.49"
        }
    }
}
