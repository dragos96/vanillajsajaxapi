$(document).ready(function () {


    var dialog, form,

        emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
        email = $("#email"),
        password = $("#password"),
        allFields = $([]).add(email).add(password),
        tips = $(".error-messages");

    function formMessages(t) {
        tips
            .text(t)
            .addClass("ui-state-highlight");
        setTimeout(function () {
            tips.removeClass("ui-state-highlight", 1500);
        }, 500);
    }

    function checkLength(o, n, min, max) {
        if (o.val().length > max || o.val().length < min) {
            o.addClass("ui-state-error");
            formMessages("Length of " + n + " must be between " +
                min + " and " + max + ".");
            return false;
        } else {
            return true;
        }
    }

    function checkRegexp(o, regexp, n) {
        if (!(regexp.test(o.val()))) {
            o.addClass("ui-state-error");
            formMessages(n);
            return false;
        } else {
            return true;
        }
    }

    function loginForm() {
        var valid = true;
        allFields.removeClass("ui-state-error");

        valid = valid && checkLength(email, "email", 6, 80);
        valid = valid && checkLength(password, "password", 3, 16);

        valid = valid && checkRegexp(email, emailRegex, "eg. ui@jquery.com");
        valid = valid && checkRegexp(password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9");

        if (valid) {
            console.log('VALID LOGIN');
            // TODO: check if email and password combination exists in db
            let dataPost = {
                email : email.val(),
                password : password.val()
            };
            console.log('seding: ', dataPost);
            $.ajax({

                type: "POST",
                url: `rest_controller.php?login=1`,
                data: JSON.stringify(dataPost),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            
                success: function(data){
                    console.log(data);
                },
                failure: function(errMsg) {
                    alert(errMsg);
                }
            
            });
            dialog.dialog("close");
        }
        return valid;
    }


    dialog = $("#dialog-form").dialog({
        autoOpen: false,
        height: 400,
        width: 350,
        modal: true,
        buttons: {
            "Login": loginForm,
            Cancel: function () {
                dialog.dialog("close");
            }
        },
        close: function () {
            form[0].reset();
            allFields.removeClass("ui-state-error");
        }
    });

    form = dialog.find("form").on("submit", function (event) {
        event.preventDefault();
        loginForm();
    });

    $("#login-button").button().on("click", function () {
        dialog.dialog("open");
    });
    $("#logout-button").button().on("click", function () {
        // dialog.dialog("open");
        $.ajax({
            url : 'rest_controller.php?logout=1',
            success : function(data){
                console.log('successfully logged out');
                console.log(data);
            }
        });
    });
});