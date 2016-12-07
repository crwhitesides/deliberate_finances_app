function Purchase(attributes) {
  this.price = attributes.price;
  this.item = attributes.item;
  this.id = attributes.id;
}

$(function() {
  Purchase.templateSource = $("#purchase-template").html();
  Purchase.template = Handlebars.compile(Purchase.templateSource);
});

Purchase.prototype.renderLi = function() {
  return Purchase.template(this)
}

$(function() {
  // Accessing prior months' purchase details via AJAX (using modal)
  $('#myModal').on('hidden.bs.modal', function () {
    location.reload();
  });

  function prettifyMonth(date) {
    var rawDate = new Date(date);
    var month = [];
    month[0] = "January";
    month[1] = "February";
    month[2] = "March";
    month[3] = "April";
    month[4] = "May";
    month[5] = "June";
    month[6] = "July";
    month[7] = "August";
    month[8] = "September";
    month[9] = "October";
    month[10] = "November";
    month[11] = "December";

    return month[rawDate.getMonth()];
  }

  function previousPlanInfo(id) {
    $.get("/plans/" + id + ".json", function(data) {
      $(".modal-title").text(`In ${prettifyMonth(data["date"])} you budgeted...`);

      var purchases = data["purchases"];
      var purchasesString = "";
      $.each(purchases, function(i, purchase) {
        purchasesString += `<p data-paymentid="${purchase["id"]}">` + "$" + `${purchase["price"]} ` + "for " + `${purchase["item"]} ` + "</p>";
      });
      $(".modal-body").html(purchasesString);
    });
  }

  $(".js-previous").on("click", function() {
    var nextId = parseInt($(".js-previous").attr("data-id")) - 1;
    var numberOfPastPlans = JSON.parse($(".js-pager").attr("data-past-plans")).length - 1;
    previousPlanInfo(nextId);
    console.log(nextId, numberOfPastPlans)
    $(".js-pager").on("click", function() {
      if (numberOfPastPlans === 0) {
        $("#myModal").modal('hide');
      } else {
        numberOfPastPlans--;
        nextId--;
        previousPlanInfo(nextId);
      }
    });
  });

  // Submit Purchases via AJAX
  $("#new_purchase").on("submit", function(e) {
    var $form = $(this);
    var url = $form.attr("action");
    var data = $form.serialize();

    $.ajax({
      method: $form.attr("method"),
      url: url,
      data: data,
      dataType: "json",
      success: function(response) {
        $(".form-control").val("");

        var purchase = new Purchase(response);
        var purchaseLi = purchase.renderLi();

        $("ol.unpaid").append(purchaseLi);
      }
    });
    e.preventDefault();
  });

});
