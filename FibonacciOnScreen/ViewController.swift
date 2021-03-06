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

        self.fibonacciSeriesTextView.layoutManager.allowsNonContiguousLayout = false
        self.getFibSeries()
    }

    //MARK: - Private functions

    private func getFibSeries() {
        let maxIntValue = UInt64.max // As per requirement its UInt64 max, can be changed as needed
        var index : Int = 0
        var result : UInt64 = 0
        var temp : UInt64 = 0
        
        DispatchQueue.global(qos: .background).async { [self] in //perform calculation on background
        
        while true {
            result = fibonacciRecurrsive(index)
            
            // Checking whether next element is casuing overflow or not
            let sum = temp.addingReportingOverflow(result)
            
            // Terminate the loop when overflow occurs
            if sum.overflow == true {
                print("Overflow occurred at",index)
                self.updateTextViewWith(nextNum: result) //Update UI when overflow occured
                break
            }
            
            // Terminate the loop when result is greater than or equal to MaxIntValue.
            // Example: If MaxIntValue = 10 then it will terminate the loop when result is 8
            
            if sum.partialValue >= maxIntValue {
                print("Max UInt64 value reached!!")
                break
            }
            
            self.updateTextViewWith(nextNum: result) //Keep Updating UI till condition meets

            index = index + 1
            temp = result
            usleep(5000)
        }
        }
    }

    //Updates textview text everytime a new element in series is calculated
    private func updateTextViewWith(nextNum: UInt64){
        DispatchQueue.main.sync { [self] in
            self.fibonacciSeriesTextView.text = self.fibonacciSeriesTextView.text + "\(nextNum),\n"
            
            let range = NSMakeRange(self.fibonacciSeriesTextView.text.count, 0);
            self.fibonacciSeriesTextView.scrollRangeToVisible(range);//For scrolling to bottom so that newest calculated element is visible
            }
    }
    
    private func fibonacciRecurrsive(_ n: Int) -> (UInt64)  {
 
        guard n > 1 else {
            return UInt64(n)
        }
        // Call recurrsive funtion when dictionary doesn't contains key. This is to improve the performance.
        
        let fibResult: UInt64 = (fibDict[n-2]  ?? fibonacciRecurrsive(n-2))
            &+ (fibDict[n-1] ?? fibonacciRecurrsive(n-1))
        
        fibDict[n] = fibResult // Store the result in dictionary
        
        fibDict.removeValue(forKey: n - 3) // Remove the key from dictionary that will not be required further. This will avoid consuming memory by keeping unused values in dictionary.

        return fibResult
    }
    
}
