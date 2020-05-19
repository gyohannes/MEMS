$(function () {
    $('.js-basic-example').DataTable({
        responsive: true
    });

    //Exportable table
    $('.js-exportable').DataTable({
        responsive: true,
        retrieve: true,
        bootstrap: true,
        dom: '<"html5buttons"B>lTfgtip',
        buttons: ['colvis', 'copy', 'excel', 'print']
    });
});