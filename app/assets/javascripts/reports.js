$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#report_organization_unit_tree').treeview({
                data: response,
                showCheckbox: true,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $('#search_organization_unit').val(data.id)
                }
            });
        }
    });


    $("#search_equipment_name").change(function(e){
        var equipment_name = $(this).val()
        $.ajax({
            url: '/reports/load_models',
            data: {equipment_name: equipment_name},
            success: function(response){
                $('#model').html(response)
            }
        });
    })

});