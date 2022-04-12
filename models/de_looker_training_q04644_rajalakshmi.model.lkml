connection: "de_looker_training_q04644_rajalakshmi"

# include all the views
include: "/views/**/*.view"

datagroup: de_looker_training_q04644_rajalakshmi_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: de_looker_training_q04644_rajalakshmi_default_datagroup

explore: session_level_info {}

explore: dialogflow_cleaned_logs {}
