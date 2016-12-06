$(function() {

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


  $(".js-previous").on("click", function() {
    var nextId = parseInt($(".js-previous").attr("data-id")) - 1;
    var numberOfPastPlans = JSON.parse($(".js-pager").attr("data-past-plans")).length - 1;
    $.get("/plans/" + nextId + ".json", function(data) {
      $(".modal-title").text(`In ${prettifyMonth(data["date"])} you budgeted...`);

      var purchases = data["purchases"];
      var purchasesString = "";
      $.each(purchases, function(i, purchase) {
        purchasesString += `<p data-paymentid="${purchase["id"]}">` + "$" + `${purchase["price"]} ` + "for " + `${purchase["item"]} ` + "</p>";
      });
      $(".modal-body").html(purchasesString);
    });
    $(".js-pager").on("click", function() {
      if (numberOfPastPlans === 0) {
        $("#myModal").modal('hide');
      } else {
        numberOfPastPlans--;
        nextId--;
        $.get("/plans/" + nextId + ".json", function(data) {
          $(".modal-title").text(`In ${prettifyMonth(data["date"])} you budgeted...`);
          var purchases = data["purchases"];
          var purchasesString = "";
          $.each(purchases, function(i, purchase) {
            purchasesString += `<p data-paymentid="${purchase["id"]}">` + "$" + `${purchase["price"]} ` + "for " + `${purchase["item"]} ` + "</p>";
          });
          $(".modal-body").html(purchasesString);
        });
      }
    });
  });
});
