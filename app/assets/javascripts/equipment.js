$(function () {
    $.ajax({
        url: '/organization_structures/load_tree',
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
                                dom: 'lrBfrtip',
                                responsive: true,
                                buttons: [
                                    'copy', 'csv', 'excel', 'pdf', 'print'
                                ]
                            });
                        }
                    })
                }
            });
        }
    });

});