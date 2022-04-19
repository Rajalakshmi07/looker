view: dialogflow_cleaned_logs {
  sql_table_name: `Looker_training_rajalakshmi.dialogflow_cleaned_logs`
    ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: intent_detection_confidence {
    type: number
    sql: ${TABLE}.intent_detection_confidence ;;
  }

  dimension: intent_triggered {
    type: string
    sql: ${TABLE}.intent_triggered ;;
  }

  dimension: is_fallback {
    type: yesno
    sql: ${TABLE}.isFallback ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.language_code ;;
  }

  dimension: magnitude {
    type: number
    sql: ${TABLE}.magnitude ;;
  }

  dimension: month_number {
    type: number
    sql: ${TABLE}.month_number ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}.query_text ;;
  }

  dimension: query_text_redacted {
    type: string
    sql: ${TABLE}.query_text_redacted ;;
  }

  dimension: response_id {
    type: string
    sql: ${TABLE}.response_ID ;;
  }

  dimension: sentiment_score {
    type: number
    sql: ${TABLE}.sentiment_score ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_ID ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.time ;;
  }

  dimension_group: time_stamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      hour_of_day,
      year
    ]
    sql: ${TABLE}.time_stamp ;;
  }

  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
  }

  dimension: sentiment_distribution{
    type: string
    sql:  CASE WHEN ${magnitude} > 3 and ${sentiment_score} between 0.25 and 1 THEN 'Positive'
               WHEN ${magnitude} <= 3 and ${sentiment_score} between 0.25 and 1 THEN 'Partially Positive'
               WHEN ${magnitude} <= 3 and ${sentiment_score} between -1 and -0.25 THEN 'Partially Negative'
               WHEN ${magnitude} > 3 and ${sentiment_score} between -1 and -0.25 THEN 'Negative'
               ELSE "Neutral"
          End;;
  }

  dimension: Sentiment_ordering {
    type: number
    sql:  CASE WHEN ${sentiment_distribution}= 'Negative' THEN 1
               WHEN ${sentiment_distribution}='Partially Negative' THEN 2
               WHEN ${sentiment_distribution}='Partially Positive' THEN 4
               WHEN ${sentiment_distribution}='Positive' THEN 5
               ELSE 3
          END;;
  }
  measure: Avg_Sentiment_Score{
    type: average
    sql: ${TABLE}.sentiment_score ;;
    value_format: "0.##"
  }

  measure: distinct_session_id{
    type: count_distinct
    sql: ${session_id} ;;
  }
  measure: distinct_date{
    type: count_distinct
    sql: ${date_raw} ;;
  }
  measure: Avg_ses_per_day{
    type:number
    sql: ${distinct_session_id}/ NULLIF(${distinct_date},0) ;;
  }
  measure: queries_count{
    type:count_distinct
    sql: ${response_id} ;;
  }
  measure: Avg_Query_per_ses{
    type:number
    sql: ${queries_count}/NULLIF(${distinct_session_id},0) ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
