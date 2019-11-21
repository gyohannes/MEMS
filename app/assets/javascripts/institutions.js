$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
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