import UIKit

class WeatherAlertListViewController: UITableViewController {
    
    private let viewModel: WeatherAlertsViewModel
    
    init(viewModel: WeatherAlertsViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        Task {
            await fetchWeatherAlerts()
        }
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Weather Alerts"
        tableView.register(AlertCellView.self, forCellReuseIdentifier: "ListCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.weatherEvents.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? AlertCellView else {
            fatalError("ListCell is not defined!")
        }
        
        let event = viewModel.weatherEvents[indexPath.row]
        cell.configure(weatherEvent: event)
        
        return cell
    }
    
    private func fetchWeatherAlerts() async {
        await viewModel.fetchWeatherAlerts()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
