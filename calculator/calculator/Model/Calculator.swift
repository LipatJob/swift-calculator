//
//  Calculator.swift
//  calculator
//
//  Created by Xcode on 7/1/23.
//

import Foundation

class Calculator{
 
    var expression = "";
    
    func addToken(token: String){
        
            expression.append(token);
   
        
    }
    
    func canAddToken(token: String) -> Bool{
        return isExpressionValid(expression: expression + token)
    }
    
    func isExpressionValid(expression: String) -> Bool{
        if !areNumbersValid(expression: expression) { return false; }
        if expression.count == 0 {return true;}
        if expression.count == 1 && !isOperator(token: expression) { return true;}
        for i in 0...expression.count-2 {
            let token1: String = String(expression[expression.index(expression.startIndex, offsetBy: i)])
            let token2: String = String(expression[expression.index(expression.startIndex, offsetBy: i+1)])
            
            if isOperator(token: token1) && isOperator(token: token2){
                return false;
            }
        }
        // 1++1
        return true;
    }
    
    func areNumbersValid(expression: String) -> Bool{
        for value in expression.components(separatedBy: CharacterSet(charactersIn: "+-/*%")){
            if Double(value) == nil{
                return false;
            }
        }
        return true;
                    
    }
    
    func isOperator(token: String) -> Bool{
        
        return token == "+" || token == "-" || token == "*"  || token == "/" || token == "%"
    }
    
    func isValid() -> Bool{
        
        return  isExpressionValid(expression: expression)
    }
    
    func deleteToken(){
        if(expression.count > 0){
            expression = expression.substring(to: expression.index(before: expression.endIndex))
        }
        
    }
    
    func handleModulo() -> NSExpression{
        let subparts = expression.components(separatedBy: CharacterSet(charactersIn: "%"))
        if subparts.count > 1{
            var currentSubPart = NSExpression(format: subparts[0])
            for i in 1...subparts.count - 1{
                currentSubPart = NSExpression(forFunction: "modulus:by:", arguments: [
                    currentSubPart,
                    NSExpression(format: subparts[i]),
                ])
                
            }
            return currentSubPart;
        }else {
            return NSExpression(format: expression)
        }
        
            
    }
    
    func calculate() -> Double{
        let exp = handleModulo()
        print(exp)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.doubleValue;
        }
        else {
            return -1;
        }
    }
    
    func negate() -> Double{
        if(isValid()){
            expression += "*-1"
            return calculate()
        }
        return -1;
    }
        
    
}
