$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#organization_unit_tree').treeview({
                showCheckbox: true,
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/organization_units/load_sub_units',
                        data: { node: data.id, type: data.type},
                        success: function (response) {
                            $('#organization_unit').html(response)
                            $('.js-exportable').DataTable({
                                responsive: true,
                                dom: '<"html5buttons"B>lTfgtip',
                                buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
                            });
                        }
                    })
                }
            });
        }
    });

});