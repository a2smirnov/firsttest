<?php
//безопасное присвоение переменных среды
function safeinit($varname){
    if (isset($_ENV[$varname])) {
        return $_ENV[$varname];
	} else {
        return $varname;
        }
}
class Database {

    // учетные данные базы данных берем из переменных среды, осталные данные из ini-файла 
    private $host;
    private $db_name;
    private $username;
    private $password;
    public $conn;

    // получаем соединение с БД 
    public function getConnection(){
	if (isset($_ENV[ENV_TYPE])) {
        $config = parse_ini_file("../config/settings.".$_ENV[ENV_TYPE], true);
	} else {
        $config = parse_ini_file("../config/settings.ini", true);
        }
        $this->conn = null;
//        $this->host = safeinit("DB_HOST");
//        $this->db_name = safeinit("DB_NAME");
//        $this->username = safeinit("DB_USERNAME");
//        $this->password = safeinit("DB_PASSWORD");
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