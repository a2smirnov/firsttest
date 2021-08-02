<?php
class TrackerData {

    // подключение к базе данных и таблице 'covidcounter' 
    private $conn;
    private $table_name = "covidcounter";

    // свойства объекта 
    public $date_value;
    public $data_source;
    public $countries;

    // конструктор для соединения с базой данных 
    public function __construct($db){
        $this->conn = $db;
        $this->data_source = "https://covidtrackerapi.bsg.ox.ac.uk/api/v2/stringency/date-range/";
        $this->countries = array("RUS","USA");
    }

    // метод read() - получение данных
function read(){

    // выбираем все записи на указанную дату
    $query = "SELECT * FROM " . $this->table_name . " WHERE date_value=str_to_date(?, '%Y-%m-%d') ORDER BY deaths";

    // подготовка запроса 
    $stmt = $this->conn->prepare($query);

    // привязываем дату, за которую будем получать данные
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
    //читаем данные из https://covidtrackerapi.bsg.ox.ac.uk/api/v2/stringency/date-range/2021-05-20/2021-05-20
    $data_source_full = $this->data_source."/2021-05-20/2021-05-21";
    ini_set("allow_url_fopen", 1);
    $json = file_get_contents($data_source_full);
    $obj = json_decode($json);
    //Готовим запрос на вставку данных
    $query = "INSERT INTO `".$this->table_name."` (`date_value`, `country_code`, `confirmed`, `deaths`, `stringency_actual`, `stringency`) VALUES ";
        foreach ($obj->data as $data => $values) {
            foreach ($values as $country => $country_data) {
                if (in_array($country, $this->countries)) {
//                      var_dump($country_data);
//                    echo("Дата: ".$data." Страна: ".$country." Число смертей: ".$country_data->deaths);
                $query .= "('".$data."', '".$country."', ".$country_data->confirmed.", ".$country_data->deaths.", ".$country_data->stringency_actual.", ".$country_data->stringency."),";
                }
            }

      }
    //Удаляем лишнюю запятую в конце запроса
    $query = substr($query,0,-1);
//    var_dump($query);
    // подготовка запроса 
    $stmt = $this->conn->prepare($query);
    // выполняем запрос 
//    $stmt->execute();
// заглушка
//    var_dump($stmt);
    return $stmt->execute();
}
// метод delete - удаление данных их таблицы 
function delete(){
    //Готовим запрос на удаление данных
    $query = "DELETE FROM `".$this->table_name."`";
    // подготовка запроса 
    $stmt = $this->conn->prepare($query);

    // удаляем данные и возвращаем результат
    return $stmt->execute();
}
}
?>