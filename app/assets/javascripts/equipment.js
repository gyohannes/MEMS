$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#equipment_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/equipment/load_equipment',
                        data: { node: data.id},
                        success: function (response) {
                            $('#equipment').html(response)
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