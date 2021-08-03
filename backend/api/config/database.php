<?php
class Database {

    // учетные данные базы данных берем из файла конфигурации
    private $host;
    private $db_name;
    private $username;
    private $password;
    public $conn;

    // получаем соединение с БД 
    public function getConnection(){
        $config = parse_ini_file("../config/settings.ini", true);
        $this->conn = null;
        $this->host = $config[DB][host];
        $this->db_name = $config[DB][db_name];
        $this->username = $config[DB][username];
        $this->password = $config[DB][password];

        try {
            $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
            $this->conn->exec("set names utf8");
        } catch(PDOException $exception){
            echo "Connection error: " . $exception->getMessage();
        }

        return $this->conn;
    }
}
?>