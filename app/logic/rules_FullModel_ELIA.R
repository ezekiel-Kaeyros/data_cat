box::use(
  validate[validator],
)

# date <- c("2022-07-07", "2022-198")
# datas <- as.data.frame(date)
path <- file.path(getwd(), "app/data/rds/FullModel_ELIA_final.rds")
FullModel_ELIA_final <-readRDS(file = path)
#.file = "app/logic/rules/rules.r"
rules <- validate::validator(.file = "app/logic/rules/rule.R")

out <- validate::confront(FullModel_ELIA_final, rules, key="generatedAtTime") #### et mes identifiants sont mes dates

#validate::plot(out)
validate::summary(out)

validate::violating(FullModel_ELIA_final, out) ######### afficher les éléments qui ne respecte pas la règle

df <- validate::as.data.frame(out)
df
df2 <- df[df$name == "V1", ]
df2

