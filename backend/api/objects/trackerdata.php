<?php
class TrackerData {

    // подключение к базе данных и таблице 'covidcounter' 
    private $conn;
    private $table_name;
    private $db_engine;
    private $db_encoding;
    private $data_source;
    private $countries;

    public $date_value;

    // конструктор для соединения с базой данных 
    public function __construct($db){
        $config = parse_ini_file("../config/settings.ini", true);
        $this->conn = $db;
        $this->table_name = $config[DB][table_name];
        $this->db_engine = $config[DB][engine];
        $this->db_charset = $config[DB][charset];
        $this->data_source = $config[API][data_source];
        $this->countries = $config[API][countries];
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
    //Готовим запрос на создание таблицы
    $query = "CREATE TABLE `".$this->table_name."` ( ";
    $query.="id integer NOT NULL AUTO_INCREMENT, ";
    $query.="`date_value` date NOT NULL, ";
    $query.="`country_code` char(3) NOT NULL, ";
    $query.="`confirmed` integer NOT NULL, ";
    $query.="`deaths` integer NOT NULL, ";
    $query.="`stringency_actual` float, ";
    $query.="`stringency` float, ";
    $query.="`modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, ";
    $query.="PRIMARY KEY (`id`), ";
    $query.="INDEX stat_by_country (date_value,country_code) ";
    $query.=") ENGINE=".$this->db_engine." DEFAULT CHARSET=".$this->db_charset;
    // подготовка запроса 
    $stmt = $this->conn->prepare($query);

    // создаем таблицу и возвращаем результат
    return $stmt->execute();
}
// метод update() - обновление данных в таблице
function update(){
    //удаляем существующие данные перед обновлением
    $this->delete();
    //читаем данные из api
    $data_source_full = $this->data_source."/2021-05-20/2021-05-21";
    ini_set("allow_url_fopen", 1);
    $json = file_get_contents($data_source_full);
    $obj = json_decode($json);
    //Готовим запрос на вставку данных
    $query = "INSERT INTO `".$this->table_name."` (`date_value`, `country_code`, `confirmed`, `deaths`, `stringency_actual`, `stringency`) VALUES ";
        foreach ($obj->data as $data => $values) {
            foreach ($values as $country => $country_data) {
                if (in_array($country, $this->countries)) {
                $query .= "('".$data."', '".$country."', ".$country_data->confirmed.", ".$country_data->deaths.", ".$country_data->stringency_actual.", ".$country_data->stringency."),";
                }
            }

      }
    //Удаляем лишнюю запятую в конце запроса
    $query = substr($query,0,-1);
    // подготовка запроса 
    $stmt = $this->conn->prepare($query);
    // выполняем запрос 
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