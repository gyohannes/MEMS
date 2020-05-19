$(function () {
    $.ajax({
        url: '/organization_units/load_all_tree',
        success: function(response){
            $('#contact_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/contacts/load_contacts',
                        data: { node: data.id},
                        success: function (response) {
                            $('#contacts').html(response)
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