CREATE TABLE "fact_intervention_quality"
(
    "fact_intervention_quality_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,           -- Identifiant de la tâche (référence à `dim_tache`)
    "dim_temps_id" INT NOT NULL,      -- Référence à la date de l'intervention (référence à `dim_temps`)
    "compliant_interventions" INT,    -- Nombre d'interventions conformes
    "total_interventions" INT,        -- Nombre total d'interventions
    "conformity_rate" FLOAT,          -- Taux de conformité des interventions (compliant_interventions / total_interventions)
    "rate" FLOAT,                     -- Taux calculé de conformité
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_task_fact_intervention_quality" FOREIGN KEY ("task_id") REFERENCES "dim_task"("task_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_intervention_quality" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_case_resolution"
(
    "fact_case_resolution_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "cases_resolved" INT,    -- Nombre de dossiers résolus
    "total_cases" INT,       -- Nombre total de dossiers
    "resolution_rate" FLOAT, -- Taux de résolution des dossiers (cases_resolved / total_cases)
    "rate" FLOAT,            -- Taux calculé de résolution des dossiers
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_task_fact_case_resolution" FOREIGN KEY ("task_id") REFERENCES "dim_task"("task_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_case_resolution" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_daily_cases_handled"
(
    "fact_daily_cases_handled_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "cases_handled_per_day" INT,  -- Nombre de dossiers traités par jour
    "assigned_cases" INT,         -- Nombre total de dossiers assignés
    "average_cases_per_day" FLOAT, -- Moyenne des dossiers traités par jour par technicien
    "handling_rate" FLOAT,         -- Taux de productivité des techniciens
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_task_fact_daily_cases_handled" FOREIGN KEY ("task_id") REFERENCES "dim_task"("task_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_daily_cases_handled" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_recovery_delay"
(
    "fact_recovery_delay_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "recovery_time" FLOAT,  -- Temps de rétablissement des services (en heures)
    "sla_target" INT,       -- SLA cible fixé pour le rétablissement (par exemple, 24h)
    "sla_met" BOOLEAN,      -- Indicateur si le SLA a été respecté (Vrai/Faux)
    "sla_compliance_rate" FLOAT,  -- Taux de respect du SLA (recovery_time / sla_target)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_task_fact_recovery_delay" FOREIGN KEY ("task_id") REFERENCES "dim_task"("task_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_recovery_delay" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_incident_processing"
(
    "fact_incident_processing_id" SERIAL PRIMARY KEY NOT NULL,
    "incident_id" INT,
    "dim_temps_id" INT NOT NULL,
    "resolution_time" FLOAT,          -- Temps de résolution de l'incident (en heures)
    "sla_target" INT,                 -- SLA cible fixé pour l'incident (par exemple, 4h pour P1, 24h pour P2)
    "sla_met" BOOLEAN,                -- Indicateur si le SLA a été respecté (Vrai/Faux)
    "incident_priority" VARCHAR(10),  -- Priorité de l'incident ("P1" ou "P2")
    "sla_compliance_rate" FLOAT,      -- Taux de respect du SLA pour l'incident (resolution_time / sla_target)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_incident_fact_incident_processing" FOREIGN KEY ("incident_id") REFERENCES "dim_incident"("incident_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_incident_processing" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

-- CREATE TABLE "fact_incident_processing_p2"
-- (
--     "fact_incident_processing_p2_id" SERIAL PRIMARY KEY NOT NULL,
--     "incident_id" INT,
--     "dim_temps_id" INT NOT NULL,
--     "resolution_time" FLOAT,
--     "sla_target" INT,
--     "sla_met" BOOLEAN,
--     "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
--     "updated_at" TIMESTAMP,
--     "lb_job_name" VARCHAR(100),
--     "bl_ligne_active" BOOLEAN,
--     CONSTRAINT "fk_dim_incident" FOREIGN KEY ("incident_id") REFERENCES "dim_incident"("incident_id") ON DELETE CASCADE,
--     CONSTRAINT "fk_dim_time" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
-- );
--
-- CREATE TABLE "fact_incident_processing_p1"
-- (
--     "fact_incident_processing_p1_id" SERIAL PRIMARY KEY NOT NULL,
--     "incident_id" INT,
--     "dim_temps_id" INT NOT NULL,
--     "resolution_time" FLOAT,
--     "sla_target" INT,
--     "sla_met" BOOLEAN,
--     "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
--     "updated_at" TIMESTAMP,
--     "lb_job_name" VARCHAR(100),
--     "bl_ligne_active" BOOLEAN,
--     CONSTRAINT "fk_dim_incident" FOREIGN KEY ("incident_id") REFERENCES "dim_incident"("incident_id") ON DELETE CASCADE,
--     CONSTRAINT "fk_dim_time" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
-- );


