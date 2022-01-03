import UIKit

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

enum EngineError: Error {
    case overLoad
    case overHeat
    case outOfPowerRange(extraPower: Int)
}
class Engine {
    var power: Int
    var temperature: Double = 20
    var load: Int = 0
    var runningTime: Int = 0

    
    func energyProduction (load: Int, time: Int) throws -> Int {
// Нагрев двигателя прямопропорционален нагрузке и обратнопропорционален мощности
        let heating: Double = Double(load) / Double(power)
// Предельная нагрузка до 100 единиц
        guard load < 100 else {
            throw EngineError.overLoad
        }
// Вырабатываем энергию
        var energyOutput: Int = 0
        for _ in 0...time {
            energyOutput += load
            temperature += heating
            if temperature > 90 {
                throw EngineError.overHeat
            }
        }
        return energyOutput
    }
    
    init (powerOfEngine: Int) throws {
// Ограничиваем мощность двигателя от 1 до 100 единиц
        guard 1...100 ~= powerOfEngine else {
            throw EngineError.outOfPowerRange(extraPower: powerOfEngine - 100)
        }
        self.power = powerOfEngine
    }
}

print("Первый двигатель:")
var gaz = try? Engine(powerOfEngine: 70)
if let energy = try? gaz?.energyProduction(load: 10, time: 30) {
    print("Произвели \(energy) единиц энергии!")
} else {
    print("Не получилось завести двигатель")
}
print("____________________________")
print("Второй двигатель:")
do {
    let diesel = try Engine (powerOfEngine: 10)
    print("Выработано единиц энергии: ", try diesel.energyProduction(load: 80, time: 10))
} catch EngineError.overLoad {
    print("Перегрузка")
} catch EngineError.overHeat {
    print("Перегрев")
} catch EngineError.outOfPowerRange {
    print("Недопустимая мощность двагателя")
}
