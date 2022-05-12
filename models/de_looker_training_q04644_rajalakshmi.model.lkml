connection: "de_looker_training_q04644_rajalakshmi"

# include all the views
include: "/views/**/*.view"

datagroup: de_looker_training_q04644_rajalakshmi_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: de_looker_training_q04644_rajalakshmi_default_datagroup

explore: session_level_info {}

explore: dialogflow_cleaned_logs {
  join: time_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dialogflow_cleaned_logs.session_id}=${time_view.session_id}  ;;
  }
  join: deflection {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dialogflow_cleaned_logs.session_id}=${deflection.session_id}  ;;
  }
  join: intent_level_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dialogflow_cleaned_logs.intent_triggered} != ${intent_level_view.intents}
    and
    ${dialogflow_cleaned_logs.session_id}=${intent_level_view.session_id};;
  }
}
