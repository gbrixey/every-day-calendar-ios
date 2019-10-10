import UIKit

final class CalendarDateControl: UIControl {

    // MARK: - Public

    let month: Int
    let day: Int

    var isFilled: Bool = false {
        didSet {
            updateColors()
        }
    }

    init(month: Int, day: Int) {
        self.month = month
        self.day = day
        super.init(frame: .zero)
        backgroundColor = .systemBackground
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

    private func createSubviews() {
        createCircleView()
        createLabel()
    }

    private func createCircleView() {
        circleView = UIView()
        circleView.isUserInteractionEnabled = false
        circleView.configureForAutoLayout()
        addSubview(circleView)
        circleView.autoCenterInSuperview()
        circleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        circleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
    }

    private func createLabel() {
        label = UILabel()
        label.configureForAutoLayout()
        label.font = .systemFont(ofSize: 12)
        label.text = "\(day)"
        addSubview(label)
        label.autoCenterInSuperview()
    }

    private func updateColors() {
        let backgroundColor: UIColor?
        let textColor: UIColor?
        if isFilled {
            backgroundColor = UIColor(named: "Date Control Background Selected")
            textColor = UIColor(named: "Date Control Text Selected")
        } else {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let currentYear = calendar.component(.year, from: today)
            let selfDate = calendar.date(from: DateComponents(year: currentYear, month: month, day: day))!
            if selfDate == today {
                backgroundColor = UIColor(named: "Date Control Background Present")
                textColor = UIColor(named: "Date Control Text Present")
            } else if selfDate < today {
                backgroundColor = UIColor(named: "Date Control Background Past")
                textColor = UIColor(named: "Date Control Text Past")
            } else {
                backgroundColor = UIColor(named: "Date Control Background Future")
                textColor = UIColor(named: "Date Control Text Future")
            }
        }
        circleView.backgroundColor = backgroundColor
        label.textColor = textColor
    }


}
