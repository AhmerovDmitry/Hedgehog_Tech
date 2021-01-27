//
//  BrowserViewController.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 20.01.2021.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    let webView = WKWebView()
    var progressView = UIProgressView(progressViewStyle: .default)
    let url = URL(string: "http://www.icndb.com/api/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        webViewSettings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
}
