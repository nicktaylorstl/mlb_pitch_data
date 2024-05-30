with source as(

    SELECT
        pitch_index,
        game_id,
        atbat_id,
        pitch_id,
        original_date,
        official_date,
        day_night,
        time,
        home_team,
        away_team,
        umpire as umpire_name,
        result_type,
        result_event, 
        result_description,
        home_score,
        away_score,
        inning,
        half_inning,
        batter_team,
        batter_name,
        batter_id,
        batter_hand,
        pitcher_team,
        pitcher_name,
        pitcher_id,
        pitcher_hand,
        call_code,
        call_description,
        is_in_play,
        is_out,
        is_strike,
        is_ball,
        pitch_type,
        pitch_type_code,
        pitch_start_speed,
        pitch_end_speed,
        strike_zone_top,
        strike_zone_bottom,
        -0.70833333333 as strike_zone_left,
        0.70833333333 as strike_zone_right,
        CASE
            WHEN (pX <= 0.70833333333 AND pX >= -0.70833333333 AND pZ >= strike_zone_bottom AND pZ <= strike_zone_top)
            THEN TRUE
            ELSE FALSE
        END AS true_strike,


        zone,
        type_confidence,
        plate_time,
        extension,
        aX,
        aY,
        aZ,
        pfxX,
        pfxZ,
        pX,
        pZ,
        vX0,
        vY0,
        vZ0,
        x,
        y,
        x0,
        y0,
        z0,
        breakAngle as break_angle,
        breakLength as break_length,
        breakY as break_y,
        breakVertical as break_vertical,
        breakVerticalInduced as break_vertical_induced, 
        breakHorizontal as break_horizontal,
        spinRate as spin_rate,
        spinDirection as spin_direction,
        launch_angle,
        launch_speed,
        distance,
        trajectory,
        hardness,
        location,
        hitX as hit_x,
        hitY as hit_y


    FROM `mlb-data-2024`.`mlb_data_2024`.`pitch_data`)

    SELECT *,
        CASE
        WHEN ((true_strike and call_code = "C") or (NOT true_strike and call_code = "B" ))
        THEN TRUE
        WHEN ((true_strike and call_code = "B") or (NOT true_strike and call_code = "C" ))
        THEN FALSE
        ELSE NULL
    END AS call_correct

    FROM source
