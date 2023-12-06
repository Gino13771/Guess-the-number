//
//  ViewController.swift
//  Guess the number
//
//  Created by 凱聿蔡凱聿 on 2023/10/5.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var no: UIImageView!
    @IBOutlet weak var yes: UIImageView!
    @IBOutlet weak var hint: UILabel!
    
    var answer = 0
    var chance = 5
    var upperBound = 50
    var lowerBound = 0
    
    @IBAction func go(_ sender: UIButton) {
        number.resignFirstResponder()
        
        guard let inputText = number.text, !inputText.isEmpty else {
            hint.text = "今天孵了幾顆🥚呢？"
            return
        }
        
        guard let inputNumber = Int(inputText) else {
            hint.text = "請輸入數字！"
            return
        }
        
        guard chance > 0 else {
            hint.text = "沒機會了！！"
            if let no = no {
                no.isHidden = false
            }
            return
        }
        
        check(test: inputNumber)
    }
    
    func getBoundaryText(userInput: Int, target: Int) -> String {
        return "(\(lowerBound)~\(upperBound))"
    }
    
    func check(test: Int) {
        if test > 50 {
            if let hint = hint, let time = time {
                hint.text = "超出範圍！\(getBoundaryText(userInput: lowerBound, target: upperBound))"
                chance -= 1
                time.text = String(chance)
            }
        } else if test > answer {
            if let hint = hint, let time = time {
                upperBound = test - 1
                hint.text = "沒有那麼多啦！\(getBoundaryText(userInput: lowerBound, target: upperBound))"
                chance -= 1
                time.text = String(chance)
            }
        } else if test < answer {
            if let hint = hint, let time = time {
                lowerBound = test + 1
                hint.text = "這也太少了吧！\(getBoundaryText(userInput: lowerBound, target: lowerBound))"
                chance -= 1
                time.text = String(chance)
            }
        } else {
            if let hint = hint, let yes = yes {
                hint.text = "答對了！就是\(answer)顆！"
                yes.isHidden = false
            }
        }
    }
    
    func resetGame() {
        hint.text = "再來一次！"
        number.text = "0"
        chance = 5
        upperBound = 50
        lowerBound = 0
        answer = Int(arc4random_uniform(50))
        time.text = String(chance)
        if let no = no {
            no.isHidden = true
        }
        if let yes = yes {
            yes.isHidden = true
        }
    }
    
    
    
    @IBAction func again(_ sender: Any) {
        resetGame()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        number.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answer = Int(arc4random_uniform(50))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
