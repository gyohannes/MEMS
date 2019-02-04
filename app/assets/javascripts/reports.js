$(function () {
    $.ajax({
        url: '/organization_structures/load_tree',
        success: function(response){
            $('#report_organization_structure_tree').treeview({
                data: response,
                levels: 0,
                onNodeSelected: function (event, data) {
                    $('#search_organization_structure').val(data.id)
                    org_structure = $('#search_organization_structure').val()
                    $.ajax({
                        url:'/reports/load_facilities',
                        data: { organization_structure: data.id},
                        success: function (response) {
                            $('#facility_display').html(response)
                        }
                    })
                }
            });
        }
    });

});