$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#facility_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/facilities/load_facilities',
                        data: { node: data.id},
                        success: function (response) {
                            $('#facilities').html(response)
                            $('.js-exportable').DataTable({
                                responsive: true,
                                retrieve: true,
                                bootstrap: true,
                                dom: '<"html5buttons"B>lTfgtip',
                                buttons: ['colvis', 'copy', 'excel', 'print']
                            });
                        }
                    })
                }
            });
        }
    });

});