view: session_level_info {
  sql_table_name: `Looker_training_rajalakshmi.session_level_info`
    ;;

  dimension: entry_intent {
    type: string
    sql: ${TABLE}.entry_intent ;;
  }

  dimension: exit_intent {
    type: string
    sql: ${TABLE}.exit_intent ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.language_code ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: second_last_exit_intent {
    type: string
    sql: ${TABLE}.second_last_exit_intent ;;
  }

  dimension: session_duration {
    type: number
    sql: ${TABLE}.session_duration ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_start ;;
  }

  dimension: minute_timestamp {
    type: number
    sql: floor(${session_start_time},(60*60)/(60)) ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
