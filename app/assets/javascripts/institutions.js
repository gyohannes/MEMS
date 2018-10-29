$(function () {
    $.ajax({
        url: '/organization_structures/load_tree',
        success: function(response){
            $('#institution_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/institutions/load_institutions',
                        data: { node: data.id},
                        success: function (response) {
                            $('#institutions').html(response)
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