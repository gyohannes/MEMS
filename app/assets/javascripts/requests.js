$(function () {
    $("select[name$='[requested_to]']").change(function(){
        var request_to = $(this).val();
        if (request_to == 'org_unit') {
            $('#request_to_org_structure').show()
            $("#request_to_facility").hide()
            $('#request_to_institution').hide()
        } else if (request_to == 'facility') {
            $('#request_to_org_structure').hide()
            $('#request_to_facility').show()
            $('#request_to_institution').hide()
        } else if (request_to == 'institution') {
            $('#request_to_org_structure').hide()
            $('#request_to_facility').hide()
            $('#request_to_institution').show()
        }
    });
        $.ajax({
            url: '/organization_structures/load_tree',
            success: function(response){
                $('#request_org_tree').treeview({
                    data: response,
                    levels: 1,
                    onNodeSelected: function (event, data) {
                        $("select[name$='[requested_to_org_structure]']").val(data.id);
                    }
                });
            }
        });
        $.ajax({
            url: '/organization_structures/load_facility_tree',
            success: function (response) {
                $('#request_facility_tree').treeview({
                    data: response,
                    levels: 1,
                    onNodeSelected: function (event, data) {
                        if (data.type == 'facility') {
                            $("select[name$='[requested_to_facility]']").val(data.id);
                        }
                    }
                });
            }
        });

    if ($("select[name$='[requested_to]']").val() == 'org_unit') {
        $('#request_to_org_structure').show()
        $('#request_to_facility').hide()
        $('#request_to_institution').hide()
    } else if ($("select[name$='[requested_to]']").val() == 'facility'){
        $('#request_to_org_structure').hide()
        $('#request_to_facility').show()
        $('#request_to_institution').hide()
    } else if ($("select[name$='[requested_to]']").val() == 'institution'){
        $('#request_to_org_structure').hide()
        $('#request_to_facility').hide()
        $('#request_to_institution').show()
    }
});