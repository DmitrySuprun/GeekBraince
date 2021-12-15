import UIKit

struct SportsCar {
    static var countOfCarProduced: Int = 0
    let carBrand: String
    let yearOfManufacture: Int
    let trunkVolume: Int
    var currentLevelInTrunk: Int = 0 {
        didSet {
            if currentLevelInTrunk > trunkVolume {
                currentLevelInTrunk = trunkVolume
                BodyVolume.full
                print(BodyVolume.full.rawValue)
            }
            if currentLevelInTrunk <= 0 {
                currentLevelInTrunk = 0
                BodyVolume.empty
                print(BodyVolume.empty.rawValue)
            } else {
                BodyVolume.readyToLoad
            }
        }
    }
    var engineRun: Bool = false
    var windowsOpen: Bool = false
    enum Action {
        case enginRun
        case enginStop
        case windowsOpen
        case windowsClosed
        case bodyLoad (volume: Int)
        case bodyUnload (volume: Int)
    }
    enum BodyVolume : String {
        case full = "Багажник полный"
        case empty = "Багажник пустой"
        case readyToLoad = "Готов к загрузке"
    }
    mutating func makeAction (action: Action) {
        switch action {
        case .enginRun : engineRun = true
        case .enginStop : engineRun = false
        case .windowsOpen : windowsOpen = true
        case .windowsClosed : windowsOpen = false
        case .bodyLoad(volume: let vol) :
            print("Загрузка")
            currentLevelInTrunk += vol
        case .bodyUnload(volume: let vol) :
            print("Разгрузка")
            currentLevelInTrunk -= vol
        }
        printStatus()
    }
    func printStatus() {
        print("Марка: \(carBrand) год выпуска: \(yearOfManufacture)")
        print("Двигатель: \(engineRun ? "Работает" : "Заглушен")")
        print("Окна: \(windowsOpen ? "Открыты" : "Закрыты")")
        print("Емкость багажника: \(trunkVolume) Заполнено: \(currentLevelInTrunk)")
        print("________________________________________________________")

    }
    init(brand: String, year: Int, bodyVol: Int) {
        SportsCar.countOfCarProduced += 1
        print("Общее количество выпущенных легковых машин: \(SportsCar.countOfCarProduced)")
        carBrand = brand
        yearOfManufacture = 1980...2021 ~= year ? year : 2021
        trunkVolume = bodyVol
        BodyVolume.empty
        printStatus()
    }
}
struct TrunkCar {
    static var countOfCarProduced: Int = 0
    let carBrand: String
    let yearOfManufacture: Int
    let trunkVolume: Int
    var currentLevelInTrunk: Int = 0 {
        didSet {
            if currentLevelInTrunk > trunkVolume {
                currentLevelInTrunk = trunkVolume
                BodyVolume.full
                print(BodyVolume.full.rawValue)
            }
            if currentLevelInTrunk <= 0 {
                currentLevelInTrunk = 0
                BodyVolume.empty
                print(BodyVolume.empty.rawValue)
            } else {
                BodyVolume.readyToLoad
            }
        }
    }
    var engineRun: Bool = false
    var windowsOpen: Bool = false
    enum Action {
        case enginRun
        case enginStop
        case windowsOpen
        case windowsClosed
        case bodyLoad (volume: Int)
        case bodyUnload (volume: Int)
    }
    enum BodyVolume : String {
        case full = "Кузов полный"
        case empty = "Кузов пустой"
        case readyToLoad = "Готов к загрузке"
    }
    mutating func makeAction (action: Action) {
        switch action {
        case .enginRun : engineRun = true
        case .enginStop : engineRun = false
        case .windowsOpen : windowsOpen = true
        case .windowsClosed : windowsOpen = false
        case .bodyLoad(volume: let vol) :
            print("Загрузка")
            currentLevelInTrunk += vol
        case .bodyUnload(volume: let vol) :
            print("Разгрузка")
            currentLevelInTrunk -= vol
        }
        printStatus()
    }
    func printStatus() {
        print("Марка: \(carBrand) год выпуска: \(yearOfManufacture)")
        print("Двигатель: \(engineRun ? "Работает" : "Заглушен")")
        print("Окна: \(windowsOpen ? "Открыты" : "Закрыты")")
        print("Емкость кузова: \(trunkVolume) Заполнено: \(currentLevelInTrunk)")
        print("________________________________________________________")
    }
    init(brand: String, year: Int, bodyVol: Int) {
        TrunkCar.countOfCarProduced += 1
        print("Общее количество выпущенных грузовых машин: \(TrunkCar.countOfCarProduced)")
        carBrand = brand
        yearOfManufacture = 1980...2021 ~= year ? year : 2021
        trunkVolume = bodyVol
        BodyVolume.empty
        printStatus()
    }
}
var car1 = SportsCar(brand: "VW", year: 2010, bodyVol: 150)
var car2 = SportsCar(brand: "Audi", year: 2019, bodyVol: 170)
var car3 = TrunkCar(brand: "Volvo", year: 2015, bodyVol: 10000)
var car4 = TrunkCar(brand: "MB", year: 9999, bodyVol: 20000)
car1.makeAction(action: .enginRun)
car2.makeAction(action: .windowsOpen)
car3.makeAction(action: .bodyLoad(volume: 45))
car4.makeAction(action: .bodyLoad(volume: 25000))
car4.makeAction(action: .bodyUnload(volume: 4500))
car4.makeAction(action: .bodyUnload(volume: 20000))
car1.makeAction(action: .bodyLoad(volume: 35))
