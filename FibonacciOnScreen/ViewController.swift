//
//  ViewController.swift
//  FibonacciOnScreen
//
//  Created by Smriti Raina on 05.03.21.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    private var fibDict = [Int: UInt64] ()
    
    @IBOutlet weak var fibonacciSeriesTextView: UITextView!
    
    //MARK: - View life cycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fibonacciSeriesTextView.delegate = self
        self.fibonacciSeriesTextView.layoutManager.allowsNonContiguousLayout = false
        self.getFibSeries()
    }

    //MARK: - Private functions

    private func getFibSeries() {
        let maxIntValue = UInt64.max // As per requirement its UInt64 max, can be changed as needed
        var index : Int = 0
        var result : UInt64 = 0
        var temp : UInt64 = 0
        
        DispatchQueue.global(qos: .background).async { [self] in
        
        while true {
            
            result = fibRecur(index)
            
            let sum = temp.addingReportingOverflow(result).overflow
            
            if sum == true {
                print("Overflow occurred at",index)
                self.updateTextViewWith(nextNum: result)
                break
            }
            
            if result >= maxIntValue {
                print("Max UInt64 value reached!!")
                break
            }
            
            self.updateTextViewWith(nextNum: result)
            
            index = index + 1
            temp = result
            usleep(1000)
        }
        }
    }
    
    private func updateTextViewWith(nextNum: UInt64){
        DispatchQueue.main.sync { [self] in
                self.fibonacciSeriesTextView.text = self.fibonacciSeriesTextView.text + "\(nextNum),\n"
            let range = NSMakeRange(self.fibonacciSeriesTextView.text.count, 0);
            self.fibonacciSeriesTextView.scrollRangeToVisible(range);

            }
        }
    
    
    private func fibRecur(_ n: Int) -> (UInt64)  {
 
        guard n > 1 else {
            return UInt64(n)
        }
        let fibResult: UInt64 = (((fibDict[n-2] != nil) ? fibDict[n-2]! : fibRecur(n-2))) &+ (((fibDict[n-1] != nil) ? fibDict[n-1]! : fibRecur(n-1)))
       
        fibDict[n] = fibResult
        fibDict.removeValue(forKey: n - 3)

        return fibResult
    }
    
}
