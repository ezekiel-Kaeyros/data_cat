setTimeout(function() {
  var link = document.createElement('link');
  link.rel = 'stylesheet';
  link.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css';

  // Ajouter l'élément <link> au <head> de la page field-icon toggle-password
  document.head.appendChild(link);

  document.getElementById("auth-user_pwd").
                      innerHTML = '<span toggle="#auth-user_pwd" class="fa fa-eye"></span>';
}, 1000);

$(".toggle-password").click(function() {
  console.log("hello");
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $($(this).attr("toggle"));
    if (input.attr("type") == "password") {
        input.attr("type", "text");
        } else {
      input.attr("type", "password");
        }
});


