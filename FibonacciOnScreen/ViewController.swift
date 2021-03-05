//
//  ViewController.swift
//  FibonacciOnScreen
//
//  Created by Smriti Raina on 05.03.21.
//

import UIKit

class ViewController: UIViewController {

    let maxLimit = UInt64.max
    var fibs: [UInt64] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fib(UInt64(maxLimit))
        // Do any additional setup after loading the view.
    }

    private func fib(_ n: UInt64) -> [UInt64] {

        var a = UInt64(0)
        var b = UInt64(1)
        fibs.append(a)
        fibs.append(b)
        guard n > 1 else { return fibs }
        
        (2...n).forEach { _ in
            (a, b) = (a &+ b, a)
            print(a)
            fibs.append(a)

        }
        return fibs
        
        //        (2...n).forEach { i in
//            fibs.append(fibs[Int(UInt64(i) - UInt64(1))] + fibs[Int(UInt64(i) - UInt64(2))])
//        }
//        return fibs
    }
    

}

