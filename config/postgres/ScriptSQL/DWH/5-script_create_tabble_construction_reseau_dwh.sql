CREATE TABLE "fact_evolution_backlog"
(
    "fact_evolution_backlog_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_projet_id" INT NOT NULL,                   -- Identifiant du projet
    "dim_temps_id" INT NOT NULL,                    -- Référence à la date
    "backlog_in_progress" INT,                      -- Nombre de dossiers en cours
    "backlog_suspended" INT,                        -- Nombre de dossiers suspendus
    "backlog_in_study" INT,                         -- Nombre de dossiers en étude
    "backlog_total" INT,                            -- Nombre total de dossiers
    "completed_tasks" INT,                          -- Nombre de tâches complétées
    "backlog_remaining" INT,                        -- Nombre de dossiers restants
    "progress_rate" FLOAT,                          -- Taux de progression des dossiers (completed_tasks / backlog_total)
    "objective_target" INT,                         -- Objectif de traitement
    "sla_met" BOOLEAN,                              -- Si le SLA a été respecté
    "rate" FLOAT,                                   -- Taux global de respect du SLA
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet_fact_evolution_backlog" FOREIGN KEY ("dim_projet_id") REFERENCES "dim_projet" ("dim_projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_evolution_backlog" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps" ("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_gestion_equipes"
(
    "fact_gestion_equipes_id" SERIAL PRIMARY KEY NOT NULL,
    "team_id" INT,                                  -- Identifiant de l'équipe
    "dim_temps_id" INT NOT NULL,                    -- Référence à la date
    "teams_available" INT,                          -- Nombre d’équipes disponibles
    "teams_total" INT,                              -- Nombre total d’équipes
    "availability_rate" FLOAT,                       -- Taux de disponibilité des équipes (teams_available / teams_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_equipe_fact_gestion_equipes" FOREIGN KEY ("team_id") REFERENCES "dim_equipe"("team_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_gestion_equipes" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_realisation_dossiers"
(
    "fact_realisation_dossiers_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_projet_id" INT NOT NULL,                  -- Référence au projet
    "dim_temps_id" INT NOT NULL,                   -- Référence à la date
    "tasks_realized" INT,                          -- Nombre de tâches réalisées
    "tasks_target" INT,                            -- Nombre de tâches cibles
    "realization_rate" FLOAT,                      -- Taux de réalisation (tasks_realized / tasks_target)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet_fact_realisation_dossiers" FOREIGN KEY ("dim_projet_id") REFERENCES "dim_projet"("dim_projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_realisation_dossiers" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_atteinte_objectifs"
(
    "fact_atteinte_objectifs_id" SERIAL PRIMARY KEY NOT NULL,
    "team_id" INT,                                 -- Référence à l’équipe
    "dim_temps_id" INT NOT NULL,                   -- Référence à la date
    "objectives_achieved" INT,                     -- Nombre d'objectifs atteints
    "objectives_total" INT,                        -- Nombre total d'objectifs
    "achievement_rate" FLOAT,                      -- Taux de réalisation des objectifs (objectives_achieved / objectives_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_equipe_fact_atteinte_objectifs" FOREIGN KEY ("team_id") REFERENCES "dim_equipe"("team_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_atteinte_objectifs" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_traitement_dossiers"
(
    "fact_traitement_dossiers_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_projet_id" INT NOT NULL,                   -- Référence au projet
    "dim_temps_id" INT NOT NULL,                    -- Référence à la date
    "processing_time" FLOAT,                        -- Temps de traitement du dossier
    "sla_met" BOOLEAN,                              -- Si le SLA a été respecté
    "sla_target" FLOAT,                             -- SLA cible fixé pour le traitement
    "sla_compliance_rate" FLOAT,                    -- Taux de respect du SLA (processing_time / sla_target)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet_fact_traitement_dossiers" FOREIGN KEY ("dim_projet_id") REFERENCES "dim_projet"("dim_projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_traitement_dossiers" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);


