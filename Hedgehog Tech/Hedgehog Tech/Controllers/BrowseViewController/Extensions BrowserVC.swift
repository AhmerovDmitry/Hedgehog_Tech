//
//  Extensions BrowserVC.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 27.01.2021.
//

import UIKit
import WebKit

// MARK: - Setup constraints
extension BrowserViewController {
    func setupConstraints() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor,
                                         constant: topLayoutGuide.length),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomLayoutGuide.length)
        ])
    }
}

// MARK: - WebView Settings
extension BrowserViewController: WKNavigationDelegate {
    func webViewSettings() {
        let request = URLRequest(url: url!)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let scipButton = UIBarButtonItem(barButtonSystemItem: .undo, target: webView, action: #selector(webView.goBack))
        
        toolbarItems = [scipButton, spacer, progressButton, spacer, refreshButton]
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    // Observe progress bar
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
}
