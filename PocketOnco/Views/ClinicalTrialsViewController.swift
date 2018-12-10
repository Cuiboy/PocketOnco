//
//  ClinicalTrialsViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/9/18.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class ClinicalTrialsViewController: UIViewController, WKNavigationDelegate {

    @IBAction func actionTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Open in Safari?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            guard let link = self.webView.url else {return}
            UIApplication.shared.open(link)
        }))
        ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    var name = String()
    var webView: WKWebView!
    let colon = "https://clinicaltrials.gov/ct2/results?cond=Colorectal+Cancer&term=&cntry=US&state=&city=&dist="
    let breast = "https://clinicaltrials.gov/ct2/results?cond=Breast+Cancer&term=&cntry=US&state=&city=&dist="
    let skin = "https://clinicaltrials.gov/ct2/results?cond=Skin+Cancer+&term=&cntry=US&state=&city=&dist="
    var activityIndicator: NVActivityIndicatorView!
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clinical Trials"
        activityIndicator = NVActivityIndicatorView(frame: CGRect(origin: CGPoint(x: self.view.center.x - CGFloat(50).relativeToWidth, y: self.view.center.y - CGFloat(50).relativeToWidth), size: CGSize(width: CGFloat(100).relativeToWidth, height: CGFloat(100).relativeToWidth)), type: NVActivityIndicatorType(rawValue: 12), color: lightColor, padding: nil)
        activityIndicator.alpha = 0
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.5) {
            self.activityIndicator.alpha = 1
        }
        
        webView.allowsBackForwardNavigationGestures = true
        if name == "Colorectal Cancer" {
            webView.load(URLRequest(url: URL(string: colon)!))
        } else if name == "Breast Cancer" {
               webView.load(URLRequest(url: URL(string: breast)!))
        } else {
               webView.load(URLRequest(url: URL(string: skin)!))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
