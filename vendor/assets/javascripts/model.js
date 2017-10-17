function addTask() {
    var modal = document.getElementById("Add_Task_Modal");
    modal.style.display = "block";
    var span_alert = document.getElementsByClassName("span_close_alert")[0];
    var btn_close_alert = document.getElementsByClassName("btn_close_alert")[0];
    btn_close_alert.onclick = function () {
        modal.style.display = "none";
    }
                // When the user clicks on <span> (x), close the modal
                span_alert.onclick = function () {
                    modal.style.display = "none";
                }
                // When the user clicks anywhere outside of the modal, close it
                window.onclick = function (event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            }
