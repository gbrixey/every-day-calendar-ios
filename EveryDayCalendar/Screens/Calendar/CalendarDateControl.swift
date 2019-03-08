//
//  CalendarDateButton.swift
//  EveryDayCalendar
//
//  Created by Glen Brixey on 3/8/19.
//  Copyright © 2019 Glen Brixey. All rights reserved.
//

import UIKit

final class CalendarDateControl: UIControl {

    // MARK: - Public

    let month: Int
    let day: Int

    var isFilled: Bool = false {
        didSet {
            circleView.backgroundColor = circleBackgroundColor
        }
    }

    init(month: Int, day: Int) {
        self.month = month
        self.day = day
        super.init(frame: .zero)
        backgroundColor = .white
        createSubviews()
    }

    // MARK: - Overrides

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported for CalendarDateControl")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }

    // MARK: - Private

    private var circleView: UIView!
    private var label: UILabel!

    private var circleBackgroundColor: UIColor {
        if isFilled {
            return Colors.yellow
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let currentYear = calendar.component(.year, from: today)
        let selfDate = calendar.date(from: DateComponents(year: currentYear, month: month, day: day))!
        if selfDate == today {
            return Colors.blue
        } else if selfDate < today {
            return Colors.gray
        } else {
            return .white
        }
    }

    private func createSubviews() {
        createCircleView()
        createLabel()
    }

    private func createCircleView() {
        circleView = UIView()
        circleView.isUserInteractionEnabled = false
        circleView.configureForAutoLayout()
        circleView.backgroundColor = circleBackgroundColor
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.black.cgColor
        addSubview(circleView)
        circleView.autoCenterInSuperview()
        circleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        circleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
    }

    private func createLabel() {
        label = UILabel()
        label.configureForAutoLayout()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.text = "\(day)"
        addSubview(label)
        label.autoCenterInSuperview()
    }
}
