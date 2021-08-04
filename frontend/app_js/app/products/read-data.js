jQuery(function($){

    // показать список товаров при первой загрузке 
    showProducts();
    // при нажатии кнопки 
    $(document).on('click', '.read-data-button', function(){
        showProducts();
    });

});

// функция для показа списка товаров 
function showProducts(){

    read_data_html=`
    <!-- кнопки 'действий' -->
    <!-- кнопка обновления данных -->
        <button class='btn btn-primary update-data-button'>
            <span class='glyphicon glyphicon-edit'></span> Обновление
        </button>
    <!-- кнопка удаления данных -->
        <button class='btn btn-danger m-r-10px delete-data-button'>
            <span class='glyphicon glyphicon-remove'></span> Удаление
        </button>`;
    $("#page-content").html(read_data_html);

    // получить данные на дату из API 
    var reqested_date = '2021-08-01';
//    alert(config.api_url+"read.php?requested_date=" + reqested_date);
    $.getJSON(config.api_url+"read.php?requested_date=" + reqested_date, function(data){
    // html for listing products 
        // перебор списка возвращаемых данных 
        var temp=`<!-- начало таблицы -->
        <table class='table table-bordered table-hover'>
        
            <!-- создание заголовков таблицы -->
            <tr>
                <th class='w-15-pct'>Дата</th>
                <th class='w-15-pct'>Код страны</th>
                <th class='w-10-pct'>Подтвержденных случаев</th>
                <th class='w-15-pct'>Смертей</th>
            </tr>`;
        $.each(data.records, function(key, val) {
        // создание новой строки таблицы для каждой записи 
        temp+=`
        <tr>

            <td>` + val.date_value + `</td>
            <td>` + val.country_code + `</td>
            <td>` + val.confirmed + `</td>
            <td>` + val.deaths + `</td>
        </tr>`;
        });

        // вставка в 'page-content' нашего приложения 
        read_data_html+=temp;
        read_data_html+=`</table>`;
        $("#page-content").html(read_data_html);
    });
      // изменяем заголовок страницы 
      changePageTitle("Данные трекера");


}