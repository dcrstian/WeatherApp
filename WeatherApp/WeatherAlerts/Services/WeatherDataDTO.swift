struct WeatherDTO: Decodable {
    private let features: [PropertiesDTO]
    
    func toDomainModel() -> WeatherData {
        let events = features.compactMap { feature in
            WeatherData.WeatherEvent(
                event: feature.properties.event,
                startDate: feature.properties.effective, 
                endDate: feature.properties.ends,
                source: feature.properties.senderName
            )
        }
        return WeatherData(events: events)
    }
    
    private struct PropertiesDTO: Decodable {
        let properties: EventDTO
    }

    private struct EventDTO: Decodable {
        let event: String
        let effective: String
        let ends: String?
        let senderName: String
    }
}
