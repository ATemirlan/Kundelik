//
//  CalendarViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/19/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setTitleColor(Constants.Color.redColor, for: .normal)
    }

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
//        guard let startDate = visibleDates.monthDates.first?.date else {
//            return
//        }
//
//        let month = Calendar.current.dateComponents([.month], from: startDate).month!
//        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
//        let year = Calendar.current.component(.year, from: startDate)
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else { return }
        handleCellTextColor(view: myCustomCell, cellState: cellState)
    }
    
    func handleCellTextColor(view: CellView, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            view.dayLabel.textColor = UIColor.black
        } else {
            view.dayLabel.textColor = UIColor.gray
        }
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as! CellView
        
        cell.dayLabel .text = cellState.text
        configureCell(view: cell, cellState: cellState)
    
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2030 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        calendarView.viewWillTransition(to: size, with: coordinator, anchorDate: Date())
        print("transition")
    }
    
}
