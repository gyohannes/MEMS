$(function () {

    $("#user_role").change(function(){
        var role = $(this).val();
        var org_unit = $("#user_organization_unit_id").val();
        $.ajax({
            url: '/admin/users/load_departments',
            data: { role: role, org_unit: org_unit},
            cache: true,
            async: false,

            success: function(response){
                $('#department').html(response);
            }
        });
    });

    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#user_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/admin/users/load_users',
                        data: { node: data.id},
                        success: function (response) {
                            $('#users').html(response)
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