//
//  TableViewDataSourceTests.swift
//  TableViewKit
//
//  Created by Alfredo Delli Bovi on 28/08/16.
//  Copyright © 2016 odigeo. All rights reserved.
//

import XCTest
import TableViewKit
import Nimble

class TestSection: Section {
    var items: ObservableArray<Item> = []
    weak var tableViewManager: TableViewManager!
    
    internal var header: HeaderFooterView { return .title("Header") }
    internal var footer: HeaderFooterView { return .title("Footer") }

    convenience init(items: [Item]) {
        self.init()
        self.items.insertContentsOf(items, at: 0)
    }
}

class TestDrawer: CellDrawer {
    
    static internal var cellType = CellType.Class(BaseCell.self)
    
    static internal func draw(cell: BaseCell, withItem item: Any) {    }
}

class TestItem: Item {
    internal var drawer: CellDrawer.Type = TestDrawer.self
}

class TableViewDataSourceTests: XCTestCase {
    
    private var tableViewManager: TableViewManager!
    private var item: Item!
    private var section: Section!
    
    override func setUp() {
        super.setUp()
        tableViewManager = TableViewManager(tableView: UITableView())
        item = TestItem()
        
        section = TestSection()
        section.items.append(item)
        
        tableViewManager.sections.append(section)

    }

    
    override func tearDown() {
        tableViewManager = nil
        item = nil
        super.tearDown()
    }
    
    func testCellForRow() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = self.tableViewManager.tableView(self.tableViewManager.tableView, cellForRowAtIndexPath: indexPath)
        
        expect(cell).to(beAnInstanceOf(BaseCell))
    }
    
    func testNumberOfSections() {
        let count = self.tableViewManager.numberOfSectionsInTableView(self.tableViewManager.tableView)
        expect(count).to(be(1))
    }
    
    func testNumberOfRowsInSection() {
        let count = self.tableViewManager.tableView(self.tableViewManager.tableView, numberOfRowsInSection: 0)
        expect(count).to(be(1))
    }
    
    func testTitleForHeaderInSection() {
        let title = self.tableViewManager.tableView(self.tableViewManager.tableView, titleForHeaderInSection: 0)!
        expect(HeaderFooterView.title(title)).to(equal(section.header))
    }
    
    func testTitleForFooterInSection() {
        let title = self.tableViewManager.tableView(self.tableViewManager.tableView, titleForFooterInSection: 0)!
        expect(HeaderFooterView.title(title)).to(equal(section.footer))
    }
    
    func testViewForHeaderInSection() {
        let view = self.tableViewManager.tableView(self.tableViewManager.tableView, viewForHeaderInSection: 0)
        expect(view).to(beNil())
    }
    
    func testViewForFooterInSection() {
        let view = self.tableViewManager.tableView(self.tableViewManager.tableView, viewForFooterInSection: 0)
        expect(view).to(beNil())
    }
    
    func testEstimatedHeightForRowAtIndexPath() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let height = self.tableViewManager.tableView(self.tableViewManager.tableView, estimatedHeightForRowAtIndexPath: indexPath)
        expect(height).to(equal(44.0))
    }
    
    
    func testHeightForRowAtIndexPath() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let height = self.tableViewManager.tableView(self.tableViewManager.tableView, heightForRowAtIndexPath: indexPath)
        expect(height).to(equal(UITableViewAutomaticDimension))
    }
    
}
