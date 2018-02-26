//
//  CalendarViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/19/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol CalendarProtocol {
    func newDateChoosed(newDate: Date?)
}

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UIBarButtonItem!
    
    var currentDate: Date!
    var delegate: CalendarProtocol?
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.0)
        calendarView.scrollToDate(currentDate,
                                  triggerScrollToDateDelegate: true,
                                  animateScroll: false,
                                  preferredScrollPosition: nil,
                                  extraAddedOffset: 0.0,
                                  completionHandler: nil)
        
        calendarView.register(UINib(nibName: CalendarCollectionViewCell.nibName, bundle: nil),
                              forCellWithReuseIdentifier: CalendarCollectionViewCell.cellID)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.newDateChoosed(newDate: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCollectionViewCell  else { return }
        handleCellTextColor(view: myCustomCell, cellState: cellState)
    }
    
    func handleCellTextColor(view: CalendarCollectionViewCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            view.set(selected: cellState.date.toStringDate() == currentDate.toStringDate())
        } else {
            view.set(selected: false)
            view.dayLabel.textColor = UIColor.gray
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        
        let month = Calendar.current.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        let year = Calendar.current.component(.year, from: startDate)
        monthLabel.title = "\(year) \(monthName)"
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCollectionViewCell.cellID, for: indexPath) as! CalendarCollectionViewCell
        
        cell.dayLabel.text = cellState.text
        configureCell(view: cell, cellState: cellState)
    
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let parameters = ConfigurationParameters(startDate: Date().yearsBefore,
                                                 endDate: Date().yearsAfter,
                                                 numberOfRows: nil,
                                                 calendar: nil,
                                                 generateInDates: nil,
                                                 generateOutDates: nil,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: nil)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        delegate?.newDateChoosed(newDate: date)
        dismiss(animated: true, completion: nil)
    }
    
}
