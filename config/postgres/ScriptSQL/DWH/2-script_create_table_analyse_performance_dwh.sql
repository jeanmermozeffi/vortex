----------------------------------------------------------------------------------------
----------------- Table de faits temps de traitement : CIC_DWH".traitement" -----------------
----------------------------------------------------------------------------------------

CREATE TABLE "fait_temps_traitements"
(
    "fait_temps_traitements_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "technician_id" INT NOT NULL,
    "processing_time" FLOAT NOT NULL,             -- Temps nécessaire pour traiter la tâche (en heures)
    "target_time" FLOAT NOT NULL,                 -- Temps cible fixé pour traiter la tâche (en heures)
    "time_met" BOOLEAN NOT NULL,                  -- Si le temps a été respecté (Vrai/Faux)
    "sla_compliance_rate" FLOAT,                  -- Taux de respect du SLA (processing_time / target_time)
    "sla_met_rate" FLOAT,                         -- Taux global de SLA respecté (calculé à partir de `time_met`)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    CONSTRAINT "fk_task_fait_temps_traitements" FOREIGN KEY ("task_id") REFERENCES "dim_taches"("dim_taches_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fait_temps_traitements" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_technician_fait_temps_traitements" FOREIGN KEY ("technician_id") REFERENCES "dim_techniciens"("dim_techniciens_id") ON DELETE CASCADE
);

-- Table de faits taux de prise en charge
CREATE TABLE "fact_taux_prise_charge"
(
    "fact_taux_prise_charge_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "tasks_received" INT NOT NULL,                -- Nombre total de tâches reçues
    "tasks_handled" INT NOT NULL,                 -- Nombre de tâches traitées
    "handling_rate" FLOAT NOT NULL,               -- Taux calculé de prise en charge des tâches (tasks_handled / tasks_received)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    CONSTRAINT "fk_task_fact_taux_prise_charge" FOREIGN KEY ("task_id") REFERENCES "dim_taches"("dim_taches_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_taux_prise_charge" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

-- Table de faits délai de coordination des poteaux
CREATE TABLE "fact_delai_coordination_poteaux"
(
    "fact_delai_coordination_poteaux_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "coordination_delay" FLOAT NOT NULL,          -- Temps de coordination des poteaux (en heures)
    "sla_target" FLOAT NOT NULL,                  -- SLA cible fixé pour la coordination (par exemple, 24h)
    "rate" FLOAT,                                 -- Taux de respect du SLA (coordination_delay / sla_target)
    "sla_met" BOOLEAN,                            -- Indicateur si le SLA a été respecté (Vrai/Faux)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    CONSTRAINT "fk_task_fact_delai_coordination_poteaux" FOREIGN KEY ("task_id") REFERENCES "dim_taches"("dim_taches_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_delai_coordination_poteaux" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_planification_tache"
(
    "fact_planification_tache_id" SERIAL PRIMARY KEY NOT NULL,
    "task_id" INT,                   -- Identifiant de la tâche (référence à "dim_task")
    "dim_temps_id" INT,              -- Référence à la date de planification (référence à "dim_time")
    "planning_time" FLOAT,           -- Temps nécessaire pour planifier l’intervention (en heures)
    "target_time" FLOAT,             -- Temps cible fixé pour la planification (48h)
    "sla_met" BOOLEAN,               -- Si le délai de planification a respecté l’objectif (Vrai/Faux)
    "sla_compliance_rate" FLOAT,     -- Taux de respect du SLA (planning_time / target_time)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_task_fact_planification_tache" FOREIGN KEY ("task_id") REFERENCES "dim_task"("task_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_planification_tache" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);


-- Table de faits rendez-vous
CREATE TABLE "fact_prise_rendez_vous"
(
    "fact_rise_prendez_vous_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_taches_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "appointment_time" FLOAT NOT NULL,           -- Temps réel pris pour prendre le rendez-vous (en heures)
    "target_time" FLOAT NOT NULL,                -- Temps cible fixé pour la prise de rendez-vous (en heures, par exemple 4h)
    "sla_met" BOOLEAN,                           -- Indicateur si le SLA a été respecté (TRUE/FALSE)
    "sla_compliance_rate" FLOAT,                -- Taux de respect du SLA (appointment_time / target_time)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    CONSTRAINT "fk_task_fact_prise_rendez_vous" FOREIGN KEY ("dim_taches_id") REFERENCES "dim_taches"("dim_taches_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_prise_rendez_vous" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

-- Table de faits respect des délais
CREATE TABLE "fact_respect_delais"
(
    "fact_respect_delais_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_taches_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "technician_id" INT NOT NULL,
    "tasks_completed_on_time" INT NOT NULL,   -- Nombre de tâches terminées dans les délais
    "tasks_total" INT NOT NULL,               -- Nombre total de tâches
    "on_time_rate" FLOAT NOT NULL,            -- Taux de respect des délais (tasks_completed_on_time / tasks_total)
    "sla_met" BOOLEAN,                        -- Indicateur si le SLA a été respecté (TRUE/FALSE)
    "rate" FLOAT,                             -- Taux global de respect des délais (tasks_completed_on_time / tasks_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    CONSTRAINT "fk_task_fact_respect_delais" FOREIGN KEY ("dim_taches_id") REFERENCES "dim_taches"("dim_taches_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_respect_delais" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_technician_fact_respect_delais" FOREIGN KEY ("technician_id") REFERENCES "dim_techniciens"("dim_techniciens_id") ON DELETE CASCADE
);


