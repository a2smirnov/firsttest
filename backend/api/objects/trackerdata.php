<?php
class TrackerData {

    // подключение к базе данных и таблице 'covidcounter' 
    private $conn;
    private $table_name = "covidcounter";

    // свойства объекта 
    public $date_value;

    // конструктор для соединения с базой данных 
    public function __construct($db){
        $this->conn = $db;
    }

    // метод read() - получение данных
function read(){

    // выбираем все записи на указанную дату
    $query = "SELECT * FROM " . $this->table_name . " WHERE date_value=str_to_date(?, '%Y-%m-%d') ORDER BY deaths";

    // подготовка запроса 
    $stmt = $this->conn->prepare($query);

    // привязываем id товара, который будет обновлен 
    $stmt->bindParam(1, $this->date_value);

    // выполняем запрос 
    $stmt->execute();

    return $stmt;
}
// метод create - создание таблицы
function create(){

    // заглушка
    return true;
}
// метод update() - обновление данных в таблице
function update(){

    // заглушка
    return true;
}
// метод delete - удаление данных их таблицы 
function delete(){

    // заглушка
    return true;
}
}
?>