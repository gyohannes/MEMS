$(function () {

    //Textare auto growth
    autosize($('textarea.auto-growth'));

    $('.colorpicker').minicolors({theme: 'bootstrap'});

    //Datetimepicker plugin
    $('.datetimepicker').bootstrapMaterialDatePicker({
        format: 'dddd DD MMMM YYYY - HH:mm',
        clearButton: true,
        weekStart: 1
    });

    $('.datepicker').bootstrapMaterialDatePicker({
        format: 'dddd DD MMMM YYYY',
        clearButton: true,
        weekStart: 1,
        time: false
    });

    $('.timepicker').bootstrapMaterialDatePicker({
        format: 'HH:mm',
        clearButton: true,
        date: false
    });

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
            right:  'month,listMonth,agendaWeek,agendaDay'
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
                    console.log(data)
                    $("#inventory_equipment_attributes_equipment_name_id").val(data[0].location)
                    $("#inventory_equipment_attributes_model").val(data[0].model)
                    $("#inventory_equipment_attributes_serial_number").val(data[0].serial_number)
                    $("#inventory_equipment_attributes_tag_number").val(data[0].tag_number)
                    $("#inventory_equipment_attributes_installation_date").val(data[0].installation_date)
                    $("#inventory_equipment_attributes_years_used").val(data[0].years_used)
                    $("#inventory_equipment_attributes_equipment_risk_classification").val(data[0].equipment_risk_classification)
                    $("#inventory_equipment_attributes_trained_end_users").prop('checked',data[0].trained_end_users)
                    $("#inventory_equipment_attributes_trained_technical_personnel").prop('checked', data[0].trained_technical_personnel)

                    $('select[name="store_registration[equipment_attributes][equipment_name_id]"]').val(data[0].equipment_name_id);
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
        minLength: 0,
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

    $("#training_contact_attributes_name").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/contacts/search",
                data: {term: request.term},
                success: function (data) {
                    response(data.map(function (contact) {return contact.name }));
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

    $('select').select2();

    $(function(){
        $("button:reset").click(function(){
            $("select").select2('val', 'All');
        });
    });

});
