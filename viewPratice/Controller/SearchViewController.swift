//
//  SearchViewController.swift
//  viewPratice
//
//  Created by Jube on 2022/12/23.
//

import UIKit
import Foundation

struct Question {
    var question: String
    var choose: [String]
}

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet var chooseButton: [UIButton]!
    @IBOutlet var chooseLabel: [UILabel]!
    @IBOutlet weak var survey: UILabel!
    
    var totalScore = 0
    var index = 0
    
    var questiondata = [Question(question: "Q1：財務狀況和能力：", choose: ["a.依賴投資收益生活", "b.財務壓力較大", "c.穩定儲蓄和收入", "d.有穩健儲蓄但收入稍不穩定", "e.有穩健儲蓄和穩定收入"]),Question(question: "Q2：投資目標與時間範圍?：", choose: ["a.短期高風險投資", "b.中期追求一定回報", "c.長期穩健增長", "d.長期退休儲蓄", "e.長期最小風險投資"]), Question(question: "Q3：對市場波動的反應：", choose: ["a.對市場波動不太感到擔憂", "b.有所擔憂但能冷靜面對", "c.有些許不安但不影響投資決策", "d.感到壓力但能保持理性", "e.非常焦慮，無法承受市場波動"])]
    
    func question(){
        questionLabel.text = questiondata[index].question
        for i in 0...4 {
            chooseLabel[i].text = questiondata[index].choose[i]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        survey.text="風險評估表單"
        question()
    }
    
    @IBAction func btn1(_ sender: Any) {
        index+=1
        totalScore+=5
        if index>2{
            performSegue(withIdentifier: "showResult", sender: sender)
        }else{
            question()
        }
    }
    
    @IBAction func btn2(_ sender: Any) {
        index+=1
        totalScore+=4
        if index>2{
            performSegue(withIdentifier: "showResult", sender: sender)
        }else{
            question()
        }
    }
    
    @IBAction func btn3(_ sender: Any) {
        index+=1
        totalScore+=3
        if index>2{
            performSegue(withIdentifier: "showResult", sender: sender)
        }
        else{
            question()
        }
    }
    
    @IBAction func btn4(_ sender: Any) {
        index+=1
        totalScore+=2
        if index>2{
            performSegue(withIdentifier: "showResult", sender: sender)
        }
        else{
            question()
        }
    }
    
    @IBAction func btn5(_ sender: Any) {
        index+=1
        totalScore+=1
        if index>2{
            performSegue(withIdentifier: "showResult", sender: sender)
        }
        else{
            question()
        }
    }
    
    @IBSegueAction func showResult(_ coder: NSCoder) -> resultViewController? {
        return resultViewController(coder: coder, total_num:totalScore)
    }
    
}





