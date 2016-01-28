//  ReloadExampleViewController.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2016 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import XLPagerTabStrip

public class ReloadExampleViewController: UIViewController {
    
    @IBOutlet lazy public var titleLabel: UILabel! = {
        let label = UILabel()
        return label
    }()
    
    public lazy var bigLabel: UILabel = {
        let bigLabel = UILabel()
        bigLabel.backgroundColor = .clearColor()
        bigLabel.textColor = .whiteColor()
        bigLabel.font = UIFont.boldSystemFontOfSize(20)
        bigLabel.adjustsFontSizeToFitWidth = true
        return bigLabel
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = navigationController {
            navigationItem.titleView = bigLabel
            bigLabel.sizeToFit()
        }
        
        if let pagerViewController = childViewControllers.filter( { $0 is PagerTabStripViewController } ).first as? PagerTabStripViewController {
            updateTitle(pagerViewController)
        }
    }
    
    @IBAction func reloadTapped(sender: UIBarButtonItem) {
        for childViewController in childViewControllers {
            guard let child = childViewController as? PagerTabStripViewController else {
                continue
            }
            child.reloadPagerTabStripView()
            updateTitle(child)
            break;
        }
    }
    
    func updateTitle(pagerTabStripViewController: PagerTabStripViewController) {
        func stringFromBool(bool: Bool) -> String {
            return bool ? "YES" : "NO"
        }
        
        titleLabel.text = "Progressive = \(stringFromBool(pagerTabStripViewController.pagerOptions.contains(.IsProgressiveIndicator)))  ElasticLimit = \(stringFromBool(pagerTabStripViewController.pagerOptions.contains(.IsElasticIndicatorLimit)))"
        
        (navigationItem.titleView as? UILabel)?.text = titleLabel.text
        navigationItem.titleView?.sizeToFit()
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
