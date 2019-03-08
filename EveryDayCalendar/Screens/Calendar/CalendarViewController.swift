//
//  CalendarViewController.swift
//  EveryDayCalendar
//
//  Created by Glen Brixey on 3/8/19.
//  Copyright © 2019 Glen Brixey. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(currentYear)"
        scrollView.contentInsetAdjustmentBehavior = .always
        createDateButtons()
    }

    // MARK: - Actions

    @objc private func dateControlTapped(_ dateControl: CalendarDateControl) {
        dateControl.isFilled = !dateControl.isFilled
        let dateString = self.dateString(month: dateControl.month, day: dateControl.day)
        if dateControl.isFilled {
            filledDates.insert(dateString)
        } else {
            filledDates.remove(dateString)
        }
        saveFilledDates()
    }

    // MARK: - Private

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var contentStackView: UIStackView!

    private enum UserDefaultsKeys {
        static let year = "year"
        static let filledDates = "filledDates"
    }

    private lazy var filledDates: Set<String> = loadFilledDates()

    private lazy var currentYear: Int = {
        let calendar = Calendar.current
        return calendar.component(.year, from: Date())
    }()

    private func dateString(month: Int, day: Int) -> String {
        return "\(month)/\(day)"
    }

    private func createDateButtons() {
        for month in 1...12 {
            let monthStackView = UIStackView()
            monthStackView.axis = .vertical
            let daysInMonth = self.daysInMonth(month: month, year: currentYear)
            for day in 1...daysInMonth {
                let dateControl = createDateControl(month: month, day: day)
                monthStackView.addArrangedSubview(dateControl)
            }
            contentStackView.addArrangedSubview(monthStackView)
        }
    }

    private func createDateControl(month: Int, day: Int) -> CalendarDateControl {
        let dateControl = CalendarDateControl(month: month, day: day)
        dateControl.isFilled = filledDates.contains(dateString(month: month, day: day))
        dateControl.addTarget(self, action: #selector(dateControlTapped(_:)), for: .touchUpInside)
        dateControl.widthAnchor.constraint(equalTo: dateControl.heightAnchor).isActive = true
        return dateControl
    }

    private func daysInMonth(month: Int, year: Int) -> Int {
        switch month {
        case 2:
            return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 31
        }
    }

    private func loadFilledDates() -> Set<String> {
        let year = UserDefaults.standard.integer(forKey: UserDefaultsKeys.year)
        if year != currentYear {
            UserDefaults.standard.set(currentYear, forKey: UserDefaultsKeys.year)
            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.filledDates)
            return Set<String>()
        }
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.filledDates),
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let filledDates = object as? [String] else {
                return Set<String>()
        }
        return Set<String>(filledDates)
    }

    private func saveFilledDates() {
        let array = Array<String>(filledDates)
        guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else { return }
        UserDefaults.standard.set(data, forKey: UserDefaultsKeys.filledDates)
    }
}
