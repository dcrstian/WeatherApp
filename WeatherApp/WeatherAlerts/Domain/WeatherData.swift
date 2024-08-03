struct WeatherData {
    let events: [WeatherEvent]
    
    struct WeatherEvent {
        let event: String
        let startDate: String
        let endDate: String?
        let source: String
    }
}
