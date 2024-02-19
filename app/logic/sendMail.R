box::use(
  mailR,
  rJava
)

send_mail_login <- function(){
  mailR::send.mail(from = "datacat1@kaeyros-analytics.de",
                   to = "excel.sime@kaeyros-analytics.com",
                   subject = "Login in data-catalog",
                   body = "Une connexion viens d'etre effectuer sur l'app",
                   authenticate = TRUE,
                   smtp = list(host.name = "smtp.ionos.de",
                               port = 587,
                               user.name = "datacat1@kaeyros-analytics.de",
                               passwd = "Kaeyros-Analytics",
                               tls = TRUE),
                   send = TRUE)
}









