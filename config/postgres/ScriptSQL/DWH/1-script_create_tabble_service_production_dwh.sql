CREATE TABLE "fact_temps"
(
    "fact_temps_id" SERIAL PRIMARY KEY NOT NULL,          -- Identifiant unique de la période de temps
    "dim_temps_id" INT NOT NULL,                                   -- Référence à la date (clé étrangère vers `dim_time`)
    "tasks_received" INT,                                 -- Nombre total de tâches reçues
    "tasks_completed" INT,                                -- Nombre total de tâches traitées
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_time_fact_temps" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_work_realization"
(
    "fact_work_realization_id" SERIAL PRIMARY KEY NOT NULL,  -- Identifiant unique de la réalisation
    "dim_temps_id" INT NOT NULL,                                      -- Référence à la date de réalisation (référence à `dim_time`)
    "project_id" INT NOT NULL,                                       -- Référence au projet lié à la réalisation (référence à `dim_project`)
    "technician_id" INT NOT NULL,                                    -- Référence au technicien en charge du projet (référence à `dim_technician`)
    "gc_type" VARCHAR(10),                                  -- Type de génie civil ("GC" pour avec génie civil, "non_GC" pour sans génie civil)
    "realisation_days" INT,                                 -- Nombre de jours nécessaires pour réaliser les travaux
    "sla_target" INT,                                       -- SLA fixé pour la réalisation des travaux
    "days_to_realize" INT,                                  -- Nombre de jours pris pour réaliser les travaux
    "sla_met" BOOLEAN,                                      -- Si le SLA a été respecté (Oui/Non)
    "project_status" VARCHAR(50),                           -- Statut du projet (complété, en retard, etc.)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_time_fact_work_realization" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_project_fact_work_realization" FOREIGN KEY ("project_id") REFERENCES "dim_project"("project_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_technician_fact_work_realization" FOREIGN KEY ("technician_id") REFERENCES "dim_technician"("technician_id") ON DELETE CASCADE
);

CREATE TABLE "fact_installation"
(
    "fact_installation_id" SERIAL PRIMARY KEY NOT NULL,   -- Identifiant unique de l'installation
    "client_id" INT NOT NULL,                                      -- Référence au client (clé étrangère vers `dim_client`)
    "dim_temps_id" INT NOT NULL,                                   -- Référence à la date de l'installation (clé étrangère vers `dim_time`)
    "installs_successful" INT,                            -- Nombre d'installations réussies
    "installations_total" INT,                            -- Nombre total d'installations
    "quality_rate" FLOAT,                                 -- Taux de qualité des installations (installs_successful / installations_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_client_fact_installation" FOREIGN KEY ("client_id") REFERENCES "dim_client"("client_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_installation" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);


CREATE TABLE "fact_intervention"
(
    "fact_intervention_id" SERIAL PRIMARY KEY NOT NULL,   -- Identifiant unique de l'intervention
    "technician_id" INT NOT NULL,                                  -- Référence au technicien (clé étrangère vers `dim_technician`)
    "dim_temps_id" INT NOT NULL,                                   -- Référence à la date de l'intervention (clé étrangère vers `dim_time`)
    "tasks_completed" INT,                                -- Nombre de tâches effectuées
    "tasks_total" INT,                                    -- Nombre total de tâches
    "efficiency_rate" FLOAT,                              -- Taux d'efficacité des interventions (tasks_completed / tasks_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_technician_fact_intervention" FOREIGN KEY ("technician_id") REFERENCES "dim_technician"("technician_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_intervention" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

