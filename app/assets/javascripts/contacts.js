$(function () {
    $.ajax({
        url: '/organization_structures/load_tree',
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