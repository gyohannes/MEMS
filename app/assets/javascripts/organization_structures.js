$(function () {
    $.ajax({
        url: '/organization_structures/load_tree',
        success: function(response){
            $('#organization_structure_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/organization_structures/load_sub_units',
                        data: { node: data.id, type: data.type},
                        success: function (response) {
                            $('#organization_structure').html(response)
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