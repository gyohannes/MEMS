$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#report_organization_unit_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $('#search_organization_unit').val(data.id)
                    org_structure = $('#search_organization_unit').val()
                    $.ajax({
                        url:'/reports/load_facilities',
                        data: { organization_unit: data.id},
                        success: function (response) {
                            $('#facility_display').html(response)
                        }
                    })
                }
            });
        }
    });

});