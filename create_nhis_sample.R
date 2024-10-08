library(tidyverse)

data<-
  read_csv("./data/nhis_00058.csv")|>
  janitor::clean_names()


zz<-
  data|>
  filter(age<100)|>
  mutate(
    sex=case_match(sex,1~"male",2~"female",.default = "unknown (did not provide)"),
    any_insurance=case_match(hinotcove,1~1,2~0),
    private_insurance=case_match(hiprivatee,1~0,c(2,3)~1),
    chip_insurance=case_match(hichipe,10~0,c(20,21,22)~1),
    mcaid_insurance=case_match(himcaide,1~0,c(2,3)~1),
    mcare_insurance=case_match(himcaree,1~0,c(2,3)~1),
  )|>
  summarize(
    pop=sum(sampweight,na.rm=T),
    across(ends_with("insurance"),~sum(.*sampweight,na.rm = T)),
    .by=c(year,age,sex)
  )|>
  mutate(
    across(ends_with("insurance"),~./pop)
  )|>
  arrange(year,age,sex)



