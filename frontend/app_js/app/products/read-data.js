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
    // получить список товаров из API 
    $.getJSON("http://localhost:8081/api/trackerdata/read.php", function(data){
    // html for listing products 
    var read_products_html=`
    <!-- при нажатии загружается форма создания продукта -->
    <div id='create-product' class='btn btn-primary pull-right m-b-15px create-product-button'>
        <span class='glyphicon glyphicon-plus'></span> Обновление данных
    </div>

    <!-- кнопки 'действий' -->
        <!-- кнопка чтения товара -->
        <button class='btn btn-primary m-r-10px read-one-product-button'>
            <span class='glyphicon glyphicon-eye-open'></span> Просмотр
        </button>

        <!-- кнопка удаления данных -->
        <button class='btn btn-danger m-r-10px delete-data-button'>
            <span class='glyphicon glyphicon-remove'></span> Удаление
        </button>

        <!-- кнопка обновления данных -->
        <button class='btn btn-danger update-data-button'>
            <span class='glyphicon glyphicon-edit'></span> Обновление
        </button>

    <!-- начало таблицы -->
    <table class='table table-bordered table-hover'>
    
        <!-- создание заголовков таблицы -->
        <tr>
            <th class='w-15-pct'>Дата</th>
            <th class='w-15-pct'>Код страны</th>
            <th class='w-10-pct'>Подтвержденных случаев</th>
            <th class='w-15-pct'>Смертей</th>
        </tr>`;



    
            // перебор списка возвращаемых данных 
    $.each(data.records, function(key, val) {

    // создание новой строки таблицы для каждой записи 
        read_products_html+=`
        <tr>

            <td>` + val.date_value + `</td>
            <td>` + val.country_code + `</td>
            <td>` + val.confirmed + `</td>
            <td>` + val.deaths + `</td>
        </tr>`;
        });
        // конец таблицы 
        read_products_html+=`</table>`;
        // вставка в 'page-content' нашего приложения 
        $("#page-content").html(read_products_html);
        // изменяем заголовок страницы 
        changePageTitle("Данные трекера");


        
    });

}