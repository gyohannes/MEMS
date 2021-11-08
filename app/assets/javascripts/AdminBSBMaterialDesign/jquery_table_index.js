$(function () {
    $('.js-basic-example').DataTable({
        responsive: true
    });

    //Exportable table
    $('.js-exportable').DataTable({
        responsive: true,
        colReorder: true,
        retrieve: true,
        bootstrap: true,
        dom: '<"html5buttons"B>lTfgtip',
        buttons: ['colvis',
            {
                extend: 'excelHtml5',
                footer: true,
                exportOptions: {
                    columns: ':visible'
                }
            },
            {
                extend: 'copy',
                footer: true,
                exportOptions: {
                    columns: ':visible'
                }
            }
        ]
    });
});