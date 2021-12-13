//
//  WebViewController.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webKit: WKWebView!
    var web = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webKit = WKWebView()
        webKit.navigationDelegate = self
        view = webKit
        
        let url = URL(string: "\(web)")!
        webKit.load(URLRequest(url: url))
        webKit.allowsBackForwardNavigationGestures = true
    }

}

