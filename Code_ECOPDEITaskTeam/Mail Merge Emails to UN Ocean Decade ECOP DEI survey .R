###Mail Merge for ECOP DEI


##FIRST EMAIL----
# Install packages if needed
# install.packages(c("gmailr", "glue", "readr"))

library(gmailr)
library(glue)
library(readr)

# === 1. Configure OAuth Client Secret and Authenticate ===

client_secret_path <- "/Users/erinsatterthwaite/Downloads/client_secret_663185582409-cqek7rt9dmmnaq8qt2m4lr19k1an5nuv.apps.googleusercontent.com.json"

gm_auth_configure(path = client_secret_path)

gm_auth(scopes = "https://mail.google.com/")


gm_profile()


# === 2. Read your contacts CSV ===

dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts.csv")

# For testing, you can subset a few rows
#dffinal <- dffinal[1, ]
View(dffinal)

# === 3. Email subject ===

subject <- "Invitation to contribute to survey on diversity, equity, and inclusion in the UN Ocean Decade by Jul 23rd"

# === 4. Loop over rows and send emails ===

for (i in seq_len(nrow(dffinal))) {
  email <- dffinal$Email[i]
  firstname <- ifelse(is.na(dffinal$FirstName[i]) || dffinal$FirstName[i] == "", "Ocean Decade colleague", dffinal$FirstName[i])
  proposal <- dffinal$`Name of the Proposal`[i]
  
  body <- glue('
 <p>Dear {firstname},</p>

<p>We wanted to reach out to you since you are a key lead on the Decade Action, <i>{proposal}</i>. We want to understand the strategies, challenges, and opportunities for diverse engagement across Decade Actions. <b>Our very brief survey should take between 5 - 10 minutes to complete, and we would sincerely appreciate your response by Jul 23rd. Please also feel free to pass it along to anyone else who you think can fill it out on behalf of your Decade Action.</b></p>

<p><b>Please find the survey link here: <a href="https://forms.gle/iiwiwQKM7Awruemz8">https://forms.gle/iiwiwQKM7Awruemz8</a></b></p>

<p>We welcome all responses—whether or not your Decade Action is explicitly focused on diversity, equity, and inclusion. Understanding a range of experiences, opportunities, and barriers is essential to shaping inclusive strategies in the Decade.</p>

<p>Thank you in advance for your time and for contributing to a more inclusive and equitable ocean science community!</p>

<p>Best regards,<br>
ECOP DEI Task Team</p>
  ')
  
  email_message <- gm_mime() %>%
    gm_to(email) %>%
    gm_from("deiecopdecade@gmail.com") %>%
    gm_subject(subject) %>%
    gm_html_body(body)   # Use HTML body for clickable links
  
  # Send the email
  gm_send_message(email_message)
  
  print(glue("Sent email to {firstname} at {email}"))
}


##SECOND EMAIL ----
# Install packages if needed
# install.packages(c("gmailr", "glue", "readr"))

library(gmailr)
library(glue)
library(readr)

# === 1. Configure OAuth Client Secret and Authenticate ===

client_secret_path <- "/Users/erinsatterthwaite/Downloads/client_secret_663185582409-cqek7rt9dmmnaq8qt2m4lr19k1an5nuv.apps.googleusercontent.com.json"

gm_auth_configure(path = client_secret_path)

gm_auth(scopes = "https://mail.google.com/")


gm_profile()


# === 2. Read your contacts CSV ===
#note broke into 3 chunks because there were a few non emails that stopped the code
#dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced.csv")
#dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced2.csv")
#dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced3.csv")
#dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced4.csv")
#dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced5.csv")
#dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced6.csv")
dffinal <- read_csv("/Users/erinsatterthwaite/Desktop/DEI_contacts_reduced7.csv")

# For testing, you can subset a few rows
View(dffinal)

# === 3. Email subject ===

subject <- "Friendly reminder to contribute your insight to DEI ECOP survey on diverse engagement in the UN Ocean Decade by Jul 23rd"

# === 4. Loop over rows and send emails ===

for (i in seq_len(nrow(dffinal))) {
  email <- dffinal$Email[i]
  firstname <- ifelse(is.na(dffinal$FirstName[i]) || dffinal$FirstName[i] == "", "Ocean Decade colleague", dffinal$FirstName[i])
  proposal <- dffinal$`Name of the Proposal`[i]
  
  body <- glue( 'Dear {firstname},
 <br>This is a friendly reminder that if you are able, we would greatly appreciate your insight given your involvement in the Decade Action, <i>{proposal}</i>, by filling out our very brief survey exploring diverse engagement in the UN Ocean Decade.
<b>The survey takes just 5–10 minutes to complete, and we kindly ask for responses by <strong>July 23rd</strong>.</b>
<br>
<b>Survey link: <a href="https://forms.gle/iiwiwQKM7Awruemz8">https://forms.gle/iiwiwQKM7Awruemz8</a></b></p>
<p>
Thank you in advance for your time and for contributing to a more inclusive ocean science community!</p>
<p>
<p>Best regards,
<br>DEI ECOP Task Team
<br>Webpage: https://www.ecopdecade.org/diversity-equity-and-inclusivity/</p>

<p><i>P.S. If you’ve already filled the survey out - thank you! - and please feel free to disregard this message.</i></p>
')
  
  email_message <- gm_mime() %>%
    gm_to(email) %>%
    gm_from("deiecopdecade@gmail.com") %>%
    gm_subject(subject) %>%
    gm_html_body(body)   # Use HTML body for clickable links
  
  # Send the email
  gm_send_message(email_message)
  
  print(glue("Sent email to {firstname} at {email}"))
  
  Sys.sleep(6)
}












### -- OLD----
install.packages('googlesheets4')
install.packages('emayili')

library(googlesheets4)
library(emayili)
library(tidyverse)  # loads dplyr, purrr, stringr, etc.

gs4_auth()

sheet_url <- "https://docs.google.com/spreadsheets/d/10qLU3z5dtuhxKApgmDwWAs2QXR3CItMrq2OA8qxEZy8/edit?gid=1512313628#gid=1512313628"
data <- read_sheet(sheet_url, sheet = 1)


colnames(data)

library(dplyr)
library(tidyr)
library(stringr)
library(purrr)

# Helper function to pad vectors to equal length
pad_equal_length <- function(x, y) {
  max_len <- max(length(x), length(y))
  length(x) <- max_len
  length(y) <- max_len
  list(x, y)
}

df_cleaned <- data %>%
  mutate(
    ContactList = str_split(`Lead Contact`, "\\s*[,;]\\s*"),
    EmailList = str_split(`Lead Contact Email Address`, "\\s*[,;]\\s*"),
    PaddedLists = map2(ContactList, EmailList, pad_equal_length),
    ContactEmailPairs = map(PaddedLists, ~ tibble(Contact = .x[[1]], Email = .x[[2]]))
  ) %>%
  select(-ContactList, -EmailList, -PaddedLists) %>%
  unnest_longer(ContactEmailPairs) %>%
  unnest_wider(ContactEmailPairs) %>%
  mutate(
    CleanName = str_remove(Contact, regex("^(Dr|Mr|Ms|Mrs|Prof)\\.?(\\s+)", ignore_case = TRUE)),
    FirstName = word(CleanName, 1),
    FirstName = if_else(is.na(FirstName) | FirstName == "", "Ocean Decade colleague", FirstName)
  ) %>%
  filter(!is.na(Email), Email != "") %>%
  select(`Name of the Proposal`, FirstName, Email)

View(df_cleaned)



write_csv(df_cleaned, "contacts_export_FINAL.csv")




for (i in 1:nrow(df_test)) {
  email <- df_test$Email[i]
  firstname <- ifelse(is.na(df_test$FirstName[i]), "Ocean Decade colleague", df_test$FirstName[i])
  proposal <- df_test$`Name of the Proposal`[i]
  
  subject <- "Invitation to contribute to a survey on diversity, equity, and inclusion in the UN Decade of Ocean Science by Jul 23rd"
  
  body <- glue(
    "Dear {firstname},

We hope this email finds you well! We wanted to reach out to you since you are a key lead on the Decade Action, {proposal}. We want to understand the strategies, challenges, and opportunities for diverse engagement across Decade Actions. Our very brief survey should take between 5 - 10 minutes to complete, and we would sincerely appreciate your response by Jul 23rd. Please also feel free to pass it along to anyone else who you think can fill it out on behalf of your Decade Action.

We welcome all responses—whether or not your Decade Action is explicitly focused on diversity, equity, and inclusion. Understanding a range of experiences, opportunities, and barriers is essential to shaping inclusive strategies in the Decade.

Thank you in advance for your time and for contributing to a more inclusive and equitable ocean science community!

Best regards,

ECOP DEI Task Team

https://forms.gle/iC4iXNGhx2Ue1TPP8

---

**Background information**

To us, efforts around diversity, equity, and inclusion represent intentional, ongoing efforts to support diverse perspectives, equitable opportunities, and inclusive environments within and beyond ocean professions. 

By taking this short survey, you’re showing support for DEI in the Ocean Decade and helping shape strategies that reflect real experiences—like yours. Your insights can enhance the impact of Decade Actions, and you’ll also have the chance to join a collaborative research paper as a co-author. All responses are anonymous.

If you would like to learn more or become actively involved in the DEI work of the ECOP Programme DEI Task Team, please visit our webpage here."
  )
  
  # Create and send email
  email_message <- gm_mime() %>%
    gm_to(email) %>%
    gm_from("deiecopdecade@gmail.com") %>%
    gm_subject(subject) %>%
    gm_text_body(body)
  
  # Uncomment the line below to send for real
  gm_send_message(email_message)
  
  # Optional: Preview
  print(glue("Prepared email for {firstname} at {email}"))
}




#````




#filter to only first row
contacts_first <- df_cleaned[1, ]
View(contacts_first)




smtp <- server(
  host = "smtp.dreamhost.com",
  port = 465,
  username = "dei@ecopdecade.org",
  password = Sys.getenv("kE?657E?"),
  tls = TRUE
) 

smtp <- server(
  host = "smtp.dreamhost.com",
  port = 587,
  username = "dei@ecopdecade.org",
  password = "kE?657E?",  # replace with secure method in real usage
  tls = TRUE
)

test_email <- envelope() %>%
  from("dei@ecopdecade.org") %>%
  to("esatterthwaite@gmail.com") %>%
  subject("Test email") %>%
  text("This is a quick test from R.")

smtp(test_email, verbose = TRUE)



# Create email template
email_template <- envelope() %>%
  from("dei@ecopdecade.org") %>%
  subject("Invitation to contribute to a survey on diversity, equity, and inclusion in the UN Decade of Ocean Science by Jul 18th")

# Select just the first row for testing
i <- 1
first_name <- contacts_first$first_name[i]
email <- contacts_first$email[i]
action <- contacts_first$decade_action[i]

# Compose personalized email body
body_text <- paste0(
  "Dear ", first_name, ",\n\n",
  "We hope this email finds you well! We wanted to reach out to you since you are a key lead on the Decade Action, ", action, ". ",
  "We want to understand the strategies, challenges, and opportunities for diverse engagement across Decade Actions. ",
  "Our very brief survey should take between 5–10 minutes to complete, and we would sincerely appreciate your response by **July 18th**. ",
  "Please also feel free to pass it along to anyone else who you think can fill it out on behalf of your Decade Action.\n\n",
  "We welcome all responses—whether or not your Decade Action is explicitly focused on diversity, equity, and inclusion. ",
  "Understanding a range of experiences, opportunities, and barriers is essential to shaping inclusive strategies.\n\n",
  "Thank you for your time and for contributing to a more inclusive and equitable ocean science community.\n\n",
  "Best regards,\n\n",
  "ECOP DEI Task Team\n",
  "Survey link: https://forms.gle/iC4iXNGhx2Ue1TPP8"
)

# Build the email message
message <- email_template %>%
  to(email) %>%
  text(body_text)

smtp(message, verbose = TRUE)


