import UIKit
/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.

 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

 6. Вывести значения свойств экземпляров в консоль.
 */

//  1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
class Car {
    
// При производстве авто будем подсчитывать их количество
    static var countOfCarProduced: Int = 0
    let carBrand: String
    let yearOfManufacture: Int
    let trunkVolume: Int
    
// Проверяем уловие максимального и минимального запролнения багажника
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
    
    enum BodyVolume : String {
        case full = "Полностью загружен"
        case empty = "Полностью разгружен"
        case readyToLoad = "Готов к загрузке"
    }
    
// Функциональная обработка действий с авто
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
        print("________________________________________________________")

    }
    init(brand: String, year: Int, bodyVol: Int) {
        Car.countOfCarProduced += 1
        print("Общее количество выпущенных автомобилей: \(Car.countOfCarProduced)")
        carBrand = brand
// Даем возможность указать год автомобиля только в заданном диапазоне
        yearOfManufacture = 1980...2021 ~= year ? year : 2021
        trunkVolume = bodyVol
        BodyVolume.empty
        printStatus()
    }
}
// 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
// Список действий в отношении авто
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

//  2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
class SportsCar: Car {
    static var countOfSportsCarProduced: Int = 0
    var roofOpen: Bool = false
    override func makeAction (action: Action) {
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
    override func printStatus() {
        print("Марка: \(carBrand) год выпуска: \(yearOfManufacture)")
        print("Двигатель: \(engineRun ? "Работает" : "Заглушен")")
        print("Окна: \(windowsOpen ? "Открыты" : "Закрыты")")
        print("Емкость багажника: \(trunkVolume) Заполнено: \(currentLevelInTrunk)")
        print("Крыша: \(roofOpen ? "Открыта" : "Закрыта")")
        print("________________________________________________________")
    }
    override init(brand: String, year: Int, bodyVol: Int) {
        SportsCar.countOfSportsCarProduced += 1
        print("Общее количество выпущенных легковых машин: \(SportsCar.countOfSportsCarProduced)")
        super.init(brand: brand, year: year, bodyVol: bodyVol)
    }
}
class TrunkCar: Car {
    static var countOfTrunkCarProduced: Int = 0
    var lowerGear: Bool = true
    override func makeAction (action: Action) {
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
    override func printStatus() {
        print("Марка: \(carBrand) год выпуска: \(yearOfManufacture)")
        print("Двигатель: \(engineRun ? "Работает" : "Заглушен")")
        print("Окна: \(windowsOpen ? "Открыты" : "Закрыты")")
        print("Емкость кузова: \(trunkVolume) Заполнено: \(currentLevelInTrunk)")
        print("Пониженная передача: \(lowerGear ? "Включена" : "Выключена")")
        print("________________________________________________________")
    }
    override init(brand: String, year: Int, bodyVol: Int) {
        TrunkCar.countOfTrunkCarProduced += 1
        print("Общее количество выпущенных грузовых машин: \(TrunkCar.countOfTrunkCarProduced)")
        super.init(brand: brand, year: year, bodyVol: bodyVol)
    }
}
// Легковые авто
var car1 = SportsCar(brand: "VW", year: 2010, bodyVol: 150)
var car2 = SportsCar(brand: "Audi", year: 2019, bodyVol: 170)
var car11 = SportsCar(brand: "Geely", year: 2020, bodyVol: 120)
// Грузовые авто
var car3 = TrunkCar(brand: "Volvo", year: 2015, bodyVol: 10000)
var car4 = TrunkCar(brand: "MB", year: 9999, bodyVol: 20000)
// Действия с автомобилями
car1.makeAction(action: .engineRun)
car2.makeAction(action: .windowsOpen)
car3.makeAction(action: .bodyLoad(volume: 45))
car4.makeAction(action: .bodyLoad(volume: 25000))
car4.makeAction(action: .bodyUnload(volume: 4500))
car4.makeAction(action: .bodyUnload(volume: 20000))
car1.makeAction(action: .bodyLoad(volume: 35))
car1.makeAction(action: .roofOpen)
car4.makeAction(action: .lowerGearOff)
