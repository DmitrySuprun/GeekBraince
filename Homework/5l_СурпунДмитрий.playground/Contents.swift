import UIKit
/*
1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

5. Создать несколько объектов каждого класса. Применить к ним различные действия.

6. Вывести сами объекты в консоль.
*/
// 1.
// Требования (протокол) для сущности автомобиль.
protocol Car {
    static var countOfCarProduced: Int {get set}
    var carBrand: String {get}
    var yearOfManufacture: Int {get}
    var trunkVolume: Int {get}
    var currentLevelInTrunk: Int {get set}
    var engineRun: Bool {get set}
    var windowsOpen: Bool {get set}
    var bodyVolume: BodyVolume {get}

    
    func makeAction (action: Action)
    func printStatus()
}
// Расширение для протокола открыть/закрыть окно, запустить/заглушить двигатель
extension Car {
    mutating func startStopEngine() {
        engineRun = !engineRun
        printStatus()
    }
    mutating func openCloseWindows() {
        windowsOpen = !windowsOpen
        printStatus()
    }
}

enum Action {
    case engineRun
    case engineStop
    case windowsOpen
    case windowsClosed
    case bodyLoad (volume: Int)
    case bodyUnload (volume: Int)
// для легкового:
    case roofOpen
    case roofClose
// для грузового:
    case lowerGearOn
    case lowerGearOff
}
enum BodyVolume : String {
    case full = "Полностью загружен"
    case empty = "Полностью разгружен"
    case readyToLoad = "Готов к загрузке"
}

// 3.

class SportsCar: Car {
    static var countOfCarProduced: Int = 0
    let carBrand: String
    var yearOfManufacture: Int
    var trunkVolume: Int
    var bodyVolume: BodyVolume
    var roofOpen: Bool
    var currentLevelInTrunk: Int = 0 {
        didSet {
            if currentLevelInTrunk >= trunkVolume {
                currentLevelInTrunk = trunkVolume
                bodyVolume = .full
                print(bodyVolume.rawValue)
            }
            if currentLevelInTrunk <= 0 {
                currentLevelInTrunk = 0
                bodyVolume = .empty
                print(bodyVolume.rawValue)
            } else {
                bodyVolume = .readyToLoad
            }
        }
    }
    var engineRun: Bool = false
    var windowsOpen: Bool = false
    
    func makeAction(action: Action) {
        switch action {
        case .engineRun : engineRun = true
        case .engineStop : engineRun = false
        case .windowsOpen : windowsOpen = true
        case .windowsClosed : windowsOpen = false
        case .bodyLoad(volume: let vol) :
            print("Загрузка")
            currentLevelInTrunk += vol
        case .bodyUnload(volume: let vol) :
            print("Разгрузка")
            currentLevelInTrunk -= vol
        case .roofOpen : roofOpen = true
        case .roofClose : roofOpen = false
        default : print ("Действие не поддерживается")
        }
// Любое действие с авто будем отражать в консоли
        printStatus()
    }
    func printStatus() {
        print("Марка: \(carBrand) год выпуска: \(yearOfManufacture)")
        print("Двигатель: \(engineRun ? "Работает" : "Заглушен")")
        print("Окна: \(windowsOpen ? "Открыты" : "Закрыты")")
        print("Емкость багажника: \(trunkVolume) Заполнено: \(currentLevelInTrunk)")
        print("Крыша: \(roofOpen ? "Открыта" : "Закрыта")")
        print("________________________________________________________")
    }
    init (carBrand: String, year: Int, trunkVolume: Int) {
        self.carBrand = carBrand
        self.yearOfManufacture = 1980...2021 ~= year ? year : 2021
        self.trunkVolume = trunkVolume
        self.roofOpen = false
        bodyVolume = .empty
        SportsCar.countOfCarProduced += 1
        print("Количество выпущенных легковых автомобилей\(SportsCar.countOfCarProduced)")
        printStatus()
    }
}

class TrunkCar: Car {
    static var countOfCarProduced: Int = 0
    let carBrand: String
    var yearOfManufacture: Int
    var trunkVolume: Int
    var currentLevelInTrunk: Int = 0 {
        didSet {
            if currentLevelInTrunk >= trunkVolume {
                currentLevelInTrunk = trunkVolume
                bodyVolume = .full
                print(bodyVolume.rawValue)
            }
            if currentLevelInTrunk <= 0 {
                currentLevelInTrunk = 0
                bodyVolume = .empty
                print(bodyVolume.rawValue)
            } else {
                bodyVolume = .readyToLoad
            }
        }
    }
    var engineRun: Bool = false
    var windowsOpen: Bool = false
    var bodyVolume: BodyVolume
    var lowerGear: Bool = false
    
    init (carBrand: String, year: Int, trunkVolume: Int) {
        self.carBrand = carBrand
        self.yearOfManufacture = 1980...2021 ~= year ? year : 2021
        self.trunkVolume = trunkVolume
        self.lowerGear = false
        bodyVolume = .empty
        TrunkCar.countOfCarProduced += 1
        print("Количество выпущенных грузовых автомобилей\(TrunkCar.countOfCarProduced)")
        printStatus()
    }
    
    func makeAction (action: Action) {
        switch action {
        case .engineRun : engineRun = true
        case .engineStop : engineRun = false
        case .windowsOpen : windowsOpen = true
        case .windowsClosed : windowsOpen = false
        case .bodyLoad(volume: let vol) :
            print("Загрузка")
            currentLevelInTrunk += vol
        case .bodyUnload(volume: let vol) :
            print("Разгрузка")
            currentLevelInTrunk -= vol
        case .lowerGearOn : lowerGear = true
        case .lowerGearOff : lowerGear = false
        default : print ("Действие не поддерживается")
        }
// Любое действие с авто будем отражать в консоли
        printStatus()
    }
    func printStatus() {
        print("Марка: \(carBrand) год выпуска: \(yearOfManufacture)")
        print("Двигатель: \(engineRun ? "Работает" : "Заглушен")")
        print("Окна: \(windowsOpen ? "Открыты" : "Закрыты")")
        print("Емкость кузова: \(trunkVolume) Заполнено: \(currentLevelInTrunk)")
        print("Пониженная передача: \(lowerGear ? "Включена" : "Выключена")")
        print("________________________________________________________")
    }
    
}

// 4.

extension SportsCar: CustomStringConvertible {
    var description: String {
        "Легковой автомобиль: \(carBrand)"
    }
}
extension TrunkCar: CustomStringConvertible {
    var description: String {
        "Грузовой автомобиль: \(carBrand)"
    }
}

// 5.
var ferrari = SportsCar(carBrand: "Ferra", year: 2020, trunkVolume: 100)

ferrari.makeAction(action: .bodyLoad(volume: 100))
ferrari.makeAction(action: .roofOpen)

var bigTruk = TrunkCar(carBrand: "MAC", year: 2010, trunkVolume: 10_000)
bigTruk.startStopEngine()
bigTruk.openCloseWindows()
bigTruk.makeAction(action: .bodyLoad(volume: 9_500))
bigTruk.makeAction(action: .bodyLoad(volume: 10_500))

// 6.
print(ferrari)
print(bigTruk)
