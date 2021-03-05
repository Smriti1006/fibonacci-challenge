//
//  ViewController.swift
//  FibonacciOnScreen
//
//  Created by Smriti Raina on 05.03.21.
//

import UIKit

class ViewController: UIViewController {

    let maxLimit = UInt64.max
    var fibArray: [UInt64] = []
    var a = UInt64(0)
    var b = UInt64(1)

    @IBOutlet weak var fibonacciSeriesTextView: UITextView!
    
    //MARK: - View life cycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fibonacciSeriesTextView.text = "\(a),\n"
        self.fibonacciSequence(UInt64(maxLimit))
        // Do any additional setup after loading the view.
    }

    //MARK: - Private functions

    private func fibonacciSequence(_ n: UInt64){

        fibArray.append(a)
        fibArray.append(b)
        
        guard n > 1 else { return }
        DispatchQueue.global(qos: .background).async { [self] in
        (2...n).forEach { _ in
            (a, b) = (a &+ b, a)
            do{
                sleep(1)
            }
            DispatchQueue.main.sync { [self] in
                self.fibonacciSeriesTextView.text = self.fibonacciSeriesTextView.text + "\(a),\n"
            }
        }
        }
        
    }
    

}

