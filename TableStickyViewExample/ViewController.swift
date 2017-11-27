//
//  ViewController.swift
//  TableStickyViewExample
//
//  Created by Yusuf Demirci on 26.11.2017.
//  Copyright © 2017 demirciy. All rights reserved.
//

import UIKit

private var xoStickyHeaderKey: UInt8 = 0
extension UIScrollView {
    
    public var stickyHeader: StickyHeader! {
        
        get {
            var header = objc_getAssociatedObject(self, &xoStickyHeaderKey) as? StickyHeader
            
            if header == nil {
                header = StickyHeader()
                header!.scrollView = self
                objc_setAssociatedObject(self, &xoStickyHeaderKey, header, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return header!
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var table: UITableView!
    
    // MARK: Properties
    var navigationView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        let headerView = Bundle.main.loadNibNamed("MyHeaderView", owner: nil, options: nil)?.first as! MyHeaderView
        
        table.stickyHeader.view = headerView
        table.stickyHeader.height = headerView.frame.height
        table.stickyHeader.minimumHeight = 64
        
        navigationView.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        navigationView.backgroundColor = .green
        navigationView.alpha = 0
        table.stickyHeader.view = navigationView
    }
    
    // MARK: Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "tableCell")!
    }
    
    // MARK: Scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        
        let changeStartOffset: CGFloat = -180
        let changeSpeed: CGFloat = 100
        navigationView.alpha = min(1.0, (offset - changeStartOffset) / changeSpeed)
    }
}

