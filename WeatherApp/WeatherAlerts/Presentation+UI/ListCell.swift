import UIKit

class AlertCellView: UITableViewCell {
    lazy var eventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var intervalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var eventValue: UILabel = UILabel()
    lazy var startDateValue: UILabel = UILabel()
    lazy var sourceValue: UILabel = UILabel()
    
    lazy var endDateValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var intervalValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(weatherEvent: WeatherData.WeatherEvent) {
        eventLabel.text = "Event name: "
        startDateLabel.text = "Start Date: "
        endDateLabel.text = "End date: "
        sourceLabel.text = "Source: "
        intervalLabel.text = "Duration: "
        
        eventValue.text = weatherEvent.event
        startDateValue.text = weatherEvent.startDate.toDate()?.toFormattedDateString() ?? "Invalid Date"
        endDateValue.text = weatherEvent.endDate?.toDate()?.toFormattedDateString() ?? "Unknown"
        sourceValue.text = weatherEvent.source
        
        intervalValue.text = createInterval(startDate: weatherEvent.startDate, endDate: weatherEvent.endDate)
        
        contentView.addSubview(eventLabel)
        contentView.addSubview(eventValue)
        contentView.addSubview(startDateLabel)
        contentView.addSubview(startDateValue)
        contentView.addSubview(endDateLabel)
        contentView.addSubview(endDateValue)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(sourceValue)
        contentView.addSubview(intervalLabel)
        contentView.addSubview(intervalValue)
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventValue.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateValue.translatesAutoresizingMaskIntoConstraints = false
        sourceValue.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        intervalLabel.translatesAutoresizingMaskIntoConstraints = false
        intervalValue.translatesAutoresizingMaskIntoConstraints = false
        endDateValue.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        eventLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        displayValue(value: eventValue, anchorToLabel: eventLabel)
        
        displayLabel(label: startDateLabel, bottomAnchor: eventValue)
        displayValue(value: startDateValue, anchorToLabel: startDateLabel)
        
        displayLabel(label: endDateLabel, bottomAnchor: startDateLabel)
        displayValue(value: endDateValue, anchorToLabel: endDateLabel)
        
        displayLabel(label: sourceLabel, bottomAnchor: endDateLabel)
        displayValue(value: sourceValue, anchorToLabel: sourceLabel)
        
        displayLabel(label: intervalLabel, bottomAnchor: sourceLabel)
        displayValue(value: intervalValue, anchorToLabel: intervalLabel)
        
    }
    
    private func displayLabel(label: UILabel, bottomAnchor: UILabel) {
        let marginPadding: CGFloat = 10
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: marginPadding).isActive = true
        label.topAnchor.constraint(equalTo: bottomAnchor.bottomAnchor, constant: marginPadding).isActive = true
    }
    
    private func displayValue(value: UILabel, anchorToLabel: UILabel) {
        value.leadingAnchor.constraint(equalTo: anchorToLabel.trailingAnchor).isActive = true
        value.centerYAnchor.constraint(equalTo: anchorToLabel.centerYAnchor).isActive = true
    }
    
    private func createInterval(startDate: String, endDate: String?) -> String {
        guard let start = startDate.toDate() else {
            return "Invalid Start Date"
        }
        
        if let end = endDate?.toDate() {
            let interval = end.timeIntervalSince(start)
            return "\(Int(interval / 3600)) hours \(Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)) minutes"
        } else {
            return "Unknown"
        }
    }
}
