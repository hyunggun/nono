function setMainDataTable(tableIdx) {
    jQuery.extend( true, jQuery.fn.dataTable.defaults, {
        
    });

    jQuery(tableIdx).dataTable({
		buttons: [
          'copy', 'excel', 'pdf', 'print'
        ],
        "lengthMenu": [[10, 25, 50, -1], ["10개", "25개", "50개", "전체"]],
        dom:  "<'row be-datatable-header'<'col-sm-6'l><'col-sm-6 text-right'B>>" +
              "<'row be-datatable-body'<'col-sm-12'tr>>" +
              "<'row be-datatable-footer'<'col-sm-5'i><'col-sm-7'p>>"
	});
}