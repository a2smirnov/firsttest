jQuery(function($){

    // будет работать, если была нажата кнопка обновления 
    $(document).on('click', '.update-data-button', function(){

    // bootbox для подтверждения во всплывающем окне 
    bootbox.confirm({

    message: "<h4>Вы уверены?</h4>",
    buttons: {
        confirm: {
            label: '<span class="glyphicon glyphicon-ok"></span> Да',
            className: 'btn-danger'
        },
        cancel: {
            label: '<span class="glyphicon glyphicon-remove"></span> Нет',
            className: 'btn-primary'
        }
    },
    callback: function (result) {
        if (result==true) {

            // отправим запрос на обновление в API / удаленный сервер 
            $.ajax({
                url: "http://localhost:8081/api/trackerdata/update.php",
                type : "POST",
//                dataType : 'json',
//                data : JSON.stringify({ id: product_id }),
                success : function(result) {
        
                    // отображаем данные 
                    showProducts();
                },
                error: function(xhr, resp, text) {
                    console.log(xhr, resp, text);
                }
            });
        
        }    
    }
});
});
});