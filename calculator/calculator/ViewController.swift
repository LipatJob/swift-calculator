//
//  ViewController.swift
//  calculator
//
//  Created by Xcode on 7/1/23.
//

import UIKit

class ViewController: UIViewController {
    var calculator: Calculator = Calculator();
    
    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onPress(_ sender: Any) {
        var button: UIButton = sender as! UIButton;
        var buttonText = button.titleLabel!.text!;
        
        addToken(token: buttonText)
        
    }
    
    @IBAction func onNegate(_ sender: Any) {
        negate();
    }
    
    @IBAction func onClearExpression(_ sender: Any) {
        clearText();
    }
    
    @IBAction func onEqualsPressed(_ sender: Any) {
        calculateText()
    }
    
    @IBAction func onCPressed(_ sender: Any) {
        deleteCharacter()
    }
    
    func deleteCharacter(){
        calculator.deleteToken();
        updateText()
    }
    
    func addToken(token: String){
        
            calculator.addToken(token: token)
            updateText();
    }
    
    func negate(){
        if(calculator.isValid()){
            calculator.expression = String(calculator.calculate())
            calculator.expression = String(calculator.negate())
            updateText()
        }
    }
    
    func clearText(){
        calculator.expression = ""
        updateText()
    }
    
    func calculateText(){
        if(calculator.isValid()){
            calculator.expression = String(calculator.calculate())
            updateText()
        } else {
            text.textColor = UIColor.red;
        }
    }
    
    func updateText(){
        text.textColor = UIColor.black;
        text.text = calculator.expression;
    }
    

}

