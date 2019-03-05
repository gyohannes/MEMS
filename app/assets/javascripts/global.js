$(function () {
    $('.js-exportable').DataTable({
        responsive: true,
        retrieve: true,
        dom: '<"html5buttons"B>lTfgtip',
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
    });

    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay,listMonth'
        },
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events: '/equipment/load_calendar'
    });

    $('.wysihtml5').wysihtml5({'toolbar': {'blockquote': false, 'html': true}})

    $( "#accordion" ).accordion({
        collapsible: true
    });

    $( "select" ).select2();


    // Populating equipment details based on selected equipment name
    // Used in store registration and training

    $("#inventory_equipment_attributes_inventory_number, #store_registration_equipment_attributes_inventory_number").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/equipment/facility_equipment_search",
                data: {term: request.term},
                success: function (data) {
                    response(data.map(function (equipment) {return equipment.inventory_number }));
                }
            });
        },
        select: function( event, ui ) {
            $.ajax({
                url: "/equipment/facility_equipment_search",
                data: {term: ui.item.value},
                success: function (data) {
                    $("#inventory_equipment_attributes_equipment_name").val(data[0].equipment_name)
                    $("#inventory_equipment_attributes_model").val(data[0].model)
                    $("#inventory_equipment_attributes_serial_number").val(data[0].serial_number)
                    $("#inventory_equipment_attributes_tag_number").val(data[0].tag_number)
                    $("#inventory_equipment_attributes_date_of_installation").val(data[0].date_of_installation)
                    $("#inventory_equipment_attributes_use_of_years").val(data[0].use_of_years)
                    $("#inventory_equipment_attributes_status").val(data[0].status)
                    $("#inventory_equipment_attributes_trained_end_users").prop('checked',data[0].trained_end_users)
                    $("#inventory_equipment_attributes_trained_maintenance_personnel").prop('checked', data[0].trained_maintenance_personnel)

                    $("#store_registration_equipment_attributes_equipment_name").val(data[0].equipment_name)
                    $("#store_registration_equipment_attributes_model").val(data[0].model)
                    $("#store_registration_equipment_attributes_serial_number").val(data[0].serial_number)
                    $("#store_registration_equipment_attributes_tag_number").val(data[0].tag_number)
                }
            });
        }
    })

    $("#training_equipment_name, #specification_equipment_name, #receive_equipment_name, #search_equipment_name").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/equipment/search",
                data: {term: request.term},
                success: function (data) {
                    response(data.map(function (equipment) {return equipment.equipment_name }));
                }
            });
        },
        select: function( event, ui ) {
            $.ajax({
                url: "/equipment/facility_equipment_search",
                data: {term: ui.item.value},
                success: function (data) {

                }
            });
        }
    })

    // Populating contact details based on selected contact name
    // Used in training

    $("#training_contact_attributes_name_of_contact").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/contacts/search",
                data: {term: request.term},
                success: function (data) {
                    response(data.map(function (contact) {return contact.name_of_contact }));
                }
            });
        },
        select: function( event, ui ) {
            $.ajax({
                url: "/contacts/search",
                data: {term: ui.item.value},
                success: function (data) {
                    $("#training_contact_attributes_profession").val(data[0].profession)
                    $("#training_contact_attributes_title").val(data[0].title)
                    $("#training_contact_attributes_work_place").val(data[0].work_place)
                    $("#training_contact_attributes_city").val(data[0].city)
                    $("#training_contact_attributes_phone_number").val(data[0].phone_number)
                    $("#training_contact_attributes_email").val(data[0].email)
                    $("#training_contact_attributes_country").val(data[0].country)
                }
            });
        }
    })

});