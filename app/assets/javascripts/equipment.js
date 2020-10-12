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
                        beforeSend: function () { // Before we send the request, remove the .hidden class from the spinner and default to inline-block.
                            $('#loader').removeClass('hidden')
                        },
                        success: function (response) {
                            $('#equipment').html(response)
                            $('.js-exportable').DataTable({
                                responsive: true,
                                retrieve: true,
                                bootstrap: true,
                                dom: '<"html5buttons"B>lTfgtip',
                                buttons: ['colvis', 'copy', 'excel', 'print']
                            });
                        },
                        complete: function () { // Set our complete callback, adding the .hidden class and hiding the spinner.
                            $('#loader').addClass('hidden')
                        }
                    })
                }
            });
        }
    });

});