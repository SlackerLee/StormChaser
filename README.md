# StormChaser

A comprehensive iOS weather application built with SwiftUI that provides real-time weather forecasts, storm tracking, and storm documentation capabilities. Perfect for weather enthusiasts and storm chasers who need detailed meteorological information on the go.

## Features

###  Weather Forecasting
- **7-Day Forecast**: Detailed weather predictions with temperature ranges
- **Real-time Updates**: Auto-refresh every 10 seconds for current conditions
- **Location-based**: Automatically detects your location for personalized forecasts
- **Weather Codes**: Comprehensive weather condition mapping

### Interactive Map
- **Location Visualization**: View your current location on an interactive map
- **City Information**: Display city names and timezone information
- **Navigation Integration**: Seamless navigation to map view

### Storm Tracking
- **Storm Detail View**: Detailed storm information with wind speed and precipitation data
- **Hourly Data**: Track storm progression with hourly updates
- **Geographic Coverage**: Monitor storms at your specific location

### Storm Documentation
- **Photo Capture**: Document storms with integrated camera functionality
- **Storm Records**: Save and manage storm documentation entries
- **Detail Viewing**: Review past storm documentation with full details
- **Form Management**: Easy-to-use forms for storm data entry

### User Experience
- **Dark/Light Mode**: Toggle between dark and light themes
- **Modern UI**: Clean, intuitive interface built with SwiftUI
- **Responsive Design**: Optimized for all iOS devices
- **Smooth Animations**: Fluid transitions and interactions

## Requirements

- **iOS**: 17.0 or later
- **Xcode**: 15.0 or later
- **Swift**: 5.9 or later
- **Device**: iPhone or iPad with GPS capabilities

## Installation & Setup

### Prerequisites
1. Install [Xcode](https://developer.apple.com/xcode/) from the Mac App Store
2. Ensure you have an Apple Developer account (free or paid)

### Opening the Project
1. **Clone or Download** the project to your local machine
2. **Open Xcode** and select "Open a project or file"
3. **Navigate** to the project folder and select `StormChaser.xcodeproj`
4. **Wait** for Xcode to index the project and resolve dependencies

### Running the App
1. **Select a Simulator** or **Connect your Device**:
   - For simulator: Choose an iOS simulator from the device menu
   - For device: Connect your iPhone/iPad via USB and select it
2. **Press ⌘+R** or click the **Run** button (▶️) in Xcode
3. **Wait** for the app to build and launch

### First Launch
- **Location Permission**: The app will request location access for weather data
- **Allow Location**: Grant permission to get weather for your current location
- **Explore Features**: Navigate through the different sections of the app

<!--## Project Structure-->
<!---->
<!--```-->
<!--StormChaser/-->
<!--├── StormChaser/-->
<!--│   ├── StormChaserApp.swift          # Main app entry point-->
<!--│   ├── ContentView.swift             # Main content view-->
<!--│   ├── managers/                     # Business logic managers-->
<!--│   │   ├── network/-->
<!--│   │   │   └── ForcastManager.swift  # Weather API integration-->
<!--│   │   ├── location/-->
<!--│   │   │   └── LocationManager.swift # GPS and location services-->
<!--│   │   ├── theme/-->
<!--│   │   │   └── AppThemeManager.swift # Dark/light mode management-->
<!--│   │   └── document/-->
<!--│   │       └── StormDocumentationManager.swift # Storm data management-->
<!--│   ├── models/                       # Data models-->
<!--│   │   ├── data/                     # Core data models-->
<!--│   │   ├── enum/                     # Enumerations-->
<!--│   │   └── network/                  # API response models-->
<!--│   ├── views/                        # SwiftUI views-->
<!--│   │   ├── components/               # Reusable UI components-->
<!--│   │   └── theme/                    # Theme-related views-->
<!--│   ├── Assets.xcassets/              # App icons and images-->
<!--│   └── StormChaser.xcdatamodeld/     # Core Data model-->
<!--├── StormChaserTests/                 # Unit tests-->
<!--└── StormChaserUITests/               # UI tests-->
<!--```-->

## Architecture

### Managers
- **ForecastManager**: Handles weather API calls and data processing
- **LocationManager**: Manages GPS location and city name resolution
- **AppThemeManager**: Controls dark/light mode state
- **StormDocumentationManager**: Manages storm documentation data

### Data Models
- **WeatherData**: Represents daily weather information
- **StormDetail**: Contains storm-specific data
- **StormDocumentation**: Stores user-created storm records

### Views
- **ContentView**: Main app interface with weather display
- **StormDetailView**: Detailed storm tracking interface
- **StormDocumentationListView**: List of saved storm documentation
- **MapView**: Interactive location map

<!--## API Integration-->
<!---->
<!--The app integrates with the [Open-Meteo API](https://open-meteo.com/) for weather data:-->
<!--- **Forecast Endpoint**: Provides 7-day weather forecasts-->
<!--- **Storm Data**: Hourly wind speed and precipitation data-->
<!--- **Geographic Coverage**: Global weather data support-->
<!---->
<!--## Testing-->
<!---->
<!--The project includes comprehensive testing:-->
<!--- **Unit Tests**: Test business logic and data models-->
<!--- **UI Tests**: Automated user interface testing-->
<!--- **Network Tests**: API integration testing-->
<!---->
<!--To run tests:-->
<!--1. Press **⌘+U** in Xcode-->
<!--2. Or select **Product > Test** from the menu-->
<!---->
<!--## Contributing-->
<!---->
<!--1. **Fork** the repository-->
<!--2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)-->
<!--3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)-->
<!--4. **Push** to the branch (`git push origin feature/AmazingFeature`)-->
<!--5. **Open** a Pull Request-->
<!---->
<!--## License-->
<!---->
<!--This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.-->
<!---->
<!--## Support-->
<!---->
<!--If you encounter any issues or have questions:-->
<!--1. Check the [Issues](https://github.com/yourusername/StormChaser/issues) page-->
<!--2. Create a new issue with detailed information-->
<!--3. Include device model, iOS version, and steps to reproduce-->
<!---->
<!--## Acknowledgments-->
<!---->
<!--- Weather data provided by [Open-Meteo](https://open-meteo.com/)-->
<!--- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)-->
<!--- Icons from [SF Symbols](https://developer.apple.com/sf-symbols/)-->
<!---->
<!------->

**StormChaser** - Your personal weather companion for storm tracking and documentation! 🌩️📱 
